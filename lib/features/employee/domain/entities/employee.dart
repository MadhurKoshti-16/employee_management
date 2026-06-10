class Employee {
  final String? id;

  /// Required
  final String email;
  final String phone;

  /// Optional
  final String? employeeId;
  final String? name;
  final String? department;
  final String? designation;
  final DateTime? joiningDate;
  final String? profileImagePath;

  const Employee({
     this.id,
    required this.email,
    required this.phone,
    this.employeeId,
    this.name,
    this.department,
    this.designation,
    this.joiningDate,
    this.profileImagePath,
  });
}