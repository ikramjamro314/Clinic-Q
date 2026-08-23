import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' as d;

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/exception_mapper.dart';
import '../../../../core/local/app_database.dart';
import '../../domain/entities/clinic_entity.dart';
import '../../domain/repositories/clinic_repository.dart';
import '../local/clinic_local_data_source.dart';
import '../services/clinic_api_service.dart';

class ClinicRepositoryImpl implements ClinicRepository {
  final ClinicApiService _service;
  final ClinicLocalDataSource _localDataSource;

  ClinicRepositoryImpl(this._service, this._localDataSource);

  bool _isCacheValid(DateTime? cachedAt) {
    if (cachedAt == null) return false;
    final now = DateTime.now();
    final difference = now.difference(cachedAt);
    return difference.inHours < 24;
  }

  @override
  Future<List<ClinicEntity>> getAllClinics({
    String? city,
    String? specialty,
    String? search,
  }) async {
    final cachedRows = await _localDataSource.getCachedClinics();
    if (cachedRows.isNotEmpty && _isCacheValid(cachedRows.first.cachedAt)) {
      debugPrint('[ClinicRepository] Cache is fresh (<24h) — serving from CACHE');
      var cachedEntities = cachedRows.map((r) => _fromDriftData(r)).toList();

      // Perform client-side filtering on cached clinics when cache is valid
      if (city != null && city.trim().isNotEmpty) {
        final queryCity = city.trim().toLowerCase();
        cachedEntities = cachedEntities.where((c) => c.city?.toLowerCase() == queryCity).toList();
      }
      if (specialty != null && specialty.trim().isNotEmpty) {
        final querySpec = specialty.trim().toLowerCase();
        cachedEntities = cachedEntities.where((c) =>
            c.specialtyTag.toLowerCase() == querySpec ||
            c.specialties.any((s) => s.toLowerCase() == querySpec)).toList();
      }
      if (search != null && search.trim().isNotEmpty) {
        final querySearch = search.trim().toLowerCase();
        cachedEntities = cachedEntities.where((c) =>
            c.name.toLowerCase().contains(querySearch) ||
            c.address.toLowerCase().contains(querySearch)).toList();
      }

      return cachedEntities;
    }

    try {
      final networkClinics = await _service.getAllClinics(
        city: city,
        specialty: specialty,
        search: search,
      );

      // Cache fresh data in SQLite
      final companions = networkClinics.map((c) => _toDriftCompanion(c)).toList();
      await _localDataSource.upsertClinics(companions);

      debugPrint('[ClinicRepository] Fetched from NETWORK — ${networkClinics.length} items');
      return networkClinics;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint('[ClinicRepository] NETWORK failed — falling back to CACHE: $appEx');

      if (cachedRows.isNotEmpty) {
        var cachedEntities = cachedRows.map((r) => _fromDriftData(r)).toList();

        // Perform client-side filtering on cached clinics when offline
        if (city != null && city.trim().isNotEmpty) {
          final queryCity = city.trim().toLowerCase();
          cachedEntities = cachedEntities.where((c) => c.city?.toLowerCase() == queryCity).toList();
        }
        if (specialty != null && specialty.trim().isNotEmpty) {
          final querySpec = specialty.trim().toLowerCase();
          cachedEntities = cachedEntities.where((c) =>
              c.specialtyTag.toLowerCase() == querySpec ||
              c.specialties.any((s) => s.toLowerCase() == querySpec)).toList();
        }
        if (search != null && search.trim().isNotEmpty) {
          final querySearch = search.trim().toLowerCase();
          cachedEntities = cachedEntities.where((c) =>
              c.name.toLowerCase().contains(querySearch) ||
              c.address.toLowerCase().contains(querySearch)).toList();
        }

        if (cachedEntities.isNotEmpty) {
          final flaggedEntities = cachedEntities
              .map((c) => c.copyWith(isFromCache: true, cacheError: appEx.message))
              .toList();
          final cachedAtTime = cachedRows.first.cachedAt.toIso8601String();
          debugPrint('[ClinicRepository] Returned ${flaggedEntities.length} items from CACHE (cachedAt: $cachedAtTime)');
          return flaggedEntities;
        }
      }

      throw appEx;
    }
  }

