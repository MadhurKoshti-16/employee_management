import 'package:flutter/material.dart';

class AppDialog {
  static Future<bool?> showDeleteDialog(
    BuildContext context,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Delete Employee',
        ),
        content: const Text(
          'Are you sure you want to delete this employee?',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}