import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/admin_cubit_fun/admin_fun_cubit.dart';
import 'package:mycompass_admin_website/models/main/get_all_admins_data_model.dart';
import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';

class AddNewAdminScreen extends StatefulWidget {
  const AddNewAdminScreen({super.key});

  @override
  State<AddNewAdminScreen> createState() => _AddNewAdminScreenState();
}

class _AddNewAdminScreenState extends State<AddNewAdminScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AllAdmins? admin = ModalRoute.of(context)!.settings.arguments as AllAdmins?;
    if (admin != null) {
      nameController.text = admin.userName ?? '';
      emailController.text = admin.email ?? '';
      // passwordController.text = admin.password;
      // cPasswordController.text = admin.password;
      phoneController.text = admin.phone ?? '';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Addnewadmin'.tr(context),
          style: Theme.of(context).textTheme.bodyLarge!,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Back to previous screen
          },
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(defaultPadding / 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                      'Admininformation'.tr(context),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),

                    CustomTextField(
                      label: 'Adminname'.tr(context),
                      hintText:'Adminname'.tr(context),
                      controller: nameController,
                    ),
                    const SizedBox(height: defaultPadding),

                    CustomTextField(
                      label: 'AdminEmail'.tr(context),
                      hintText: 'AdminEmail'.tr(context),
                      controller: emailController,
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomTextField(
                      label: 'phoneNumber'.tr(context),
                      hintText:  'phoneNumber'.tr(context),
                      controller: phoneController,
                    ),
                    const SizedBox(height: defaultPadding),
                    if (admin == null)
                      CustomTextField(
                        label: 'Adminpassword'.tr(context),
                        hintText: 'Adminpassword'.tr(context),
                        controller: passwordController,
                      ),
                    if (admin == null) const SizedBox(height: defaultPadding),
                    if (admin == null)
                      CustomTextField(
                        label: "Confirmadminpassword".tr(context),
                        hintText:  "Confirmadminpassword".tr(context),
                        controller: cPasswordController,
                      ),
                    const SizedBox(height: defaultPadding),

                    // Submit button
                    BlocConsumer<AdminFunCubit, AdminFunState>(
                      listener: (context, state) {
                        if (state is CreateAdminSuccess ||
                            state is UpdateAdminSuccess) {
                          context.read<AdminFunCubit>().getAllAdmins();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                admin == null
                                    ? 'Newadminaddedsuccessfully'.tr(context)
                                    : "Modified".tr(context),
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        } else if (state is CreateAdminFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  state.errorModel.message ?? 'Somethingwentwrong'.tr(context)),
                            ),
                          );
                        } else if (state is UpdateAdminFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  state.errorModel.message ?? 'Somethingwentwrong'.tr(context)),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        var cubit = context.read<AdminFunCubit>();
                        return ElevatedButton(
                          onPressed: () {
                            admin == null
                                ? cubit.createAdmin(
                                    userName: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    cPassword: cPasswordController.text,
                                    phone: phoneController.text,
                                  )
                                : cubit.updateAdmin(
                                    id: admin.sId ?? '',
                                    userName:
                                        admin.userName == nameController.text
                                            ? null
                                            : nameController.text,
                                    email: admin.email == emailController.text
                                        ? null
                                        : emailController.text,
                                    phone: admin.phone == phoneController.text
                                        ? null
                                        : phoneController.text,
                                  );
                          },
                          child: state is CreateAdminLoading ||
                                  state is UpdateAdminLoading
                              ? const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator())
                              : Text(
                                  admin == null
                                      ? 'Addnewadmin'.tr(context)
                                      : 'Modified'.tr(context),
                                ),
                        );
                      },
                    ),

                    if (admin != null)
                      Column(
                        children: [
                          CustomTextField(
                            label: 'oldPassword'.tr(context),
                            hintText: 'oldPassword'.tr(context),
                            controller: passwordController,
                          ),
                          const SizedBox(height: defaultPadding),
                          CustomTextField(
                            label: "modernpassword".tr(context),
                            hintText:  "modernpassword".tr(context),
                            controller: cPasswordController,
                          ),
                          const SizedBox(height: defaultPadding),
                          BlocConsumer<AdminFunCubit, AdminFunState>(
                            listener: (context, state) {
                              // if (state is UpdateAdminSuccess) {
                              //   context.read<AdminFunCubit>().getAllAdmins();
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Text(
                              //         "تم التعديل",
                              //       ),
                              //     ),
                              //   );
                              //   Navigator.pop(context);
                              // }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  context.read<AdminFunCubit>().updateAdmin(
                                        id: admin.sId ?? '',
                                        oldPassword: passwordController.text,
                                        newPassword: cPasswordController.text,
                                      );
                                },
                                child:   Text("changepassword".tr(context)),
                              );
                            },
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
