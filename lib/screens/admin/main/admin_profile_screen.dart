import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_profile_header.dart';
import 'package:mycompass_admin_website/widgets/custom_drop_down_field.dart';
import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

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
    // TODO: implement initState
    super.initState();
    context.read<AdminCubit>().getProfile();
    context.read<AdminCubit>().getUsersStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: const EdgeInsets.all(defaultPadding),
          child: BlocBuilder<AdminCubit, AdminState>(
            builder: (context, state) {
              emailController.text =
                  context.read<AdminCubit>().profileModel?.result?.email ?? '';
              userNameController.text =
                  context.read<AdminCubit>().profileModel?.result?.userName ??
                      '';
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
                        const Text(
                          'المعلومات الشخصية',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        CustomTextField(
                          label: 'البريد الإلكتروني',
                          hintText: 'example@gmail.com',
                          controller: emailController,
                        ),
                        const SizedBox(height: defaultPadding),
                        CustomTextField(
                          label: 'أدخل اسمك',
                          hintText: 'الاسم',
                          controller: userNameController,
                        ),
                        const SizedBox(height: defaultPadding),
                        CustomTextField(
                          label: 'رقم الهاتف',
                          hintText: '+20-10-XXXXXXX',
                          controller: phoneController,
                        ),
                        const SizedBox(height: defaultPadding),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Print all the form data
                        //     print('البريد الإلكتروني: ${emailController.text}');
                        //     print('اسم العائلة: ${userNameController.text}');
                        //     print('رقم الهاتف: ${phoneController.text}');
                        //   },
                        //   child: const Text('تحديث الملف الشخصي'),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RoutesName.usersStatusScreen);
                    },
                    child: Text("اظهار جميع حالات المستخدمين"),
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
                        const Text(
                          'المعلومات الخاصة بالاشعارات',
                          style: TextStyle(
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
                                const SnackBar(
                                    content: Text('تم اضافة الاشعار بنجاح')),
                              );
                              Navigator.pushNamed(context, RoutesName.usersStatusScreen);
                              context.read<AdminCubit>().getUsersStatus();
                            } else if (state is CreateFastNotificationFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('لم يتم اضافة الاشعار')),
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
                                  ? SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: const CircularProgressIndicator())
                                  : Text("اضافة اشعار سريع"),
                            );
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        CustomTextField(
                          label: 'العنوان',
                          hintText: 'هام جدا',
                          controller: notificationTitleController,
                        ),
                        const SizedBox(height: defaultPadding),
                        CustomTextField(
                          label: 'المحتوي',
                          hintText: 'الي كل مستخدمي السيستم .....',
                          controller: notificationContentController,
                        ),
                        const SizedBox(height: defaultPadding),
                        BlocConsumer<AdminCubit, AdminState>(
                          listener: (context, state) {
                            if (state is CreateCustomNotificationSuccess) {
                              Navigator.pushNamed(context, RoutesName.usersStatusScreen);
                              context.read<AdminCubit>().getUsersStatus();
                              notificationContentController.clear();
                              notificationTitleController.clear();
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                if (notificationTitleController.text.isEmpty ||
                                    notificationContentController
                                        .text.isEmpty) {
                                  SnackbarWidget.show(
                                      context, "يجب ادخال جميع البيانات");
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
                                  : const Text('اضافة الاشعار'),
                            );
                          },
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
      ),
    );
  }
}
