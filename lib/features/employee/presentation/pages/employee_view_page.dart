import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/app_routes.dart';
import '../../domain/entities/employee.dart';
import '../providers/employee_providers.dart';
import 'package:employee_onboarding_app/config/app_strings.dart';

class EmployeeViewPage extends ConsumerWidget {
  final Employee employee;

  const EmployeeViewPage({
    super.key,
    required this.employee,
  });

  Future<void> _editEmployee(
    BuildContext context,
    WidgetRef ref,
    Employee currentEmployee,
  ) async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.editEmployee,
      arguments: currentEmployee,
    );

    if (result == true) {
      await ref
          .read(employeeControllerProvider.notifier)
          .loadEmployees();
    }
  }

  Future<void> _deleteEmployee(
    BuildContext context,
    WidgetRef ref,
    Employee currentEmployee,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(AppStrings.deleteEmployeeTitle),
        content: const Text(
          AppStrings.deleteEmployeeConfirmation,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ref
        .read(employeeControllerProvider.notifier)
        .deleteEmployee(currentEmployee.id ?? "");

    if (!context.mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(employeeControllerProvider);

    final currentEmployee = state.employees
        .where((e) => e.id == employee.id)
        .firstOrNull ?? employee;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.employeeDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              _editEmployee(
                context,
                ref,
                currentEmployee,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              _deleteEmployee(
                context,
                ref,
                currentEmployee,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage:
                  currentEmployee.profileImagePath != null
                      ? FileImage(File(currentEmployee.profileImagePath!))
                      : null,
              child: currentEmployee.profileImagePath == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),
          ),
          const SizedBox(height: 24),
          _InfoTile(title: AppStrings.email, value: currentEmployee.email),
          _InfoTile(title: AppStrings.phone, value: currentEmployee.phone),
          _InfoTile(title: AppStrings.employeeId, value: currentEmployee.employeeId),
          _InfoTile(title: AppStrings.name, value: currentEmployee.name),
          _InfoTile(title: AppStrings.department, value: currentEmployee.department),
          _InfoTile(title: AppStrings.designation, value: currentEmployee.designation),
          _InfoTile(
            title: AppStrings.joiningDate,
            value: currentEmployee.joiningDate?.toString().split(' ').first,
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String? value;

  const _InfoTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value!),
      ),
    );
  }
}