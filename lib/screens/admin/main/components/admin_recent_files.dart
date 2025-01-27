import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mycompass_admin_website/core/functions/convert_data_to_day.dart';
import 'package:mycompass_admin_website/core/responsive.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/managers/family/family_cubit.dart';
import 'package:mycompass_admin_website/models/family_model.dart';
import 'package:mycompass_admin_website/models/recent_family.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_chart.dart';
import 'package:mycompass_admin_website/widgets/snackbar_widget.dart';

class AllFamiliesTable extends StatelessWidget {
  const AllFamiliesTable({
    super.key,
    required this.isHome,
  });

  final bool isHome;

  @override
  Widget build(BuildContext context) {
    final ScrollController horizontalScrollController = ScrollController();

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "جميع العائلات",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (isHome)
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    print('Create');

                    /// Todo: navigate to add new announcement screen
                    Navigator.pushNamed(
                        context, RoutesName.showAllRoomInspections);
                  },
                  icon: const Icon(Icons.add),
                  label: Text(
                    "فحص الغرف",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          LayoutBuilder(
            builder: (context, constraints) {
              return Scrollbar(
                controller: horizontalScrollController,
                // Attach the same controller
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: horizontalScrollController,
                  // Attach the same controller
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                    ),
                    child: BlocConsumer<FamilyCubit, FamilyState>(
                      listener: (context, state) {
                        if (state is DeleteFamilySuccess) {
                          context.read<FamilyCubit>().getAllFamilies();

                          SnackbarWidget.show(context, "تم الحذف بنجاح");
                        }
                      },
                      builder: (context, state) {
                        var cubit = context.read<FamilyCubit>();
                        var model = cubit.familyModel;
                        var list = model?.result;
                        return list == null || list.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : DataTable(
                                columnSpacing: defaultPadding,
                                columns: [
                                  DataColumn(
                                    label: Text("أسم المستخدم",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                  DataColumn(
                                    label: Text("اليوم الخاص بهم",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                  DataColumn(
                                    label: Text("رقم الشقة",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                  DataColumn(
                                    label: Text("البريد الإلكتروني",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                  DataColumn(
                                    label: Text("رقم الهاتف",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ), DataColumn(
                                    label: Text("يوم الاصلاحات",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "المسمي الخاص به من ضمن عائلته",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text("الإجراء",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                ],
                                rows: List.generate(list.length, (index) {
                                  OneFamily item = list[index];
                                  return recentCustomerDataRow(
                                    context: context,
                                    item: item,
                                    onDeleted: () {
                                      cubit.deleteFamily(id: item.sId ?? '');
                                    },
                                  );
                                }),
                                // rows: List.generate(
                                //   demoRecentCustomers.length,
                                //       (index) =>
                                //       recentCustomerDataRow(demoRecentCustomers[index], context),
                                // ),
                              );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

DataRow recentCustomerDataRow({
  required BuildContext context,
  required OneFamily item,
  VoidCallback? onDeleted,
}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/menu_profile.svg",
              height: 20,
              width: 20,
              colorFilter:
                  const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                item.userName ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(convertDataToDay(dateString: item.maintenanceDay ?? ''))),
      DataCell(Text(item.noOfAppartment.toString())),
      DataCell(Text(item.email ?? '')),
      DataCell(Text(item.phone ?? '')),
      DataCell(Text(item.maintenanceDay ?? '')),
      DataCell(Center(child: Text(item.memberType ?? ''))),
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
                Navigator.pushNamed(
                  context,
                  RoutesName.editFamilyScreen,
                  arguments: item,
                );
              },
            ),
            IconButton(
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
              onPressed: onDeleted,
            ),
          ],
        ),
      ), // Pass context here
    ],
  );
}
