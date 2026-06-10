import 'dart:io';

class EmployeeFormState {
  final bool isLoading;
  final File? selectedImage;
  final DateTime? joiningDate;
  final String? imageUrl;
  final String? errorMessage;

  const EmployeeFormState({
    this.isLoading = false,
    this.selectedImage,
    this.joiningDate,
    this.imageUrl,
    this.errorMessage,
  });

  EmployeeFormState copyWith({
    bool? isLoading,
    File? selectedImage,
    DateTime? joiningDate,
    String? imageUrl,
    String? errorMessage,
  }) {
    return EmployeeFormState(
      isLoading: isLoading ?? this.isLoading,
      selectedImage:
          selectedImage ?? this.selectedImage,
      joiningDate:
          joiningDate ?? this.joiningDate,
      imageUrl:
          imageUrl ?? this.imageUrl,
      errorMessage:
          errorMessage,
    );
  }

  factory EmployeeFormState.initial() {
    return const EmployeeFormState();
  }
}