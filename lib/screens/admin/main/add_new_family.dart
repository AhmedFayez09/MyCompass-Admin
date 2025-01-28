import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/managers/family/family_cubit.dart';
import 'package:mycompass_admin_website/widgets/custom_drop_down_field.dart';
import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

class AddNewFamilyScreen extends StatefulWidget {
  const AddNewFamilyScreen({super.key});

  @override
  State<AddNewFamilyScreen> createState() => _AddNewFamilyScreenState();
}

class _AddNewFamilyScreenState extends State<AddNewFamilyScreen> {
  // Define all controllers as fields
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final numberOfApartmentController = TextEditingController();

  // Define selected family member
  String selectedFamilyMember = 'father';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Addanewfamily'.tr(context),
              style: Theme.of(context).textTheme.bodyLarge),
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
                        label: "email".tr(context),
                        hintText: 'example@gmail.com',
                        controller: emailController,
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: "username".tr(context),
                        hintText: 'أدخل اسم المستخدم',
                        controller: usernameController,
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: 'phoneNumber'.tr(context),
                        hintText: '+20-10-XXXXXXX',
                        controller: phoneController,
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'ApartmentNumber'.tr(context),
                              hintText: 'أدخل رقم الشقة',
                              controller: numberOfApartmentController,
                            ),
                          ),
                          const SizedBox(width: defaultPadding),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: 'password'.tr(context),
                        hintText: 'الرقم السري',
                        controller: passwordController,
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: "Confirmadminpassword".tr(context),
                        hintText: "Confirmadminpassword".tr(context),
                        controller: cPasswordController,
                      ),
                      const SizedBox(height: defaultPadding),
                      DropdownField(
                        label: 'familyMember'.tr(context),
                        items: const [
                          "father",
                          "mother",
                          "son",
                          "daughter",
                        ],
                        selectedValue: selectedFamilyMember,
                        onChanged: (value) {
                          setState(() {
                            selectedFamilyMember = value;
                          });
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      BlocConsumer<FamilyCubit, FamilyState>(
                        listener: (context, state) {
                          if (state is CreateNewFamilySuccess) {
                            Navigator.pop(context);
                            context.read<FamilyCubit>().getAllFamilies();

                            SnackbarWidget.show(
                              context,
                              state.message ?? 'Newfamilyaddedsuccessfully'.tr(context),
                            );
                          } else if (state is CreateNewFamilyFailure) {
                            SnackbarWidget.show(
                              context,
                              state.errorModel.message!,
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<FamilyCubit>().createNewFamily(
                                    userName: usernameController.text,
                                    email: emailController.text,
                                    noOfAppartment: int.tryParse(
                                            numberOfApartmentController.text) ??
                                        0,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    cPassword: cPasswordController.text,
                                memberType: selectedFamilyMember
                                  );
                            },
                            child: state is CreateNewFamilyLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                :   Text('Addanewfamily'.tr(context)),
                          );
                        },
                      )
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
