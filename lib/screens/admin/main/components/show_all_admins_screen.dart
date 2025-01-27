import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/responsive.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/managers/admin_cubit_fun/admin_fun_cubit.dart';
import 'package:mycompass_admin_website/models/main/get_all_admins_data_model.dart';
import 'package:mycompass_admin_website/models/recent_admin.dart';
import 'package:mycompass_admin_website/models/recent_employee.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_dashboard_header.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

class ShowAllAdminsScreen extends StatefulWidget {
  const ShowAllAdminsScreen({super.key});

  @override
  State<ShowAllAdminsScreen> createState() => _ShowAllAdminsScreenState();
}

class _ShowAllAdminsScreenState extends State<ShowAllAdminsScreen> {
  @override
  void initState() {
    AdminFunCubit.of(context).getAllAdmins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
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
                      Admins(),
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

class Admins extends StatelessWidget {
  const Admins({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController horizontalScrollController = ScrollController();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "جميع الأدمنز",
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

                Navigator.pushNamed(context, RoutesName.addNewAdmin);
              },
              icon: const Icon(Icons.add),
              label: Text("إضافة أدمن جديد",
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
                "جميع الأدمنز",
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
                    child: BlocConsumer<AdminFunCubit, AdminFunState>(
                      listener: (context, state) {
                        if (state is DeleteAdminSuccess) {
                          context.read<AdminFunCubit>().getAllAdmins();
                          SnackbarWidget.show(
                            context,
                            state.message,
                          );
                        } else if (state is DeleteAdminFailure) {
                          SnackbarWidget.show(
                            context,
                            state.errorModel.message ?? '',
                          );
                        }
                      },
                      builder: (context, state) {
                        var cubit = context.read<AdminFunCubit>();
                        GetAllAdminsDataModel? list = cubit.admins;
                        return list == null
                            ? const Center(child: CircularProgressIndicator())
                            : ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: constraints.maxWidth,
                                ),
                                child: buildRecentEmployees(context, list),
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
      BuildContext context, GetAllAdminsDataModel list) {
    return DataTable(
        columns: const [
          DataColumn(
            label: Text(
              "الاسم",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              "البريد الإلكتروني",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              "رقم الهاتف",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text("الإجراء"), // Empty label for actions column
          ),
        ],
        rows: list.allAdmins
                ?.map(
                  (admin) => DataRow(cells: [
                    DataCell(Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/menu_profile.svg',
                          height: 20,
                          width: 20,
                          colorFilter: const ColorFilter.mode(
                              Colors.white54, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 8),
                        Flexible(child: Text(admin.userName ?? "")),
                      ],
                    )),
                    DataCell(Text(admin.email ?? "")),
                    DataCell(Text(admin.phone ?? "")),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Responsive.isMobile(context)
                                ? const Icon(Iconsax.edit)
                                : const Row(
                                    children: [
                                      Icon(Iconsax.edit),
                                      SizedBox(width: 5),
                                      Text('تعديل'),
                                    ],
                                  ),
                            color: Colors.lightBlue,
                            onPressed: () {
                              Navigator.pushNamed(context, RoutesName.addNewAdmin,arguments: admin);

                              // Handle admin edit action (navigation or functionality)
                            },
                          ),
                          BlocBuilder<AdminFunCubit, AdminFunState>(

                            builder: (context, state) {
                              var cubit = context.read<AdminFunCubit>();
                              return IconButton(
                                icon: Responsive.isMobile(context)
                                    ? const Icon(Iconsax.profile_delete)
                                    : const Row(
                                        children: [
                                          Icon(Iconsax.profile_delete),
                                          SizedBox(width: 5),
                                          Text('حذف'),
                                        ],
                                      ),
                                color: Colors.red,
                                onPressed: () {
                                  cubit.deleteAdmin(id: admin.sId ?? '');
                                  // Handle admin delete action (confirmation dialog etc.)
                                },
                              );
                            },
                          ),
                        ],
                      ),

                      // admin.widgetEditable(context)
                    ),
                  ]),
                )
                .toList() ??
            []
        // list.allAdmins?..map((admin) => DataRow(cells: [
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
        //               Flexible(child: Text(admin.username ?? "")),
        //             ],
        //           )),
        //           DataCell(Text(admin.emailAddress ?? "")),
        //           DataCell(Text(admin.phoneNumber ?? "")),
        //           DataCell(admin.widgetEditable(context)),
        //         ]))
        //     .toList(),
        );
  }
}
