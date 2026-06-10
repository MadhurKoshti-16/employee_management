import 'dart:io';

class ScannerState {
  final bool isLoading;
  final File? selectedImage;
  final String? error;

  const ScannerState({
    this.isLoading = false,
    this.selectedImage,
    this.error,
  });

  ScannerState copyWith({
    bool? isLoading,
    File? selectedImage,
    String? error,
  }) {
    return ScannerState(
      isLoading: isLoading ?? this.isLoading,
      selectedImage: selectedImage ?? this.selectedImage,
      error: error,
    );
  }

  factory ScannerState.initial() {
    return const ScannerState();
  }
}