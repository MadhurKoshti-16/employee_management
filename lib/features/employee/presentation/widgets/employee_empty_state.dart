import 'package:flutter/material.dart';

class EmployeeEmptyState
    extends StatelessWidget {
  const EmployeeEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
          ),

          SizedBox(height: 12),

          Text(
            'No Employees Found',
          ),
        ],
      ),
    );
  }
}