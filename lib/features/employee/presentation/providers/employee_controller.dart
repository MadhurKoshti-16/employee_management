import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/debouncer.dart';
import '../../domain/entities/employee.dart';
import '../../domain/usecases/add_employee_usecase.dart';
import '../../domain/usecases/delete_employee_usecase.dart';
import '../../domain/usecases/get_employees_usecase.dart';
import '../../domain/usecases/update_employee_usecase.dart';
import 'employee_providers.dart';
import 'employee_state.dart';
import 'package:employee_onboarding_app/config/app_strings.dart';

class EmployeeController extends Notifier<EmployeeState> {
  late final GetEmployeesUseCase _getEmployeesUseCase;
  late final AddEmployeeUseCase _addEmployeeUseCase;
  late final UpdateEmployeeUseCase _updateEmployeeUseCase;
  late final DeleteEmployeeUseCase _deleteEmployeeUseCase;

  final Debouncer _debouncer = Debouncer(
    delay: const Duration(milliseconds: 500),
  );

  @override
  EmployeeState build() {
    _getEmployeesUseCase = ref.read(getEmployeesUseCaseProvider);
    _addEmployeeUseCase = ref.read(addEmployeeUseCaseProvider);
    _updateEmployeeUseCase = ref.read(updateEmployeeUseCaseProvider);
    _deleteEmployeeUseCase = ref.read(deleteEmployeeUseCaseProvider);

    ref.onDispose(_debouncer.dispose);

    return EmployeeState.initial();
  }

  Future<void> loadEmployees() async {
    try {
      state = state.copyWith(
        isLoading: true,
        message: null,
      );

      final employees = await _getEmployeesUseCase();

      state = state.copyWith(
        isLoading: false,
        employees: employees,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Failed to load employees',
      );
    }
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      state = state.copyWith(
        isLoading: true,
        message: null,
      );

      await _addEmployeeUseCase(employee);
      await loadEmployees();

      state = state.copyWith(
        isLoading: false,
        message: AppStrings.employeeAddedSuccess,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Failed to add employee',
      );
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      state = state.copyWith(
        isLoading: true,
        message: null,
      );

      await _updateEmployeeUseCase(employee);
      await loadEmployees();

      state = state.copyWith(
        isLoading: false,
        message: AppStrings.employeeUpdatedSuccess,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Failed to update employee',
      );
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      state = state.copyWith(
        isLoading: true,
        message: null,
      );

      await _deleteEmployeeUseCase(id);
      await loadEmployees();

      state = state.copyWith(
        isLoading: false,
        message: AppStrings.employeeDeletedSuccess,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Failed to delete employee',
      );
    }
  }

  void searchEmployees(String query) {
    _debouncer(() {
      state = state.copyWith(
        searchQuery: query,
      );
    });
  }

  void clearMessage() {
    state = state.copyWith(
      message: null,
    );
  }
}