  @override
  Future<ClinicEntity?> getClinicById(String id) async {
    final cachedRow = await _localDataSource.getCachedClinicById(id);
    if (cachedRow != null && _isCacheValid(cachedRow.cachedAt)) {
      debugPrint('[ClinicRepository] Clinic $id cache is fresh (<24h) — serving from CACHE');
      return _fromDriftData(cachedRow);
    }

    try {
      final networkClinic = await _service.getClinicById(id);
      if (networkClinic != null) {
        await _localDataSource.upsertClinics([_toDriftCompanion(networkClinic)]);
        debugPrint('[ClinicRepository] Fetched from NETWORK for ID $id');
      }
      return networkClinic;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint('[ClinicRepository] NETWORK failed — falling back to CACHE');

      if (cachedRow != null) {
        final entity = _fromDriftData(cachedRow).copyWith(
          isFromCache: true,
          cacheError: appEx.message,
        );
        debugPrint('[ClinicRepository] Returned 1 item from CACHE (cachedAt: ${cachedRow.cachedAt.toIso8601String()})');
        return entity;
      }

      throw appEx;
    }
  }

  ClinicsTableCompanion _toDriftCompanion(ClinicEntity entity) {
    return ClinicsTableCompanion(
      id: d.Value(entity.id),
      name: d.Value(entity.name),
      imageUrl: d.Value(entity.imageUrl),
      specialtyTag: d.Value(entity.specialtyTag),
      rating: d.Value(entity.rating),
      reviewCount: d.Value(entity.reviewCount),
      openingHours: d.Value(entity.openingHours),
      address: d.Value(entity.address),
      doctorCount: d.Value(entity.doctorCount),
      phone: d.Value(entity.phone),
      patientCount: d.Value(entity.patientCount),
      specialistCount: d.Value(entity.specialistCount),
      yearsExperience: d.Value(entity.yearsExperience),
      isOpen: d.Value(entity.isOpen),
      ownerId: d.Value(entity.ownerId),
      clinicName: d.Value(entity.clinicName),
      tagline: d.Value(entity.tagline),
      description: d.Value(entity.description),
      city: d.Value(entity.city),
      state: d.Value(entity.state),
      zipCode: d.Value(entity.zipCode),
      email: d.Value(entity.email),
      website: d.Value(entity.website),
      openTime: d.Value(entity.openTime),
      closeTime: d.Value(entity.closeTime),
      workingDays: d.Value(entity.workingDays.join(',')),
      specialties: d.Value(entity.specialties.join(',')),
      facilities: d.Value(entity.facilities.join(',')),
      emergencyServices: d.Value(entity.emergencyServices),
      createdAt: d.Value(entity.createdAt),
      updatedAt: d.Value(entity.updatedAt),
      cachedAt: d.Value(DateTime.now()),
    );
  }

  ClinicEntity _fromDriftData(ClinicsTableData r) {
    return ClinicEntity(
      id: r.id,
      name: r.name,
      imageUrl: r.imageUrl,
      specialtyTag: r.specialtyTag,
      rating: r.rating,
      reviewCount: r.reviewCount,
      openingHours: r.openingHours,
      address: r.address,
      doctorCount: r.doctorCount,
      phone: r.phone,
      patientCount: r.patientCount,
      specialistCount: r.specialistCount,
      yearsExperience: r.yearsExperience,
      isOpen: r.isOpen,
      ownerId: r.ownerId,
      clinicName: r.clinicName,
      tagline: r.tagline,
      description: r.description,
      city: r.city,
      state: r.state,
      zipCode: r.zipCode,
      email: r.email,
      website: r.website,
      openTime: r.openTime,
      closeTime: r.closeTime,
      workingDays: r.workingDays != null && r.workingDays!.isNotEmpty
          ? r.workingDays!.split(',')
          : const [],
      specialties: r.specialties != null && r.specialties!.isNotEmpty
          ? r.specialties!.split(',')
          : const [],
      facilities: r.facilities != null && r.facilities!.isNotEmpty
          ? r.facilities!.split(',')
          : const [],
      emergencyServices: r.emergencyServices,
      createdAt: r.createdAt,
      updatedAt: r.updatedAt,
    );
  }
}

