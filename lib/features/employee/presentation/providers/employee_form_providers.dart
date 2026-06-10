import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'employee_form_controller.dart';
import 'employee_form_state.dart';

final employeeFormControllerProvider =
    NotifierProvider<
        EmployeeFormController,
        EmployeeFormState>(
  EmployeeFormController.new,
);