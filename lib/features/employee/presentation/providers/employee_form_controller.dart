import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'employee_form_state.dart';
class EmployeeFormController
    extends Notifier<EmployeeFormState> {

  @override
  EmployeeFormState build() {
    return EmployeeFormState.initial();
  }

  void setJoiningDate(
    DateTime date,
  ) {
    state = state.copyWith(
      joiningDate: date,
    );
  }

  void setSelectedImage(
    File image,
  ) {
    state = state.copyWith(
      selectedImage: image,
    );
  }

  void setLoading(
    bool value,
  ) {
    state = state.copyWith(
      isLoading: value,
    );
  }

  void setError(
    String message,
  ) {
    state = state.copyWith(
      errorMessage: message,
    );
  }

  void clearError() {
    state = state.copyWith(
      errorMessage: null,
    );
  }

  void clear() {
    state = EmployeeFormState.initial();
  }
}