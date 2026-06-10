import '../../domain/entities/employee.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasource/employee_remote_datasource.dart';
import '../models/employee_model.dart';

class EmployeeRepositoryImpl
    implements EmployeeRepository {
  final EmployeeRemoteDataSource
      remoteDataSource;

  EmployeeRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<List<Employee>> getEmployees() {
    return remoteDataSource.getEmployees();
  }

  @override
  Future<void> addEmployee(
    Employee employee,
  ) {
    return remoteDataSource.addEmployee(
      EmployeeModel.fromEntity(
        employee,
      ),
    );
  }

  @override
  Future<void> updateEmployee(
    Employee employee,
  ) {
    return remoteDataSource.updateEmployee(
      EmployeeModel.fromEntity(
        employee,
      ),
    );
  }

  @override
  Future<void> deleteEmployee(
    String employeeId,
  ) {
    return remoteDataSource.deleteEmployee(
      employeeId,
    );
  }
}