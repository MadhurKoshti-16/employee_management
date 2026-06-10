import '../../domain/entities/employee.dart';

class EmployeeState {
  final bool isLoading;
  final List<Employee> employees;
  final String searchQuery;
  final String? message;

  const EmployeeState({
    this.isLoading = false,
    this.employees = const [],
    this.searchQuery = '',
    this.message,
  });

  EmployeeState copyWith({
    bool? isLoading,
    List<Employee>? employees,
    String? searchQuery,
    String? message,
  }) {
    return EmployeeState(
      isLoading: isLoading ?? this.isLoading,
      employees: employees ?? this.employees,
      searchQuery: searchQuery ?? this.searchQuery,
      message: message,
    );
  }

  factory EmployeeState.initial() {
    return const EmployeeState();
  }
}