import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/app_routes.dart';
import '../../../../config/app_strings.dart';
import '../../../../core/validators/app_validator.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_textfield.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.message != null && next.message!.isNotEmpty) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(next.message!)));

        ref.read(authControllerProvider.notifier).clearMessage();
      }
    });

    final state = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                const Center(child: Icon(Icons.badge, size: 90)),

                const SizedBox(height: 32),

                const Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text("Login to continue"),

                const SizedBox(height: 30),

                AppTextField(
                  controller: _emailController,
                  hintText: AppStrings.email,
                  validator: AppValidator.email,
                ),

                const SizedBox(height: 16),

                AppTextField(
                  controller: _passwordController,
                  hintText: AppStrings.password,
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

                const SizedBox(height: 30),

                AppButton(
                  title: "Login",
                  loading: state.isLoading,
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    await ref
                        .read(authControllerProvider.notifier)
                        .login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        )
                        .then((value) {
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

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account?"),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      child: const Text("Register"),
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
