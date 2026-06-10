import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/image_upload_service.dart';
import '../../data/datasource/employee_remote_datasource.dart';
import '../../data/repositories/employee_repository_impl.dart';
import '../../domain/entities/employee.dart';
import '../../domain/repositories/employee_repository.dart';
import '../../domain/usecases/add_employee_usecase.dart';
import '../../domain/usecases/delete_employee_usecase.dart';
import '../../domain/usecases/get_employees_usecase.dart';
import '../../domain/usecases/update_employee_usecase.dart';

import 'employee_controller.dart';
import 'employee_state.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final employeeDatasourceProvider =
    Provider<EmployeeRemoteDataSource>(
  (ref) => EmployeeRemoteDataSource(
    ref.read(firestoreProvider),
  ),
);

final employeeRepositoryProvider =
    Provider<EmployeeRepository>(
  (ref) => EmployeeRepositoryImpl(
    ref.read(employeeDatasourceProvider),
  ),
);

final getEmployeesUseCaseProvider =
    Provider<GetEmployeesUseCase>(
  (ref) => GetEmployeesUseCase(
    ref.read(employeeRepositoryProvider),
  ),
);

final addEmployeeUseCaseProvider =
    Provider<AddEmployeeUseCase>(
  (ref) => AddEmployeeUseCase(
    ref.read(employeeRepositoryProvider),
  ),
);

final updateEmployeeUseCaseProvider =
    Provider<UpdateEmployeeUseCase>(
  (ref) => UpdateEmployeeUseCase(
    ref.read(employeeRepositoryProvider),
  ),
);

final deleteEmployeeUseCaseProvider =
    Provider<DeleteEmployeeUseCase>(
  (ref) => DeleteEmployeeUseCase(
    ref.read(employeeRepositoryProvider),
  ),
);

final employeeControllerProvider =
    NotifierProvider<
        EmployeeController,
        EmployeeState>(
  EmployeeController.new,
);

final imageUploadServiceProvider =
    Provider<ImageUploadService>(
  (ref) => ImageUploadService(),
);

final filteredEmployeesProvider =
    Provider<List<Employee>>(
  (ref) {
    final state =
        ref.watch(employeeControllerProvider);

    final query =
        state.searchQuery.trim();

    if (query.length < 3) {
      return state.employees;
    }

    final keyword =
        query.toLowerCase();

    return state.employees.where((employee) {
      return employee.email
              .toLowerCase()
              .contains(keyword) ||
          employee.phone
              .toLowerCase()
              .contains(keyword) ||
          (employee.name ?? '')
              .toLowerCase()
              .contains(keyword) ||
          (employee.employeeId ?? '')
              .toLowerCase()
              .contains(keyword) ||
          (employee.department ?? '')
              .toLowerCase()
              .contains(keyword) ||
          (employee.designation ?? '')
              .toLowerCase()
              .contains(keyword);
    }).toList();
  },
);