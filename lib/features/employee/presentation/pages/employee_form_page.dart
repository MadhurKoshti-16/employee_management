import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/validators/app_validator.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_textfield.dart';

import '../../domain/entities/employee.dart';
import '../providers/employee_form_providers.dart';
import '../providers/employee_providers.dart';
import 'package:employee_onboarding_app/config/app_strings.dart';

class EmployeeFormPage extends ConsumerStatefulWidget {
  final Employee? employee;
  final bool isEdit;

  const EmployeeFormPage({super.key, this.employee, required this.isEdit});

  @override
  ConsumerState<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends ConsumerState<EmployeeFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _employeeIdController;

  late final TextEditingController _nameController;

  late final TextEditingController _departmentController;

  late final TextEditingController _designationController;

  late final TextEditingController _emailController;

  late final TextEditingController _phoneController;

  late final TextEditingController _joiningDateController;

  bool get isEdit => widget.isEdit;

  @override
  void initState() {
    super.initState();

    final employee = widget.employee;
    Future.microtask(() {
    ref
        .read(employeeFormControllerProvider.notifier)
        .clear();
  });

    _employeeIdController = TextEditingController(
      text: employee?.employeeId ?? '',
    );

    _nameController = TextEditingController(text: employee?.name ?? '');

    _departmentController = TextEditingController(
      text: employee?.department ?? '',
    );

    _designationController = TextEditingController(
      text: employee?.designation ?? '',
    );

    _emailController = TextEditingController(text: employee?.email ?? '');

    _phoneController = TextEditingController(text: employee?.phone ?? '');

    _joiningDateController = TextEditingController(
      text: employee?.joiningDate?.toString().split(' ').first ?? '',
    );
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    _nameController.dispose();
    _departmentController.dispose();
    _designationController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _joiningDateController.dispose();

    super.dispose();
  }

  Future<void> _pickImage() async {
    final imageService = ref.read(imageUploadServiceProvider);

    final image = await imageService.pickImage();
    if (image == null) {
      return;
    }

    final validationError = await imageService.validateImage(image);
    if (validationError != null) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(validationError)));

      return;
    }

    ref.read(employeeFormControllerProvider.notifier).setSelectedImage(image);
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    ref
        .read(employeeFormControllerProvider.notifier)
        .setJoiningDate(selectedDate);

    _joiningDateController.text = selectedDate.toString().split(' ').first;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final formController = ref.read(employeeFormControllerProvider.notifier);

    final formState = ref.read(employeeFormControllerProvider);

    try {
      formController.setLoading(true);

      String? imagePath = widget.employee?.profileImagePath;

      if (formState.selectedImage != null) {
        imagePath = formState.selectedImage!.path;
      }
      

      final employee = Employee(
        id: widget.employee?.id,

        email: _emailController.text.trim(),

        phone: _phoneController.text.trim(),

        employeeId: _employeeIdController.text.trim().isEmpty
            ? null
            : _employeeIdController.text.trim(),

        name: _nameController.text.trim().isEmpty
            ? null
            : _nameController.text.trim(),

        department: _departmentController.text.trim().isEmpty
            ? null
            : _departmentController.text.trim(),

        designation: _designationController.text.trim().isEmpty
            ? null
            : _designationController.text.trim(),

        joiningDate: formState.joiningDate ?? widget.employee?.joiningDate,

        profileImagePath: imagePath,
      );

      final controller = ref.read(employeeControllerProvider.notifier);

      if (isEdit) {
        await controller.updateEmployee(employee);
      } else {
        await controller.addEmployee(employee);
      }

      formController.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEdit
                ? AppStrings.employeeUpdatedSuccess
                : AppStrings.employeeAddedSuccess,
          ),
        ),
      );
      if(isEdit){

      Navigator.pop(context, true);
      }else{

      Navigator.pop(context, true);
      Navigator.pop(context, true);
      }

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      formController.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(employeeFormControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? AppStrings.editEmployee : AppStrings.addEmployee)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: formState.selectedImage != null
                      ? FileImage(formState.selectedImage!)
                      : widget.employee?.profileImagePath != null
                      ? FileImage(File(widget.employee!.profileImagePath!))
                      : null,
                  child:
                      formState.selectedImage == null &&
                          widget.employee?.profileImagePath == null
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
              ),

              const SizedBox(height: 24),

              AppTextField(
                controller: _employeeIdController,
                hintText: AppStrings.employeeId,
                labelText: AppStrings.employeeId,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _nameController,
                hintText: AppStrings.name,
                labelText: AppStrings.name,
              ),

              const SizedBox(height: 16),

              AppTextField(
                labelText: AppStrings.department,
                controller: _departmentController,
                hintText: AppStrings.department,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _designationController,
                hintText: AppStrings.designation,
                labelText: AppStrings.designation,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _emailController,
                hintText: AppStrings.email,
                labelText: AppStrings.email,
                keyboardType: TextInputType.emailAddress,
                validator: AppValidator.email,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _phoneController,
                hintText: AppStrings.phone,
                labelText: AppStrings.phone,
                keyboardType: TextInputType.phone,
                validator: AppValidator.phone,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _joiningDateController,
                hintText: AppStrings.joiningDate,
                labelText: AppStrings.joiningDate,
                readOnly: true,
                onTap: _selectDate,
                prefixIcon: const Icon(Icons.calendar_today),
              ),

              const SizedBox(height: 32),

              AppButton(
                title: isEdit ? AppStrings.updateEmployee : AppStrings.saveEmployee,
                loading: formState.isLoading,
                onTap: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}