import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/core/responsive.dart';
import 'package:mycompass_admin_website/managers/employees/employees_cubit.dart';
import 'package:mycompass_admin_website/models/employee_model.dart';
import 'package:mycompass_admin_website/models/recent_employee.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_dashboard_header.dart';

class AdminShowAllInStaffScreen extends StatefulWidget {
  const AdminShowAllInStaffScreen({super.key});

  @override
  State<AdminShowAllInStaffScreen> createState() =>
      _AdminShowAllInStaffScreenState();
}

class _AdminShowAllInStaffScreenState extends State<AdminShowAllInStaffScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeesCubit>().getAllEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            AdminDashboardHeader(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyAllEmployees(),
                      SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyAllEmployees extends StatelessWidget {
  const MyAllEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController horizontalScrollController = ScrollController();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "AllEmployees".tr(context),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                print('Create');

                Navigator.pushNamed(context, RoutesName.addNewEmployee);
              },
              icon: const Icon(Icons.add),
              label: Text("Addanewemployee".tr(context),
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AllEmployees".tr(context),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: defaultPadding),
              LayoutBuilder(builder: (context, constraints) {
                return Scrollbar(
                  controller: horizontalScrollController,
                  // Attach the same controller
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: horizontalScrollController,
                    // Attach the same controller
                    scrollDirection: Axis.horizontal,
                    child: BlocConsumer<EmployeesCubit, EmployeesState>(
                      listener: (context, state) {
                        if (state is DeleteEmployeeSuccess) {
                          context.read<EmployeesCubit>().getAllEmployees();
                        }
                      },
                      builder: (context, state) {
                        var cubit = context.read<EmployeesCubit>();
                        var employeeModel = cubit.employeeModel;
                        List<EmployeeModelData>? list = employeeModel?.result;
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                          ),
                          child: list == null
                              ? const Center(child: CircularProgressIndicator())
                              : buildRecentEmployees(context, list),
                        );
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRecentEmployees(
    BuildContext context,
    List<EmployeeModelData> list,
  ) {
    return DataTable(
      columns:   [
        DataColumn(
          label: Text(
            "name".tr(context),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            "email".tr(context),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            "phoneNumber".tr(context),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text("Procedure".tr(context)), // Empty label for actions column
        ),
      ],
      rows: list
          .map(
            (employee) => DataRow(
              cells: [
                DataCell(Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/menu_profile.svg',
                      height: 20,
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                        Colors.white54,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(child: Text(employee.userName ?? "")),
                  ],
                )),
                DataCell(Text(employee.email ?? "")),
                DataCell(Text(employee.phone ?? "")),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: Responsive.isMobile(context)
                            ? const Icon(Iconsax.edit)
                            :   Row(
                                children: [
                                  Icon(Iconsax.edit),
                                  SizedBox(width: 5),
                                  Text('Edit'.tr(context),),
                                ],
                              ),
                        color: Colors.lightBlue,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.editEmployeeScreen,
                            arguments: employee,
                          );

                          // Handle employee edit action (navigation or functionality)
                        },
                      ),
                      BlocBuilder<EmployeesCubit, EmployeesState>(
                        builder: (context, state) {
                          return IconButton(
                            icon: Responsive.isMobile(context)
                                ? const Icon(Iconsax.profile_delete)
                                :   Row(
                                    children: [
                                      Icon(Iconsax.profile_delete),
                                      SizedBox(width: 5),
                                      Text('delete'.tr(context)),
                                    ],
                                  ),
                            color: Colors.red,
                            onPressed: () {
                              context
                                  .read<EmployeesCubit>()
                                  .deleteEmployee(id: employee.sId ?? "");
                              // Handle employee delete action (confirmation dialog etc.)
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  // employee.widgetEditable(context)
                ),
              ],
            ),
          )
          .toList(),

      // demoRecentEmployees
      //     .map((employee) => DataRow(cells: [
      //           DataCell(Row(
      //             children: [
      //               SvgPicture.asset(
      //                 'assets/icons/menu_profile.svg',
      //                 height: 20,
      //                 width: 20,
      //                 colorFilter: const ColorFilter.mode(
      //                     Colors.white54, BlendMode.srcIn),
      //               ),
      //               const SizedBox(width: 8),
      //               Flexible(child: Text(employee.name ?? "")),
      //             ],
      //           )),
      //           DataCell(Text(employee.emailAddress ?? "")),
      //           DataCell(Text(employee.phoneNumber ?? "")),
      //           DataCell(employee.widgetEditable(context)),
      //         ]))
      //     .toList(),
    );
  }
}
