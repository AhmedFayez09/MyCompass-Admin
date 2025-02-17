import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_profile_header.dart';
import 'package:mycompass_admin_website/widgets/custom_drop_down_field.dart';
import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

import '../../../core/functions/chect_equal_list.dart';
import '../../../core/local_storage/cache_helper.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  AdminProfileScreenState createState() => AdminProfileScreenState();
}

class AdminProfileScreenState extends State<AdminProfileScreen> {
  // Define controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController notificationTitleController =
      TextEditingController();
  final TextEditingController notificationContentController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().getProfile();
    context.read<AdminCubit>().getUsersStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            emailController.text =
                context.read<AdminCubit>().profileModel?.result?.email ?? '';
            userNameController.text =
                context.read<AdminCubit>().profileModel?.result?.userName ?? '';
            phoneController.text =
                context.read<AdminCubit>().profileModel?.result?.phone ?? '';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AdminProfileHeader(),
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
                        'PersonalInformation'.tr(context),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: 'email'.tr(context),
                        hintText: 'example@gmail.com',
                        controller: emailController,
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: 'EnterYourName'.tr(context),
                        hintText: 'Name'.tr(context),
                        controller: userNameController,
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: 'phoneNumber'.tr(context),
                        hintText: '+20-10-XXXXXXX',
                        controller: phoneController,
                      ),
                      const SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.usersStatusScreen);
                  },
                  child: Text("ShowAllUserStatuses".tr(context)),
                ),
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
                        'NotificationInformation'.tr(context),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      BlocConsumer<AdminCubit, AdminState>(
                        listener: (context, state) {
                          if (state is CreateFastNotificationSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'TheNotificationHasBeenAddedSuccessfully'
                                      .tr(context),
                                ),
                              ),
                            );
                            Navigator.pushNamed(
                                context, RoutesName.usersStatusScreen);
                            context.read<AdminCubit>().getUsersStatus();
                          } else if (state is CreateFastNotificationFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Thenotificationhasnotbeenadded'
                                      .tr(context))),
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AdminCubit>()
                                  .createFastNotification();
                            },
                            child: state is CreateFastNotificationLoading
                                ? const SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator())
                                : Text(
                                    "${"Underspecification".tr(context)}(${"Alarm".tr(context)})"),
                          );
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: 'address'.tr(context),
                        hintText: 'VeryImportant'.tr(context),
                        controller: notificationTitleController,
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        label: 'Content'.tr(context),
                        hintText: 'Toallusersofthesystem'.tr(context),
                        controller: notificationContentController,
                      ),
                      const SizedBox(height: defaultPadding),
                      BlocConsumer<AdminCubit, AdminState>(
                        listener: (context, state) {
                          if (state is CreateCustomNotificationSuccess) {
                            Navigator.pushNamed(
                                context, RoutesName.usersStatusScreen);
                            context.read<AdminCubit>().getUsersStatus();
                            notificationContentController.clear();
                            notificationTitleController.clear();
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              if (notificationTitleController.text.isEmpty ||
                                  notificationContentController.text.isEmpty) {
                                SnackbarWidget.show(context,
                                    "Alldatamustbeentered".tr(context));
                              } else {
                                context
                                    .read<AdminCubit>()
                                    .createFastNotification(
                                      title: notificationTitleController.text,
                                      description:
                                          notificationContentController.text,
                                    );
                              }

                              // Print all the form data
                              // print('رقم الهاتف: ${phoneController.text}');
                            },
                            child: state is CreateCustomNotificationLoading
                                ? const SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator())
                                : Text('AddNotification'.tr(context)),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                          title: Text("PrivacyPolicy".tr(context)),
                          trailing: const Icon(
                            Iconsax.info_circle,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.privacyPolicy);
                          }),
                      const SizedBox(height: 20),
                      ListTile(
                        title: Text(
                          "logout".tr(context),
                        ),
                        trailing: const Icon(Icons.logout, color: Colors.red),
                        onTap: () => logout(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding * 2),
              ],
            );
          },
        ),
      ),
    );
  }
}
