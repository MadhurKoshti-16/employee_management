import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/app_routes.dart';
import '../providers/scanner_provider.dart';

class ScannerPage extends ConsumerWidget {
  const ScannerPage({super.key});

  Future<void> _scanCard(
    BuildContext context,
    WidgetRef ref,
    Future employeeFuture,
  ) async {
    final employee = await employeeFuture;

    if (!context.mounted) return;

    if (employee == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No data extracted. You can fill details manually.'),
        ),
      );
      return;
    }

    final goToForm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Scan Completed'),
        content: const Text(
          'Employee details extracted. Do you want to continue to form?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Scan Again'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continue'),
          ),
        ],
      ),
    );

    if (goToForm != true) return;

    ref.read(scannerControllerProvider.notifier).clear();

    if (!context.mounted) return;

    Navigator.pushNamed(
      context,
      AppRoutes.addEmployee,
      arguments: employee,
    );
  }

  void _goToManualForm(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.read(scannerControllerProvider.notifier).clear();

    Navigator.pushNamed(
      context,
      AppRoutes.addEmployee,
      
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scannerControllerProvider);
    final controller = ref.read(scannerControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Employee Card'),
        actions: [
          TextButton(
            onPressed: () => _goToManualForm(context, ref),
            child: const Text('Skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (state.selectedImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  state.selectedImage!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Center(
                  child: Icon(
                    Icons.badge_outlined,
                    size: 80,
                  ),
                ),
              ),

            const SizedBox(height: 24),

            if (state.error != null)
              Column(
                children: [
                  Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => _goToManualForm(context, ref),
                    icon: const Icon(Icons.edit_note),
                    label: const Text('Fill Manually'),
                  ),
                ],
              ),

            const Spacer(),

            if (state.isLoading)
              const CircularProgressIndicator()
            else ...[
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _scanCard(
                      context,
                      ref,
                      controller.pickAndExtractFromCamera(),
                    );
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Capture from Camera'),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _scanCard(
                      context,
                      ref,
                      controller.pickAndExtractFromGallery(),
                    );
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Choose from Gallery'),
                ),
              ),

              const SizedBox(height: 14),

              TextButton.icon(
                onPressed: () => _goToManualForm(context, ref),
                icon: const Icon(Icons.edit),
                label: const Text('Add Manually'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}