import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectDoctorState {
  final String? selectedDoctorId;

  const SelectDoctorState({this.selectedDoctorId});

  SelectDoctorState copyWith({String? selectedDoctorId}) {
    return SelectDoctorState(
      selectedDoctorId: selectedDoctorId ?? this.selectedDoctorId,
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
    state = state.copyWith(selectedDoctorId: doctorId);
  }

  void clearSelection() {
    state = const SelectDoctorState(selectedDoctorId: null);
  }
}
