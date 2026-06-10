import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_textfield.dart';
import '../../../../core/validators/app_validator.dart';
import '../providers/auth_providers.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmController = TextEditingController();

  bool _hidePassword = true;

  bool _hideConfirm = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text("Register to continue"),

                const SizedBox(height: 30),

                AppTextField(
                  controller: _emailController,
                  hintText: "Email",
                  validator: AppValidator.email,
                ),

                const SizedBox(height: 16),

                AppTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: _hidePassword,
                  validator: AppValidator.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hidePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16),

                AppTextField(
                  controller: _confirmController,
                  hintText: "Confirm Password",
                  obscureText: _hideConfirm,
                  validator: (value) {
                    return AppValidator.confirmPassword(
                      password: _passwordController.text,
                      value: value,
                    );
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hideConfirm ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _hideConfirm = !_hideConfirm;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 30),

                AppButton(
                  title: "Register",
                  loading: state.isLoading,
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    await ref
                        .read(authControllerProvider.notifier)
                        .register(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ) .then((value) {
                          if (value && context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.employees,
                              (_) => false,
                            );
                          }
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
