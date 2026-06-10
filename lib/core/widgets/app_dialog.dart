import 'package:flutter/material.dart';
import 'package:employee_onboarding_app/config/app_strings.dart';

class AppDialog {
  static Future<bool?> showDeleteDialog(
    BuildContext context,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          AppStrings.deleteEmployeeTitle,
        ),
        content: const Text(
          AppStrings.deleteEmployeeConfirmation,
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, false),
            child: const Text(AppStrings.cancel),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, true),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
  }
}