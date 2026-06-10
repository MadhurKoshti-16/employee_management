import 'package:employee_onboarding_app/features/scanner/presentation/pages/scanner_page.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/employee/domain/entities/employee.dart';
import '../features/employee/presentation/pages/employee_form_page.dart';
import '../features/employee/presentation/pages/employee_list_page.dart';
import '../features/employee/presentation/pages/employee_view_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';

  static const employees = '/employees';
  static const addEmployee = '/add-employee';
  static const editEmployee = '/edit-employee';
  static const employeeView = '/employee-view';
  static const scanner = '/scanner';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case employees:
        return MaterialPageRoute(builder: (_) => const EmployeeListPage());

      case addEmployee:
        final employee = settings.arguments as Employee?;
        return MaterialPageRoute(builder: (_) =>  EmployeeFormPage(employee: employee,isEdit: false,));

      case editEmployee:
        final employee = settings.arguments as Employee;

        return MaterialPageRoute(
          builder: (_) => EmployeeFormPage(employee: employee, isEdit: true,),
        );

      case employeeView:
        final employee = settings.arguments as Employee;

        return MaterialPageRoute(
          builder: (_) => EmployeeViewPage(employee: employee),
        );

      case scanner:
        return MaterialPageRoute(builder: (_) => const ScannerPage());

      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}
