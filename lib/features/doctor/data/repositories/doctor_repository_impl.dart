import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' as d;
import 'package:clinic_q/features/doctor/domain/entities/specialty_entity.dart';

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

  DoctorRepositoryImpl(this._apiService, this._localDataSource);

  bool _isCacheValid(DateTime? cachedAt) {
    if (cachedAt == null) return false;
    final now = DateTime.now();
    final difference = now.difference(cachedAt);
    return difference.inHours < 24;
  }

  @override
  Future<List<DoctorEntity>> getInterestedDoctors() async {
    final cachedRows = await _localDataSource.getCachedDoctors();
    if (cachedRows.isNotEmpty && _isCacheValid(cachedRows.first.cachedAt)) {
      debugPrint('[DoctorRepository] Interested doctors cache is fresh (<24h) — serving from CACHE');
      final cachedEntities = cachedRows.map((r) => _fromDriftData(r)).toList();
      var filtered = cachedEntities.where((doc) => doc.isInterested || doc.rating >= 4.8).toList();
      if (filtered.isEmpty) {
        filtered = cachedEntities.take(3).toList();
      }
      return filtered;
    }

    try {
      final networkDocs = await _apiService.getInterestedDoctors();
      final companions = networkDocs.map((d) => _toDriftCompanion(d)).toList();
      await _localDataSource.upsertDoctors(companions);
      debugPrint('[DoctorRepository] Fetched interested doctors from NETWORK — ${networkDocs.length} items');
      return networkDocs;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint('[DoctorRepository] NETWORK failed (interested doctors) — falling back to CACHE: $appEx');

      if (cachedRows.isNotEmpty) {
        var cachedEntities = cachedRows.map((r) => _fromDriftData(r)).toList();
        var filtered = cachedEntities.where((doc) => doc.isInterested || doc.rating >= 4.8).toList();
        if (filtered.isEmpty) {
          filtered = cachedEntities.take(3).toList();
        }

        final flagged = filtered.map((doc) => doc.copyWith(isFromCache: true, cacheError: appEx.message)).toList();
        final cachedAtTime = cachedRows.first.cachedAt.toIso8601String();
        debugPrint('[DoctorRepository] Returned ${flagged.length} interested items from CACHE (cachedAt: $cachedAtTime)');
        return flagged;
      }
      throw appEx;
    }
  }

  @override
  Future<List<DoctorEntity>> getAllDoctors({
    String? query,
    Map<String, dynamic>? filters,
  }) async {
    final specialization = filters?['specialization'] as String? ?? filters?['specialty'] as String?;
    final clinicId = filters?['clinicId'] as String? ?? filters?['clinic_id'] as String?;

    final cachedRows = await _localDataSource.getCachedDoctors();
    if (cachedRows.isNotEmpty && _isCacheValid(cachedRows.first.cachedAt)) {
      debugPrint('[DoctorRepository] All doctors cache is fresh (<24h) — serving from CACHE');
      var cachedEntities = cachedRows.map((r) => _fromDriftData(r)).toList();

      // Perform client-side filter
      if (clinicId != null && clinicId.trim().isNotEmpty) {
        cachedEntities = cachedEntities.where((doc) => doc.clinicId == clinicId).toList();
      }
      if (specialization != null && specialization.trim().isNotEmpty) {
        final querySpec = specialization.trim().toLowerCase();
        cachedEntities = cachedEntities.where((doc) => doc.specialty.toLowerCase() == querySpec).toList();
      }
      if (query != null && query.trim().isNotEmpty) {
        final querySearch = query.trim().toLowerCase();
        cachedEntities = cachedEntities.where((doc) =>
            doc.name.toLowerCase().contains(querySearch) ||
            doc.specialty.toLowerCase().contains(querySearch) ||
            (doc.qualification != null && doc.qualification!.toLowerCase().contains(querySearch))).toList();
      }

      return cachedEntities;
    }

    try {
      final networkDocs = await _apiService.getAllDoctors(
        clinicId: clinicId,
        specialization: specialization,
        search: query,
      );

      final companions = networkDocs.map((d) => _toDriftCompanion(d)).toList();
      await _localDataSource.upsertDoctors(companions);
      debugPrint('[DoctorRepository] Fetched all doctors from NETWORK — ${networkDocs.length} items');
      return networkDocs;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint('[DoctorRepository] NETWORK failed (all doctors) — falling back to CACHE: $appEx');

      if (cachedRows.isNotEmpty) {
        var cachedEntities = cachedRows.map((r) => _fromDriftData(r)).toList();

        // Perform client-side filter
        if (clinicId != null && clinicId.trim().isNotEmpty) {
          cachedEntities = cachedEntities.where((doc) => doc.clinicId == clinicId).toList();
        }
        if (specialization != null && specialization.trim().isNotEmpty) {
          final querySpec = specialization.trim().toLowerCase();
          cachedEntities = cachedEntities.where((doc) => doc.specialty.toLowerCase() == querySpec).toList();
        }
        if (query != null && query.trim().isNotEmpty) {
          final querySearch = query.trim().toLowerCase();
          cachedEntities = cachedEntities.where((doc) =>
              doc.name.toLowerCase().contains(querySearch) ||
              doc.specialty.toLowerCase().contains(querySearch) ||
              (doc.qualification != null && doc.qualification!.toLowerCase().contains(querySearch))).toList();
        }

        if (cachedEntities.isNotEmpty) {
          final flagged = cachedEntities.map((doc) => doc.copyWith(isFromCache: true, cacheError: appEx.message)).toList();
          final cachedAtTime = cachedRows.first.cachedAt.toIso8601String();
          debugPrint('[DoctorRepository] Returned ${flagged.length} items from CACHE (cachedAt: $cachedAtTime)');
          return flagged;
        }
      }
      throw appEx;
    }
  }

  @override
  Future<DoctorEntity?> getDoctorById(String id) async {
    final cachedRow = await _localDataSource.getCachedDoctorById(id);
    if (cachedRow != null && _isCacheValid(cachedRow.cachedAt)) {
      debugPrint('[DoctorRepository] Doctor $id cache is fresh (<24h) — serving from CACHE');
      return _fromDriftData(cachedRow);
    }

    try {
      final networkDoc = await _apiService.getDoctorById(id);
      if (networkDoc != null) {
        await _localDataSource.upsertDoctors([_toDriftCompanion(networkDoc)]);
        debugPrint('[DoctorRepository] Fetched doctor $id from NETWORK');
      }
      return networkDoc;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint('[DoctorRepository] NETWORK failed (getDoctorById) — falling back to CACHE');

      if (cachedRow != null) {
        final entity = _fromDriftData(cachedRow).copyWith(isFromCache: true, cacheError: appEx.message);
        debugPrint('[DoctorRepository] Returned doctor $id from CACHE (cachedAt: ${cachedRow.cachedAt.toIso8601String()})');
        return entity;
      }
      throw appEx;
    }
  }

  @override
  Future<List<SpecialtyEntity>> getSpecialties() async {
    // Keep dynamic fetch as specified
    return await _apiService.getSpecialties();
  }

  @override
  Future<List<DoctorEntity>> getDoctorsByClinic(String clinicId) async {
    final cachedRows = await _localDataSource.getCachedDoctors();
    final freshRows = cachedRows.where((r) => r.clinicId == clinicId && _isCacheValid(r.cachedAt)).toList();
    if (freshRows.isNotEmpty) {
      debugPrint('[DoctorRepository] Clinic $clinicId doctors cache is fresh (<24h) — serving from CACHE');
      return freshRows.map((r) => _fromDriftData(r)).toList();
    }

    try {
      final networkDocs = await _apiService.getDoctorsByClinic(clinicId);
      final companions = networkDocs.map((d) => _toDriftCompanion(d)).toList();
      await _localDataSource.upsertDoctors(companions);
      debugPrint('[DoctorRepository] Fetched doctors for clinic $clinicId from NETWORK — ${networkDocs.length} items');
      return networkDocs;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint('[DoctorRepository] NETWORK failed (getDoctorsByClinic) — falling back to CACHE');

      if (cachedRows.isNotEmpty) {
        final filtered = cachedRows
            .map((r) => _fromDriftData(r))
            .where((doc) => doc.clinicId == clinicId)
            .map((doc) => doc.copyWith(isFromCache: true, cacheError: appEx.message))
            .toList();

        if (filtered.isNotEmpty) {
          debugPrint('[DoctorRepository] Returned ${filtered.length} clinic-linked items from CACHE');
          return filtered;
        }
      }
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
