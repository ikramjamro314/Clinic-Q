import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../models/doctor_model.dart';
import '../../domain/entities/specialty_entity.dart';

class SupabaseDoctorService {
  final sb.SupabaseClient _supabaseClient;

  SupabaseDoctorService(this._supabaseClient);

  /// TODO: implement Supabase query once `specialties` table schema is finalized
  Future<List<SpecialtyEntity>> getSpecialties() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      SpecialtyEntity(id: '1', name: 'Toothcare', iconReference: Icons.masks_outlined),
      SpecialtyEntity(id: '2', name: 'Cardiology', iconReference: Icons.favorite_border),
      SpecialtyEntity(id: '3', name: 'Eye', iconReference: Icons.remove_red_eye_outlined),
      SpecialtyEntity(id: '4', name: 'Pediatrics', iconReference: Icons.child_care),
      SpecialtyEntity(id: '5', name: 'Neurology', iconReference: Icons.psychology_outlined),
      SpecialtyEntity(id: '6', name: 'Infectious', iconReference: Icons.coronavirus_outlined),
    ];
  }

  /// TODO: implement Supabase query once `doctors` table schema is finalized
  /// For now, returns mock "interested" doctors matching the UI reference.
  Future<List<DoctorModel>> getInterestedDoctors() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return const [
      DoctorModel(
        id: '1',
        name: 'Dr. Anthony',
        specialty: 'Obstetrics',
        clinicName: 'City Hospital',
        photoUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026704d',
        rating: 4.5,
        reviewCount: 42,
        price: 1200,
        durationMinutes: 15,
        isInterested: true,
        about: 'Dr. Anthony is a top clinician and expert in the field of obstetrics. He is a pioneer in his research field and has published 100s of articles, book chapters, and books.',
        location: '123 Medical Center Blvd',
      ),
      DoctorModel(
        id: '2',
        name: 'Dr. Nguyen',
        specialty: 'Dermatology',
        clinicName: 'Skin Care Clinic',
        photoUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026704e',
        rating: 4.8,
        reviewCount: 89,
        price: 1500,
        durationMinutes: 20,
        isInterested: true,
        about: 'Dr. Nguyen is a top dermatologist and expert in skin care. She has a deep understanding of cosmetic and medical dermatology.',
        location: '456 Skin Care Ave',
      ),
      DoctorModel(
        id: '3',
        name: 'Dr. Nguyen', // Another Nguyen in the design reference
        specialty: 'Dermatology',
        clinicName: 'Wellness Center',
        photoUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026704f',
        rating: 4.5,
        reviewCount: 30,
        price: 1300,
        durationMinutes: 15,
        isInterested: true,
        about: 'Dr. Nguyen focuses on holistic wellness and skin care, blending modern treatments with natural remedies.',
        location: '789 Wellness St',
      ),
    ];
  }

  /// TODO: implement Supabase query once `doctors` table schema is finalized
  /// For now, returns a mock list of all doctors.
  Future<List<DoctorModel>> getAllDoctors({
    String? query,
    Map<String, dynamic>? filters,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    List<DoctorModel> doctors = const [
      DoctorModel(
        id: '4',
        name: 'Dr. Hashimoto',
        specialty: 'Neurology',
        clinicName: 'Neuro Institute',
        photoUrl: 'https://i.pravatar.cc/150?u=a04258a2462d826712d',
        rating: 4.5,
        reviewCount: 120,
        price: 2000,
        durationMinutes: 30,
        about: 'Dr. Hashimoto is a top neurological clinician and expert in the field of epilepsy and neurological sleep disorders. He is a pioneer in his research field and has published 100s of articles, book chapters, and books.',
        location: '5000 Hillcrest Avenue',
      ),
      DoctorModel(
        id: '5',
        name: 'Dr. Sharapova',
        specialty: 'Pediatrics',
        clinicName: 'Childrens Med',
        photoUrl: 'https://i.pravatar.cc/150?u=a04258a2462d826712e',
        rating: 4.9,
        reviewCount: 205,
        price: 1000,
        durationMinutes: 15,
        about: 'Dr. Sharapova is an experienced pediatrician dedicated to children\'s health and well-being.',
        location: '100 Pediatric Way',
      ),
      DoctorModel(
        id: '6',
        name: 'Dr. Christine',
        specialty: 'Nephrology',
        clinicName: 'Kidney Care Plus',
        photoUrl: 'https://i.pravatar.cc/150?u=a04258a2462d826712f',
        rating: 4.5,
        reviewCount: 65,
        price: 1800,
        durationMinutes: 25,
        about: 'Dr. Christine specializes in kidney health and renal replacement therapy.',
        location: '200 Kidney Ave',
      ),
      DoctorModel(
        id: '7',
        name: 'Dr. Sarah Khan',
        specialty: 'General Physician',
        clinicName: 'CityMed Clinic',
        photoUrl: 'https://i.pravatar.cc/150?u=a04258a2462d8267130',
        rating: 4.8,
        reviewCount: 42,
        price: 1500,
        durationMinutes: 15,
        about: 'Dr. Sarah Khan provides comprehensive primary care services to patients of all ages.',
        location: '300 CityMed St',
      ),
    ];

    if (query != null && query.isNotEmpty) {
      final lowercaseQuery = query.toLowerCase();
      doctors = doctors.where((doc) {
        return doc.name.toLowerCase().contains(lowercaseQuery) ||
            doc.specialty.toLowerCase().contains(lowercaseQuery);
      }).toList();
    }

    return doctors;
  }

  /// TODO: implement Supabase query once `doctors` table schema is finalized
  Future<DoctorModel?> getDoctorById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    final allDocs = [...await getInterestedDoctors(), ...await getAllDoctors()];
    try {
      return allDocs.firstWhere((doc) => doc.id == id);
    } catch (e) {
      return null;
    }
  }

  /// TODO: implement Supabase query once `doctors` table schema is finalized
  Future<List<DoctorModel>> getDoctorsByClinic(String clinicId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    final allDocs = [...await getInterestedDoctors(), ...await getAllDoctors()];
    // For mock purposes, just return some docs
    return allDocs.take(3).toList();
  }
}
