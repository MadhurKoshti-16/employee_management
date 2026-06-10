import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/employee_model.dart';

class EmployeeRemoteDataSource {
  final FirebaseFirestore firestore;

  EmployeeRemoteDataSource(
    this.firestore,
  );

  CollectionReference get _employeeCollection =>
      firestore.collection('employees');

  Future<List<EmployeeModel>> getEmployees() async {
    final snapshot = await _employeeCollection
        .orderBy(
          'updatedAt',
          descending: true,
        )
        .get();

    return snapshot.docs.map((doc) {
      return EmployeeModel.fromJson(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    }).toList();
  }

  Future<void> addEmployee(
    EmployeeModel employee,
  ) async {
    await _employeeCollection.add({
      ...employee.toJson(),
      'createdAt':
          FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateEmployee(
    EmployeeModel employee,
  ) async {
    await _employeeCollection
        .doc(employee.id)
        .update(
          employee.toJson(),
        );
  }

  Future<void> deleteEmployee(
    String employeeId,
  ) async {
    await _employeeCollection
        .doc(employeeId)
        .delete();
  }
}