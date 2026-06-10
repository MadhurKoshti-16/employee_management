import 'package:flutter/material.dart';

class EmployeeSearchBar
    extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const EmployeeSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(16),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText:
              'Search Employee',
          prefixIcon: const Icon(
            Icons.search,
          ),
          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),
        ),
      ),
    );
  }
}