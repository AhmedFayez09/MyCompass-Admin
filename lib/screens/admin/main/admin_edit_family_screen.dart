import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/family/family_cubit.dart';
import 'package:mycompass_admin_website/models/family_model.dart';
import 'package:mycompass_admin_website/widgets/custom_drop_down_field.dart';
import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

class AdminEditFamilyScreen extends StatefulWidget {
  const AdminEditFamilyScreen({super.key});

  @override
  State<AdminEditFamilyScreen> createState() => _AdminEditFamilyScreenState();
}

class _AdminEditFamilyScreenState extends State<AdminEditFamilyScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final theirIsDayController = TextEditingController();
  final numberOfApartmentController = TextEditingController();

  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  // Define selected family member
  String? selectedFamilyMember;

  String selectedTheirDay = 'Monday';

  @override
  Widget build(BuildContext context) {
    final OneFamily family =
        ModalRoute.of(context)!.settings.arguments as OneFamily;
    usernameController.text = family.userName ?? '';
    emailController.text = family.email ?? '';
    phoneController.text = family.phone ?? '';
    numberOfApartmentController.text = "${family.noOfAppartment}" ?? '';
    // selectedFamilyMember = family.memberType ?? '';
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تعديل بيانات العائلة'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Back to previous screen
            },
          ),
          backgroundColor: Colors.deepPurple, // Customize AppBar color
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            primary: false,
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
                        'Familyinformation'.tr(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label:"email".tr(context),
                        hintText: 'example@gmail.com',
                        controller: emailController,
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: "username".tr(context),
                        hintText: 'Enterusername'.tr(context),
                        controller: usernameController,
                      ),

                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: "phoneNumber".tr(context),
                        hintText: '+20-10-XXXXXXX',
                        controller: phoneController,
                      ),
                      const SizedBox(height: defaultPadding),
                      // CustomTextField(
                      //   label: 'اليوم الخاص بهم',
                      //   hintText: 'Monday',
                      //   controller: theirIsDayController,
                      // ),
                      DropdownField(
                        label: 'FamilyNembers'.tr(context),
                        items: const [
                          'Sunday',
                          'Monday',
                          'Tuesday',
                          'Wednesday',
                          'Thursday',
                          'Friday',
                          'Saturday'
                        ],
                        selectedValue: selectedTheirDay,
                        onChanged: (value) {
                          setState(() {
                            selectedTheirDay = value;
                          });
                        },
                      ),

                      const SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'ApartmentNumber'.tr(context),
                              hintText: 'ApartmentNumber'.tr(context),
                              controller: numberOfApartmentController,
                            ),
                          ),
                          const SizedBox(width: defaultPadding),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      DropdownField(
                        label: "Familymembers".tr(context),
                        items: const [
                          "father",
                          "mother",
                          "son",
                          "daughter",
                        ],
                        selectedValue: family.memberType ?? 'father',
                        onChanged: (value) {
                          setState(() {
                            selectedFamilyMember = value;
                          });
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      BlocConsumer<FamilyCubit, FamilyState>(
                        listener: (context, state) {
                          if (state is UpdateFamilySuccess) {
                            Navigator.pop(context);
                            context.read<FamilyCubit>().getAllFamilies();
                            SnackbarWidget.show(
                                context, "FamilyModifiedSuccessfully".tr(context));
                          } else if (state is UpdateFamilyFailure) {
                            SnackbarWidget.show(
                                context, state.errorModel.message ?? '');
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<FamilyCubit>().updateFamily(
                                  id: family.sId ?? '',
                                  userName:
                                      family.userName != usernameController.text
                                          ? usernameController.text
                                          : null,
                                  email: family.email != emailController.text
                                      ? emailController.text
                                      : null,
                                  noOfAppartment: family.noOfAppartment !=
                                          int.parse(
                                              numberOfApartmentController.text)
                                      ? int.parse(
                                          numberOfApartmentController.text)
                                      : null,
                                  phone: family.phone != phoneController.text
                                      ? phoneController.text
                                      : null,
                                  memberType: selectedFamilyMember);
                            },
                            child: state is UpdateFamilyLoading
                                ? const SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator())
                                :   Text('Modifythefamily'.tr(context)),
                          );
                        },
                      ),

                      const SizedBox(height: defaultPadding),

                      const Divider(),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: 'oldPassword'.tr(context),
                        hintText:'oldPassword'.tr(context),
                        controller: passwordController,
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label:"modernpassword".tr(context),
                        hintText: "modernpassword".tr(context),
                        controller: cPasswordController,
                      ),
                      const SizedBox(height: defaultPadding),
                      BlocConsumer<FamilyCubit, FamilyState>(
                        listener: (context, state) {
                          if (state is UpdateFamilyPasswordSuccess) {
                            Navigator.pop(context);
                            context.read<FamilyCubit>().getAllFamilies();
                            SnackbarWidget.show(
                                context, "FamilyModifiedSuccessfully".tr(context));
                          } else if (state is UpdateFamilyPasswordFailure) {
                            SnackbarWidget.show(
                                context, state.errorModel.message ?? '');
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<FamilyCubit>().updateFamilyPassword(
                                    id: family.sId ?? '',
                                    oldPassword: passwordController.text,
                                    newPassword: cPasswordController.text,
                                  );
                            },
                            child: state is UpdateFamilyPasswordLoading
                                ? const SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator())
                                :   Text('ChangePassword'.tr(context)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
