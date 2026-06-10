import '../entities/employee.dart';
import '../repositories/employee_repository.dart';

class AddEmployeeUseCase {
  final EmployeeRepository repository;

  AddEmployeeUseCase(
    this.repository,
  );

  Future<void> call(
    Employee employee,
  ) {
    return repository.addEmployee(
      employee,
    );
  }
}