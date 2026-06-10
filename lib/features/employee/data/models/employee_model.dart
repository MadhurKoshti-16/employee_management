import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.email,
    required super.phone,
    super.employeeId,
    super.name,
    super.department,
    super.designation,
    super.joiningDate,
    super.profileImagePath,
  });

  factory EmployeeModel.fromJson(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return EmployeeModel(
      id: documentId,
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      employeeId: json['employeeId'],
      name: json['name'],
      department: json['department'],
      designation: json['designation'],
      profileImagePath: json['profileImagePath'],
      joiningDate: json['joiningDate'] != null
          ? (json['joiningDate'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'employeeId': employeeId,
      'name': name,
      'department': department,
      'designation': designation,
      'profileImagePath': profileImagePath,
      'joiningDate': joiningDate,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  factory EmployeeModel.fromEntity(
    Employee employee,
  ) {
    return EmployeeModel(
      id: employee.id,
      email: employee.email,
      phone: employee.phone,
      employeeId: employee.employeeId,
      name: employee.name,
      department: employee.department,
      designation: employee.designation,
      joiningDate: employee.joiningDate,
      profileImagePath: employee.profileImagePath,
    );
  }
}