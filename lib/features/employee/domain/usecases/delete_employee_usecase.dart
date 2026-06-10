import '../repositories/employee_repository.dart';

class DeleteEmployeeUseCase {
  final EmployeeRepository repository;

  DeleteEmployeeUseCase(
    this.repository,
  );

  Future<void> call(
    String employeeId,
  ) {
    return repository.deleteEmployee(
      employeeId,
    );
  }
}