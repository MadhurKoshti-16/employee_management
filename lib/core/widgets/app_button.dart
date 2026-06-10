import 'package:flutter/material.dart';

class AppButton
    extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed:
            loading ? null : onTap,
        child: loading
            ? const CircularProgressIndicator()
            : Text(title),
      ),
    );
  }
}