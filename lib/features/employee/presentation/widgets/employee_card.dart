import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entities/employee.dart';
import 'package:employee_onboarding_app/config/app_strings.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RepaintBoundary(
      child: Card(
        
        elevation: 2,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16),
        ),
        child: InkWell(
            borderRadius:
              BorderRadius.circular(16),
        onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          employee.profileImagePath !=
                                  null
                              ? FileImage(
                                  File(employee
                                      .profileImagePath!),
                                )
                              : null,
                      child: employee
                                  .profileImagePath ==
                              null
                          ? const Icon(
                              Icons.person,
                              size: 30,
                            )
                          : null,
                    ),
                
                    const SizedBox(width: 12),
                
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            employee.name ??
                                'Unknown Employee',
                            style: theme
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                          ),
                
                          const SizedBox(
                            height: 4,
                          ),
                
                          Text(
                            employee.email,
                            style: theme
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                _InfoRow(
                  icon: Icons.phone,
                  label: AppStrings.phone,
                  value: employee.phone,
                ),
                
                if (employee.employeeId != null)
                  _InfoRow(
                    icon:
                        Icons.badge_outlined,
                    label: AppStrings.employeeId,
                    value:
                        employee.employeeId!,
                  ),
                
                if (employee.department != null)
                  _InfoRow(
                    icon:
                        Icons.apartment_outlined,
                    label: AppStrings.department,
                    value:
                        employee.department!,
                  ),
                
                if (employee.designation !=
                    null)
                  _InfoRow(
                    icon:
                        Icons.work_outline,
                    label: AppStrings.designation,
                    value:
                        employee.designation!,
                  ),
                
                const SizedBox(height: 12),
                
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(
                        Icons.edit_outlined,
                      ),
                    ),
                
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
          ),

          const SizedBox(width: 8),

          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}