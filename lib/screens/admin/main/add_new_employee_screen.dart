//
// class _AddNewEmployeeScreenState extends State<AddNewEmployeeScreen> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();
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
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the selectedLanguages map with all items set to false
//     for (var language in languages) {
//       selectedLanguages[language] = false;
//     }
//     for (var day in daysList) {
//       selectedDays[day] = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('إضافة موظف جديد',
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
//                       CustomTextField(
//                         label: 'الرقم السري للموظف',
//                         hintText: 'الرقم السري للموظف',
//                         controller: passwordController,
//                       ),
//                       const SizedBox(height: defaultPadding),
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
//                       // Display selected languages
//                       Text(
//                 "التخصص في العمل",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: defaultPadding / 2),
//                       // Submit button
//                       BlocConsumer<EmployeesCubit, EmployeesState>(
//                         listener: (context, state) {
//                           if (state is AddEmployeeSuccess) {
//                             context.read<EmployeesCubit>().getAllEmployees();
//                             Navigator.pop(context);
//                             SnackbarWidget.show(context, "تمت الاضافة بنجاح");
//                           } else if (state is AddEmployeeFailure) {
//                             SnackbarWidget.show(
//                               context,
//                               state.errorModel.message ?? '',
//                             );
//                           }
//                         },
//                         builder: (context, state) {
//                           return ElevatedButton(
//                             onPressed: () {
//                               context.read<EmployeesCubit>().addEmployee(
//                                     userName: nameController.text,
//                                     email: emailController.text,
//                                     phone: phoneController.text,
//                                     password: passwordController.text,
//                                     confirmPassword: passwordController.text,
//                                     languages: selectedLanguages.entries
//                                         .where((entry) => entry.value)
//                                         .map((entry) => entry.key)
//                                         .toList(),
//                                     days: selectedDays.entries
//                                         .where((entry) => entry.value)
//                                         .map((e) => e.key)
//                                         .toList(),
//                                 workSpecialization: ["fbf"]
//                                   );
//                             },
//                             child: state is AddEmployeeLoading
//                                 ? const SizedBox(
//                                     height: 15,
//                                     width: 15,
//                                     child: CircularProgressIndicator(),
//                                   )
//                                 : const Text('إضافة موظف جديد'),
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
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/employees/employees_cubit.dart';
import 'package:mycompass_admin_website/widgets/custom_textform_field.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

class AddNewEmployeeScreen extends StatefulWidget {
  const AddNewEmployeeScreen({super.key});

  @override
  State<AddNewEmployeeScreen> createState() => _AddNewEmployeeScreenState();
}

class _AddNewEmployeeScreenState extends State<AddNewEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Controllers for Work Specialization
  final List<TextEditingController> workSpecializationControllers = [];

  final List<TextEditingController> languages = [

  ];
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

  @override
  void initState() {
    super.initState();
    // for (var language in languages) {
    //   selectedLanguages[language] = false;
    // }
    for (var day in daysList) {
      selectedDays[day] = false;
    }
    // Initialize with one empty specialization field
    workSpecializationControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    // Dispose all controllers
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    for (var controller in workSpecializationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AddanewEmployee'.tr(context),
          style: Theme.of(context).textTheme.bodyLarge!,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
                      label: 'EmployeeEmail'.tr(context),
                      hintText: 'EmployeeEmail'.tr(context),
                      controller: emailController,
                    ),
                    const SizedBox(height: defaultPadding),

                    CustomTextField(
                      label: 'Employeesecretnumber'.tr(context),
                      hintText: 'Employeesecretnumber'.tr(context),
                      controller: passwordController,
                    ),
                    const SizedBox(height: defaultPadding),

                    CustomTextField(
                      label: 'phoneNumber'.tr(context),
                      hintText: 'phoneNumber'.tr(context),
                      controller: phoneController,
                    ),

                    const SizedBox(height: 20),
                    titleWidget("Selectedlanguages".tr(context)),
                    const SizedBox(height: 8),

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
                    const SizedBox(height: 8),
                    // Button to Add New Work Specialization
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            languages.add(TextEditingController());
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: Text("AddANewLanguages".tr(context)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(50, 30),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
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
                    //       controlAffinity: ListTileControlAffinity
                    //           .leading, // Checkbox on the left
                    //     );
                    //   }).toList(),
                    // ),
                    // const SizedBox(height: defaultPadding),
                    // const SizedBox(height: defaultPadding / 2),
                    //
                    // Text(
                    //   selectedLanguages.entries
                    //       .where(
                    //           (entry) => entry.value) // Filter selected items
                    //       .map((entry) => entry.key) // Get the item name
                    //       .join(', '), // Join them with a comma
                    //   style: const TextStyle(fontSize: 16),
                    // ),
                    const SizedBox(height: 20),
                    // Display selected SelectedDays
                    titleWidget("SelectedDays".tr(context)),
                    const SizedBox(height: defaultPadding),
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
                          controlAffinity: ListTileControlAffinity
                              .leading, // Checkbox on the left
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      selectedDays.entries
                          .where(
                              (entry) => entry.value) // Filter selected items
                          .map((entry) => entry.key) // Get the item name
                          .join(', '), // Join them with a comma
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: defaultPadding),

                    // Work Specialization Section

                    titleWidget("WorkSpecialization".tr(context)),

                    const SizedBox(height: defaultPadding / 2),

                    // Dynamic Text Fields for Work Specialization
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
                                      ' ${"Workspecialization".tr(context)} ${i + 1}',
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

                    BlocConsumer<EmployeesCubit, EmployeesState>(
                      listener: (context, state) {
                        if (state is AddEmployeeSuccess) {
                          context.read<EmployeesCubit>().getAllEmployees();
                          Navigator.pop(context);
                          SnackbarWidget.show(
                              context, "Addedsuccessfully".tr(context));
                        } else if (state is AddEmployeeFailure) {
                          SnackbarWidget.show(
                            context,
                            state.errorModel.message ?? '',
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            context.read<EmployeesCubit>().addEmployee(
                                  userName: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                  confirmPassword: passwordController.text,
                                  languages:
                                      languages.map((e) => e.text).toList(),
                                  // selectedLanguages.entries
                                  //     .where((entry) => entry.value)
                                  //     .map((entry) => entry.key)
                                  //     .toList(),
                                  days: selectedDays.entries
                                      .where((entry) => entry.value)
                                      .map((e) => e.key)
                                      .toList(),
                                  workSpecialization:
                                      workSpecializationControllers
                                          .map(
                                              (controller) => controller.text)
                                          .toList(),
                                );
                          },
                          child: state is AddEmployeeLoading
                              ? const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(),
                                )
                              : Text('Addanewemployee'.tr(context)),
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

  Widget titleWidget(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
