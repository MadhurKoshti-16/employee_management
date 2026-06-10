import 'package:employee_onboarding_app/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/employee.dart';
import '../providers/employee_providers.dart';
import '../widgets/employee_card.dart';
import '../widgets/employee_empty_state.dart';
import '../widgets/employee_search_bar.dart';

class EmployeeListPage extends ConsumerStatefulWidget {
  const EmployeeListPage({super.key});

  @override
  ConsumerState<EmployeeListPage> createState() =>
      _EmployeeListPageState();
}

class _EmployeeListPageState extends ConsumerState<EmployeeListPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(employeeControllerProvider.notifier).loadEmployees();
    });
  }

  Future<void> _refreshEmployees() async {
    await ref.read(employeeControllerProvider.notifier).loadEmployees();
  }

  Future<void> _openAddEmployee() async {
    await Navigator.pushNamed(
      context,
      AppRoutes.scanner
    );

    // if (!mounted) return;
    // await _refreshEmployees();
  }

  Future<void> _openEditEmployee(Employee employee) async {
    await Navigator.pushNamed(
      context,
      AppRoutes.editEmployee,
      arguments: employee,
    );

    // if (!mounted) return;
    // await _refreshEmployees();
  }

  Future<void> _deleteEmployee(Employee employee) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Delete Employee'),
          content: const Text(
            'Are you sure you want to delete this employee?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await ref
        .read(employeeControllerProvider.notifier)
        .deleteEmployee(employee.id ?? "");

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Employee deleted successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(employeeControllerProvider);
    final employees = ref.watch(filteredEmployeesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddEmployee,
        icon: const Icon(Icons.add),
        label: const Text('Employee'),
      ),
      body: Column(
        children: [
          EmployeeSearchBar(
            onChanged: (value) {
              ref
                  .read(employeeControllerProvider.notifier)
                  .searchEmployees(value);
            },
          ),

          if (state.searchQuery.isNotEmpty &&
              state.searchQuery.trim().length < 3)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Type at least 3 characters to search',
              ),
            ),

          Expanded(
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: _refreshEmployees,
                    child: employees.isEmpty
                        ? ListView(
                            physics:
                                const AlwaysScrollableScrollPhysics(),
                            children: const [
                              SizedBox(height: 160),
                              EmployeeEmptyState(),
                            ],
                          )
                        : ListView.builder(
                            physics:
                                const AlwaysScrollableScrollPhysics(),
                            itemCount: employees.length,
                            itemBuilder: (context, index) {
                              final employee = employees[index];

                              return EmployeeCard(
                                employee: employee,
                                onEdit: () {
                                  _openEditEmployee(employee);
                                },
                                onDelete: () {
                                  _deleteEmployee(employee);
                                },
                                onTap: () => Navigator.pushNamed(context, AppRoutes.employeeView,arguments: employee),
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}