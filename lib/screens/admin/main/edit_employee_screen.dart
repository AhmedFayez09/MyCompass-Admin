// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mycompass_admin_website/core/constants.dart';
// import 'package:mycompass_admin_website/core/functions/chect_equal_list.dart';
// import 'package:mycompass_admin_website/managers/employees/employees_cubit.dart';
// import 'package:mycompass_admin_website/models/employee_model.dart';
// import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';
// import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';
//
// class EditEmployeeScreen extends StatefulWidget {
//   const EditEmployeeScreen({super.key});
//
//   @override
//   State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
// }
//
// class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//
//   // final passwordController = TextEditingController();
//
// // List of items for the checkbox
//   final List<String> languages = [
//     "English",
//     "Mandarin Chinese",
//     "Spanish",
//     "Hindi",
//     "Arabic",
//     "French",
//   ];
//   final List<String> daysList = [
//     "Monday",
//     "Tuesday",
//     "Wednesday",
//     "Thursday",
//     "Friday",
//     "Saturday",
//     "Sunday",
//   ];
//
//   // Map to track the selected state of each item
//   Map<String, bool> selectedLanguages = {};
//   Map<String, bool> selectedDays = {};
//   EmployeeModelData employee = EmployeeModelData();
//
//   @override
//   void initState() {
//     super.initState();
//     for (var language in languages) {
//       selectedLanguages[language] = false;
//     }
//     for (var day in daysList) {
//       selectedDays[day] = false;
//     }
//
//     // Pre-select languages and days based on employee data
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) {
//         EmployeeModelData employee =
//             ModalRoute.of(context)!.settings.arguments as EmployeeModelData;
//         employee.copyWith(
//           languages: employee.languages,
//           days: employee.days,
//         );
//         if (employee.languages != null) {
//           for (var language in employee.languages!) {
//             selectedLanguages[language] = true;
//           }
//         }
//
//         if (employee.days != null) {
//           for (var day in employee.days!) {
//             selectedDays[day] = true;
//           }
//         }
//         setState(() {});
//       },
//     );
//   }
//
//   int i = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     i++;
//     EmployeeModelData employeeB =
//         ModalRoute.of(context)!.settings.arguments as EmployeeModelData;
//     if (i == 1) {
//       employee.copyWith(
//         userName: employee.userName,
//         email: employee.email,
//         phone: employee.phone,
//       );
//       nameController.text = employeeB.userName ?? '';
//       emailController.text = employeeB.email ?? '';
//       phoneController.text = employeeB.phone ?? '';
//     }
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('تعديل بيانات الموظف',
//               style: Theme.of(context).textTheme.bodyLarge!),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context); // Back to previous screen
//             },
//           ),
//           backgroundColor: Colors.deepPurple,
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(defaultPadding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: defaultPadding),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(defaultPadding),
//                   decoration: BoxDecoration(
//                     color: secondaryColor,
//                     borderRadius: BorderRadius.circular(defaultPadding / 2),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'المعلومات الخاصة بالموظفين',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: defaultPadding),
//
//                       CustomTextField(
//                         label: 'أسم الموظف',
//                         hintText: 'أسم الموظف',
//                         controller: nameController,
//                       ),
//                       const SizedBox(height: defaultPadding),
//
//                       CustomTextField(
//                         label: 'البريد الإلكتروني للموظف',
//                         hintText: 'البريد الإلكتروني للموظف',
//                         controller: emailController,
//                       ),
//                       const SizedBox(height: defaultPadding),
//
//                       // CustomTextField(
//                       //   label: 'الرقم السري للموظف',
//                       //   hintText: 'الرقم السري للموظف',
//                       //   controller: passwordController,
//                       // ),
//                       // const SizedBox(height: defaultPadding),
//
//                       CustomTextField(
//                         label: 'رقم واتساب الموظف',
//                         hintText: 'رقم واتساب الموظف',
//                         controller: phoneController,
//                       ),
//                       const SizedBox(height: defaultPadding),
//
//                       Column(
//                         children: languages.map((language) {
//                           return CheckboxListTile(
//                             title: Text(language),
//                             value: selectedLanguages[language],
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 selectedLanguages[language] = value!;
//                               });
//                             },
//                             controlAffinity: ListTileControlAffinity
//                                 .leading, // Checkbox on the left
//                           );
//                         }).toList(),
//                       ),
//                       const SizedBox(height: 20),
//                       // Display selected languages
//                       Text(
//                         'اللغات المختارة:',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: defaultPadding / 2),
//
//                       Text(
//                         selectedLanguages.entries
//                             .where(
//                                 (entry) => entry.value) // Filter selected items
//                             .map((entry) => entry.key) // Get the item name
//                             .join(', '), // Join them with a comma
//                         style: TextStyle(fontSize: 16),
//                       ),
//
//                       const SizedBox(height: defaultPadding),
//                       Column(
//                         children: daysList.map((day) {
//                           return CheckboxListTile(
//                             title: Text(day),
//                             value: selectedDays[day],
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 selectedDays[day] = value!;
//                               });
//                             },
//                             controlAffinity: ListTileControlAffinity
//                                 .leading, // Checkbox on the left
//                           );
//                         }).toList(),
//                       ),
//                       const SizedBox(height: 20),
//                       // Display selected languages
//                       Text(
//                         'الايام المختارة:',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: defaultPadding / 2),
//
//                       Text(
//                         selectedDays.entries
//                             .where(
//                                 (entry) => entry.value) // Filter selected items
//                             .map((entry) => entry.key) // Get the item name
//                             .join(', '), // Join them with a comma
//                         style: TextStyle(fontSize: 16),
//                       ),
//
//                       const SizedBox(height: defaultPadding),
//
//                       // Submit button
//                       BlocConsumer<EmployeesCubit, EmployeesState>(
//                         listener: (context, state) {
//                           if (state is UpdateEmployeeSuccess) {
//                             context.read<EmployeesCubit>().getAllEmployees();
//                             Navigator.pop(context);
//                             SnackbarWidget.show(context, "تم التعديل  بنجاح");
//                           } else if (state is UpdateEmployeeFailure) {
//                             SnackbarWidget.show(
//                               context,
//                               state.errorModel.message ?? '',
//                             );
//                           }
//                         },
//                         builder: (context, state) {
//                           var lang = selectedLanguages.entries
//                               .where((entry) => entry.value)
//                               .map((entry) => entry.key)
//                               .toList();
//                           var days = selectedDays.entries
//                               .where((entry) => entry.value)
//                               .map((e) => e.key)
//                               .toList();
//                           return ElevatedButton(
//                             onPressed: () {
//                               print("comeing ${employeeB.languages}");
//                               print(
//                                   "Selected ${selectedLanguages.entries.where((entry) => entry.value).map((entry) => entry.key).toList()}");
//                               print(
//                                   "${areListsIdentical(employeeB.languages ?? [], lang)}");
//
//                               context.read<EmployeesCubit>().updateEmployee(
//                                   id: employeeB.sId ?? '',
//                                   userName:
//                                       employeeB.userName == nameController.text
//                                           ? null
//                                           : nameController.text,
//                                   phone: employeeB.phone == phoneController.text
//                                       ? null
//                                       : phoneController.text,
//                                   languages: areListsIdentical(
//                                           employeeB.languages ?? [], lang)
//                                       ? null
//                                       : selectedLanguages.entries
//                                           .where((entry) => entry.value)
//                                           .map((entry) => entry.key)
//                                           .toList(),
//                                   days: areListsIdentical(
//                                           employeeB.days ?? [],
//                                           selectedDays.entries
//                                               .where((entry) => entry.value)
//                                               .map((e) => e.key)
//                                               .toList())
//                                       ? null
//                                       : selectedDays.entries
//                                           .where((entry) => entry.value)
//                                           .map((e) => e.key)
//                                           .toList());
//                               // password: passwordController.text,
//                               // confirmPassword: passwordController.text,
//                               // languages: selectedLanguages.entries
//                               //     .where((entry) => entry.value)
//                               //     .map((entry) => entry.key)
//                               //     .toList(),
//                               // days: selectedDays.entries
//                               //     .where((entry) => entry.value)
//                               //     .map((e) => e.key)
//                               //     .toList(),
//                               // );
//                             },
//                             child: state is UpdateEmployeeLoading
//                                 ? const SizedBox(
//                                     height: 15,
//                                     width: 15,
//                                     child: CircularProgressIndicator(),
//                                   )
//                                 : const Text('تعديل'),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/functions/chect_equal_list.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';

// import 'package:mycompass_admin_website/core/functions/check_equal_list.dart';
import 'package:mycompass_admin_website/managers/employees/employees_cubit.dart';
import 'package:mycompass_admin_website/models/employee_model.dart';
import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

class EditEmployeeScreen extends StatefulWidget {
  const EditEmployeeScreen({super.key});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final List<TextEditingController> workSpecializationControllers = [];

  final List<TextEditingController> languages = [];

  final List<String> daysList = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  Map<String, bool> selectedLanguages = {};
  Map<String, bool> selectedDays = {};
  EmployeeModelData employee = EmployeeModelData();

  @override
  void initState() {
    super.initState();

    for (var day in daysList) {
      selectedDays[day] = false;
    }

    // Pre-select languages and days based on employee data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EmployeeModelData employeeB =
          ModalRoute.of(context)!.settings.arguments as EmployeeModelData;
      nameController.text = employeeB.userName ?? '';
      emailController.text = employeeB.email ?? '';
      phoneController.text = employeeB.phone ?? '';

      // Initialize specialization controllers
      for (var specialization in employeeB.workSpecialization ?? []) {
        workSpecializationControllers
            .add(TextEditingController(text: specialization));
      }

      for (var lang in employeeB.languages ?? []) {
        languages.add(TextEditingController(text: lang));
      }

      if (employeeB.languages != null) {
        for (var language in employeeB.languages!) {
          selectedLanguages[language] = true;
        }
      }

      if (employeeB.days != null) {
        for (var day in employeeB.days!) {
          selectedDays[day] = true;
        }
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    for (var controller in workSpecializationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EmployeeModelData employeeB =
        ModalRoute.of(context)!.settings.arguments as EmployeeModelData;

    return Scaffold(
      appBar: AppBar(
        title: Text("Editemployeedata".tr(context),
            style: Theme.of(context).textTheme.bodyLarge!),
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
                      'EmployeeInformation'.tr(context),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),

                    CustomTextField(
                      label: 'EmployeeName'.tr(context),
                      hintText: 'EmployeeName'.tr(context),
                      controller: nameController,
                    ),
                    const SizedBox(height: defaultPadding),

                    CustomTextField(
                      label: "EmployeeEmail".tr(context),
                      hintText: "EmployeeEmail".tr(context),
                      controller: emailController,
                    ),
                    const SizedBox(height: defaultPadding),

                    CustomTextField(
                      label: 'EmployeeWhatsAppNumber'.tr(context),
                      hintText: 'EmployeeWhatsAppNumber'.tr(context),
                      controller: phoneController,
                    ),
                    const SizedBox(height: defaultPadding),

                    // Languages Section
                    Text(
                      "Selectedlanguages".tr(context),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        for (int i = 0; i < languages.length; i++)
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label:
                                      ' ${"languages".tr(context)} ${i + 1}',
                                  hintText: 'Writeyourlanguages'.tr(context),
                                  controller: languages[i],
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    languages.removeAt(i);
                                  });
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                    // Column(
                    //   children: languages.map((language) {
                    //     return CheckboxListTile(
                    //       title: Text(language),
                    //       value: selectedLanguages[language],
                    //       onChanged: (bool? value) {
                    //         setState(() {
                    //           selectedLanguages[language] = value!;
                    //         });
                    //       },
                    //       controlAffinity: ListTileControlAffinity.leading,
                    //     );
                    //   }).toList(),
                    // ),
                    // const SizedBox(height: 20),
                    // Text(
                    //   "Selectedlanguages".tr(context),
                    //   style: const TextStyle(
                    //       fontSize: 16, fontWeight: FontWeight.bold),
                    // ),
                    // Text(
                    //   selectedLanguages.entries
                    //       .where((entry) => entry.value)
                    //       .map((entry) => entry.key)
                    //       .join(', '),
                    //   style: const TextStyle(fontSize: 16),
                    // ),
                    const SizedBox(height: defaultPadding),

                    // Days Section
                    Column(
                      children: daysList.map((day) {
                        return CheckboxListTile(
                          title: Text(day),
                          value: selectedDays[day],
                          onChanged: (bool? value) {
                            setState(() {
                              selectedDays[day] = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "SelectedDays".tr(context),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      selectedDays.entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key)
                          .join(', '),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: defaultPadding),

                    // Work Specialization Section
                    Text(
                      "WorkSpecialization".tr(context),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Column(
                      children: [
                        for (int i = 0;
                            i < workSpecializationControllers.length;
                            i++)
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label:
                                      ' ${"WorkSpecialization".tr(context)} ${i + 1}',
                                  hintText: 'Writeyourjobspecializationhere'
                                      .tr(context),
                                  controller:
                                      workSpecializationControllers[i],
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    workSpecializationControllers.removeAt(i);
                                  });
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Button to Add New Work Specialization
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            workSpecializationControllers
                                .add(TextEditingController());
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: Text("Addanewjobspecialization".tr(context)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(50, 30),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: defaultPadding),

                    // Submit button
                    BlocConsumer<EmployeesCubit, EmployeesState>(
                      listener: (context, state) {
                        if (state is UpdateEmployeeSuccess) {
                          context.read<EmployeesCubit>().getAllEmployees();
                          Navigator.pop(context);
                          SnackbarWidget.show(
                              context, "ModifiedSuccessfully".tr(context));
                        } else if (state is UpdateEmployeeFailure) {
                          SnackbarWidget.show(
                            context,
                            state.errorModel.message ?? '',
                          );
                        }
                      },
                      builder: (context, state) {
                        var lang = selectedLanguages.entries
                            .where((entry) => entry.value)
                            .map((entry) => entry.key)
                            .toList();

                        var days = selectedDays.entries
                            .where((entry) => entry.value)
                            .map((e) => e.key)
                            .toList();

                        var workSpecializations =
                            workSpecializationControllers
                                .map((controller) => controller.text)
                                .toList();

                        return ElevatedButton(
                          onPressed: () {
                            context.read<EmployeesCubit>().updateEmployee(
                                  id: employeeB.sId ?? '',
                                  userName: employeeB.userName ==
                                          nameController.text
                                      ? null
                                      : nameController.text,
                                  phone:
                                      employeeB.phone == phoneController.text
                                          ? null
                                          : phoneController.text,
                                  languages: areListsIdentical(
                                          employeeB.languages ?? [], lang)
                                      ? null
                                      : lang,
                                  days: areListsIdentical(
                                          employeeB.days ?? [], days)
                                      ? null
                                      : days,
                                  workSpecialization: areListsIdentical(
                                          employeeB.workSpecialization ?? [],
                                          workSpecializations)
                                      ? null
                                      : workSpecializations,
                                );
                          },
                          child: state is UpdateEmployeeLoading
                              ? const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(),
                                )
                              : Text('Edit'.tr(context)),
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
    );
  }
}
