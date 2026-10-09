import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' as d;
import 'package:clinic_q/features/doctor/domain/entities/available_date_entity.dart';
import 'package:clinic_q/features/doctor/domain/entities/specialty_entity.dart';
import 'package:clinic_q/features/clinic/data/local/clinic_local_data_source.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/exception_mapper.dart';
import '../../../../core/local/app_database.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../local/doctor_local_data_source.dart';
import '../services/doctor_api_service.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorApiService _apiService;
  final DoctorLocalDataSource _localDataSource;
  final ClinicLocalDataSource? _clinicLocalDataSource;

  DoctorRepositoryImpl(
    this._apiService,
    this._localDataSource, [
    this._clinicLocalDataSource,
  ]);

  Future<List<DoctorEntity>> _enrichWithClinicNames(
    List<DoctorEntity> doctors,
  ) async {
    if (doctors.isEmpty || _clinicLocalDataSource == null) return doctors;
    try {
      final cachedClinics = await _clinicLocalDataSource.getCachedClinics();
      if (cachedClinics.isEmpty) return doctors;
      final clinicMap = {
        for (final c in cachedClinics) c.id: c.name,
      };

      return doctors.map((doc) {
        if ((doc.clinicName.isEmpty ||
                doc.clinicName == 'Clinic' ||
                doc.clinicName.startsWith('Clinic ')) &&
            doc.clinicId != null &&
            clinicMap.containsKey(doc.clinicId)) {
          return doc.copyWith(clinicName: clinicMap[doc.clinicId]!);
        }
        return doc;
      }).toList();
    } catch (_) {
      return doctors;
    }
  }

  Future<DoctorEntity?> _enrichSingleDoctor(DoctorEntity? doctor) async {
    if (doctor == null || _clinicLocalDataSource == null) return doctor;
    if (doctor.clinicName.isNotEmpty &&
        doctor.clinicName != 'Clinic' &&
        !doctor.clinicName.startsWith('Clinic ')) {
      return doctor;
    }
    if (doctor.clinicId == null) return doctor;
    try {
      final clinic = await _clinicLocalDataSource.getCachedClinicById(
        doctor.clinicId!,
      );
      if (clinic != null && clinic.name.isNotEmpty) {
        return doctor.copyWith(clinicName: clinic.name);
      }
    } catch (_) {}
    return doctor;
  }

  bool _isCacheValid(DateTime? cachedAt) {
    if (cachedAt == null) return false;
    final now = DateTime.now();
    final difference = now.difference(cachedAt);
    return difference.inHours < 24;
  }

  @override
  Future<List<DoctorEntity>> getInterestedDoctors({
    bool forceRefresh = false,
  }) async {
    try {
      final networkDocs = await _apiService.getInterestedDoctors();
      final companions = networkDocs.map((d) => _toDriftCompanion(d)).toList();
      await _localDataSource.upsertDoctors(companions);
      debugPrint(
        '[DoctorRepository] Fetched interested doctors from NETWORK and updated cache — ${networkDocs.length} items',
      );
      return await _enrichWithClinicNames(networkDocs);
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint(
        '[DoctorRepository] NETWORK failed (interested doctors) — falling back to CACHE: $appEx',
      );

      final cachedRows = await _localDataSource.getCachedDoctors();
      if (cachedRows.isNotEmpty) {
        var cachedEntities = cachedRows.map((r) => _fromDriftData(r)).toList()
          ..sort((a, b) => b.rating.compareTo(a.rating));
        var filtered = cachedEntities
            .where((doc) => doc.isInterested || doc.rating >= 4.5)
            .toList();
        if (filtered.isEmpty) {
          filtered = cachedEntities.take(5).toList();
        }

        final flagged = filtered
            .map(
              (doc) =>
                  doc.copyWith(isFromCache: true, cacheError: appEx.message),
            )
            .toList();
        final cachedAtTime = cachedRows.first.cachedAt.toIso8601String();
        debugPrint(
          '[DoctorRepository] Returned ${flagged.length} interested items from CACHE (cachedAt: $cachedAtTime)',
        );
        return await _enrichWithClinicNames(flagged);
      }
      throw appEx;
    }
  }

  @override
  Future<List<DoctorEntity>> getAllDoctors({
    String? query,
    Map<String, dynamic>? filters,
    bool forceRefresh = false,
  }) async {
    final specialtiesList = filters?['specialties'] as List<String>?;
    final specialization =
        (specialtiesList != null && specialtiesList.isNotEmpty)
        ? specialtiesList.first
        : (filters?['specialization'] as String? ??
              filters?['specialty'] as String?);
    final clinicId =
        filters?['clinicId'] as String? ?? filters?['clinic_id'] as String?;

    final hasActiveFilter =
        (specialtiesList != null && specialtiesList.isNotEmpty) ||
        (specialization != null && specialization.trim().isNotEmpty) ||
        (clinicId != null && clinicId.trim().isNotEmpty) ||
        (query != null && query.trim().isNotEmpty);

    final cachedRows = await _localDataSource.getCachedDoctors();
    if (!forceRefresh &&
        !hasActiveFilter &&
        cachedRows.isNotEmpty &&
        _isCacheValid(cachedRows.first.cachedAt)) {
      debugPrint(
        '[DoctorRepository] All doctors cache is fresh (<24h) — serving from CACHE',
      );
      final list = cachedRows.map((r) => _fromDriftData(r)).toList();
      return await _enrichWithClinicNames(list);
    }

    try {
      final networkDocs = await _apiService.getAllDoctors(
        clinicId: clinicId,
        specialization: (specialtiesList != null && specialtiesList.length == 1)
            ? specialization
            : null,
        search: query,
      );

      if (!hasActiveFilter) {
        final companions = networkDocs
            .map((d) => _toDriftCompanion(d))
            .toList();
        await _localDataSource.upsertDoctors(companions);
        debugPrint(
          '[DoctorRepository] Fetched all doctors from NETWORK and updated cache — ${networkDocs.length} items',
        );
      }

      var results = networkDocs;
      if (specialtiesList != null && specialtiesList.isNotEmpty) {
        results = results
            .where(
              (doc) => specialtiesList.any(
                (s) => s.toLowerCase() == doc.specialty.toLowerCase(),
              ),
            )
            .toList();
      }
      return await _enrichWithClinicNames(results);
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint(
        '[DoctorRepository] NETWORK failed (all doctors) — falling back to CACHE: $appEx',
      );

      if (cachedRows.isNotEmpty) {
        var cachedEntities = cachedRows.map((r) => _fromDriftData(r)).toList();

        // Perform client-side filter
        if (clinicId != null && clinicId.trim().isNotEmpty) {
          cachedEntities = cachedEntities
              .where((doc) => doc.clinicId == clinicId)
              .toList();
        }
        if (specialtiesList != null && specialtiesList.isNotEmpty) {
          cachedEntities = cachedEntities
              .where(
                (doc) => specialtiesList.any(
                  (s) => s.toLowerCase() == doc.specialty.toLowerCase(),
                ),
              )
              .toList();
        } else if (specialization != null && specialization.trim().isNotEmpty) {
          final querySpec = specialization.trim().toLowerCase();
          cachedEntities = cachedEntities
              .where((doc) => doc.specialty.toLowerCase() == querySpec)
              .toList();
        }
        if (query != null && query.trim().isNotEmpty) {
          final querySearch = query.trim().toLowerCase();
          cachedEntities = cachedEntities
              .where(
                (doc) =>
                    doc.name.toLowerCase().contains(querySearch) ||
                    doc.specialty.toLowerCase().contains(querySearch) ||
                    (doc.qualification != null &&
                        doc.qualification!.toLowerCase().contains(querySearch)),
              )
              .toList();
        }

        if (cachedEntities.isNotEmpty) {
          final flagged = cachedEntities
              .map(
                (doc) =>
                    doc.copyWith(isFromCache: true, cacheError: appEx.message),
              )
              .toList();
          final cachedAtTime = cachedRows.first.cachedAt.toIso8601String();
          debugPrint(
            '[DoctorRepository] Returned ${flagged.length} items from CACHE (cachedAt: $cachedAtTime)',
          );
          return await _enrichWithClinicNames(flagged);
        }
      }
      throw appEx;
    }
  }

  @override
  Future<DoctorEntity?> getDoctorById(
    String id, {
    bool forceRefresh = false,
  }) async {
    final cachedRow = await _localDataSource.getCachedDoctorById(id);
    if (!forceRefresh &&
        cachedRow != null &&
        _isCacheValid(cachedRow.cachedAt)) {
      debugPrint(
        '[DoctorRepository] Doctor $id cache is fresh (<24h) — serving from CACHE',
      );
      final entity = _fromDriftData(cachedRow);
      return await _enrichSingleDoctor(entity);
    }

    try {
      final networkDoc = await _apiService.getDoctorById(id);
      if (networkDoc != null) {
        await _localDataSource.upsertDoctors([_toDriftCompanion(networkDoc)]);
        debugPrint(
          '[DoctorRepository] Fetched doctor $id from NETWORK and updated cache',
        );
      }
      return await _enrichSingleDoctor(networkDoc);
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint(
        '[DoctorRepository] NETWORK failed (getDoctorById) — falling back to CACHE',
      );

      if (cachedRow != null) {
        final entity = _fromDriftData(
          cachedRow,
        ).copyWith(isFromCache: true, cacheError: appEx.message);
        debugPrint(
          '[DoctorRepository] Returned doctor $id from CACHE (cachedAt: ${cachedRow.cachedAt.toIso8601String()})',
        );
        return await _enrichSingleDoctor(entity);
      }
      throw appEx;
    }
  }

  @override
  Future<List<SpecialtyEntity>> getSpecialties({
    bool forceRefresh = false,
  }) async {
    // Keep dynamic fetch as specified
    return await _apiService.getSpecialties();
  }

  @override
  Future<List<DoctorEntity>> getDoctorsByClinic(
    String clinicId, {
    bool forceRefresh = false,
  }) async {
    final cachedRows = await _localDataSource.getCachedDoctors();
    final freshRows = cachedRows
        .where((r) => r.clinicId == clinicId && _isCacheValid(r.cachedAt))
        .toList();
    if (!forceRefresh && freshRows.isNotEmpty) {
      debugPrint(
        '[DoctorRepository] Clinic $clinicId doctors cache is fresh (<24h) — serving from CACHE',
      );
      final list = freshRows.map((r) => _fromDriftData(r)).toList();
      return await _enrichWithClinicNames(list);
    }

    try {
      final networkDocs = await _apiService.getDoctorsByClinic(clinicId);
      final companions = networkDocs.map((d) => _toDriftCompanion(d)).toList();
      await _localDataSource.upsertDoctors(companions);
      debugPrint(
        '[DoctorRepository] Fetched doctors for clinic $clinicId from NETWORK and updated cache — ${networkDocs.length} items',
      );
      return await _enrichWithClinicNames(networkDocs);
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint(
        '[DoctorRepository] NETWORK failed (getDoctorsByClinic) — falling back to CACHE',
      );

      if (cachedRows.isNotEmpty) {
        final filtered = cachedRows
            .map((r) => _fromDriftData(r))
            .where((doc) => doc.clinicId == clinicId)
            .map(
              (doc) =>
                  doc.copyWith(isFromCache: true, cacheError: appEx.message),
            )
            .toList();

        if (filtered.isNotEmpty) {
          debugPrint(
            '[DoctorRepository] Returned ${filtered.length} clinic-linked items from CACHE',
          );
          return filtered;
        }
      }
      throw appEx;
    }
  }

  @override
  Future<List<AvailableDateEntity>> getAvailableDates(String doctorId) async {
    try {
      final dates = await _apiService.getAvailableDates(doctorId);
      debugPrint(
        '[DoctorRepository] Fetched ${dates.length} available dates for doctorId=$doctorId from NETWORK',
      );
      return dates;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint(
        '[DoctorRepository] Failed to fetch available dates for doctorId=$doctorId: $appEx',
      );
      throw appEx;
    }
  }

  DoctorsTableCompanion _toDriftCompanion(DoctorEntity entity) {
    return DoctorsTableCompanion(
      id: d.Value(entity.id),
      clinicId: d.Value(entity.clinicId),
      name: d.Value(entity.name),
      qualification: d.Value(entity.qualification),
      experience: d.Value(entity.experience),
      specialty: d.Value(entity.specialty),
      price: d.Value(entity.price),
      durationMinutes: d.Value(entity.durationMinutes),
      workingDays: d.Value(entity.workingDays.join(',')),
      startTime: d.Value(entity.startTime),
      endTime: d.Value(entity.endTime),
      maxTokensPerDay: d.Value(entity.maxTokensPerDay),
      rating: d.Value(entity.rating),
      photoUrl: d.Value(entity.photoUrl),
      clinicName: d.Value(entity.clinicName),
      reviewCount: d.Value(entity.reviewCount),
      isInterested: d.Value(entity.isInterested),
      isAvailable: d.Value(entity.isAvailable),
      about: d.Value(entity.about),
      location: d.Value(entity.location),
      cachedAt: d.Value(DateTime.now()),
    );
  }

  DoctorEntity _fromDriftData(DoctorsTableData r) {
    return DoctorEntity(
      id: r.id,
      name: r.name,
      specialty: r.specialty,
      clinicName: r.clinicName,
      photoUrl: r.photoUrl,
      rating: r.rating,
      reviewCount: r.reviewCount,
      price: r.price,
      durationMinutes: r.durationMinutes,
      isInterested: r.isInterested,
      isAvailable: r.isAvailable,
      about: r.about,
      location: r.location,
      clinicId: r.clinicId,
      qualification: r.qualification,
      experience: r.experience,
      workingDays: r.workingDays != null && r.workingDays!.isNotEmpty
          ? r.workingDays!.split(',')
          : const [],
      startTime: r.startTime,
      endTime: r.endTime,
      maxTokensPerDay: r.maxTokensPerDay,
    );
  }
}