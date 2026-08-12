import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../models/clinic_model.dart';

class SupabaseClinicService {
  final sb.SupabaseClient _supabaseClient;

  SupabaseClinicService(this._supabaseClient);

  /// TODO: implement Supabase query once `clinics` table schema is finalized
  /// For now, returns mock clinics matching the UI reference.
  Future<List<ClinicModel>> getAllClinics({String? query}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    List<ClinicModel> clinics = const [
      ClinicModel(
        id: '1',
        name: 'Mayo Clinic',
        imageUrl: null, // Placeholder will be used
        specialtyTag: 'General',
        rating: 4.5,
        reviewCount: 342,
        openingHours:
            'Mon-Fri: 9:00 AM - 8:00 PM,\nSat-Sun: 10:00 AM - 6:00 PM',
        address: '200 First St, MN',
        doctorCount: 2,
        phone: '+92 21 1234567',
        patientCount: '100k+',
        specialistCount: '20+',
        yearsExperience: '100Yrs+',
        isOpen: true,
      ),
      ClinicModel(
        id: '2',
        name: 'Cleveland Clinic',
        imageUrl: null,
        specialtyTag: 'Specialized',
        rating: 4.5,
        reviewCount: 215,
        openingHours:
            'Mon-Fri: 9:00 AM - 8:00 PM,\nSat-Sun: 10:00 AM - 6:00 PM',
        address: '9500 Euclid Avenue, OH',
        doctorCount: 5,
        phone: '+92 21 7654321',
        patientCount: '50k+',
        specialistCount: '15+',
        yearsExperience: '75Yrs+',
        isOpen: true,
      ),
      ClinicModel(
        id: '3',
        name: 'UCSF Medical Center',
        imageUrl: null,
        specialtyTag: 'Surgery',
        rating: 4.5,
        reviewCount: 180,
        openingHours:
            'Mon-Fri: 9:00 AM - 8:00 PM,\nSat-Sun: 10:00 AM - 6:00 PM',
        address: '505 Parnassus Ave, CA',
        doctorCount: 8,
        phone: '+92 21 1112223',
        patientCount: '200k+',
        specialistCount: '50+',
        yearsExperience: '150Yrs+',
        isOpen: false,
      ),
      ClinicModel(
        id: '4',
        name: 'NYU Langone Health',
        imageUrl: null,
        specialtyTag: 'General',
        rating: 4.5,
        reviewCount: 410,
        openingHours: 'Mon-Fri: Open 24 Hours,\nSat-Sun: Open 24 Hours',
        address: '550 First Avenue, NY',
        doctorCount: 15,
        phone: '+92 21 9998887',
        patientCount: '300k+',
        specialistCount: '100+',
        yearsExperience: '120Yrs+',
        isOpen: true,
      ),
      ClinicModel(
        id: '5',
        name: 'Michigan Medicine',
        imageUrl: null,
        specialtyTag: 'Cardiology',
        rating: 4.5,
        reviewCount: 289,
        openingHours:
            'Mon-Fri: 9:00 AM - 8:00 PM,\nSat-Sun: 10:00 AM - 6:00 PM',
        address: '1500 E Medical Center Dr, MI',
        doctorCount: 4,
        phone: '+92 21 4445556',
        patientCount: '80k+',
        specialistCount: '30+',
        yearsExperience: '90Yrs+',
        isOpen: true,
      ),
    ];

    if (query != null && query.isNotEmpty) {
      final lowercaseQuery = query.toLowerCase();
      clinics = clinics.where((clinic) {
        return clinic.name.toLowerCase().contains(lowercaseQuery) ||
            clinic.specialtyTag.toLowerCase().contains(lowercaseQuery) ||
            clinic.address.toLowerCase().contains(lowercaseQuery);
      }).toList();
    }

    return clinics;
  }

  /// Fetches a single clinic by ID
  Future<ClinicModel?> getClinicById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    final allClinics = await getAllClinics();
    try {
      return allClinics.firstWhere((clinic) => clinic.id == id);
    } catch (e) {
      return null;
    }
  }
}
