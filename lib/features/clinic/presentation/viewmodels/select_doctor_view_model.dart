import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectDoctorState {
  final String? selectedDoctorId;

  const SelectDoctorState({this.selectedDoctorId});

  SelectDoctorState copyWith({
    String? selectedDoctorId,
    bool clearDoctor = false,
  }) {
    return SelectDoctorState(
      selectedDoctorId: clearDoctor
          ? null
          : (selectedDoctorId ?? this.selectedDoctorId),
    );
  }
}

class SelectDoctorNotifier extends Notifier<SelectDoctorState> {
  SelectDoctorNotifier(this.clinicId);
  final String clinicId;

  @override
  SelectDoctorState build() {
    return const SelectDoctorState();
  }

  void selectDoctor(String doctorId) {
    if (state.selectedDoctorId == doctorId) {
      // Toggle off if already selected
      state = state.copyWith(clearDoctor: true);
    } else {
      state = state.copyWith(selectedDoctorId: doctorId);
    }
  }

  void clearSelection() {
    state = const SelectDoctorState();
  }
}
