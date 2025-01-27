import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/functions/chect_equal_list.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/models/users_status_model.dart';

class UsersStatusScreen extends StatelessWidget {
  const UsersStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "قائمة المستخدمين",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: BlocConsumer<AdminCubit, AdminState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = context.read<AdminCubit>();
            var list = cubit.usersStatusModel?.result;
            return list == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: defaultPadding),
                        const Divider(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              DataTable(
                                columnSpacing: defaultPadding,
                                columns: [
                                  DataColumn(
                                    label: Text("أسم المستخدم",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                  DataColumn(
                                    label: Text("نوع المستخدم",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                  DataColumn(
                                    label: Text("التاريخ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                  DataColumn(
                                    label: Text("الحالة",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                ],
                                rows: List.generate(list.length, (index) {
                                  UsersStatusModelData item = list[index];
                                  return recentCustomerDataRow(
                                      context: context, item: item);
                                }),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

DataRow recentCustomerDataRow({
  required BuildContext context,
  required UsersStatusModelData item,
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
      DataCell(Text(item.userType ?? '')),
      DataCell(Text(extractDate(item.createdAt ?? ''))),
      DataCell(
        Text(
          item.status ?? "",
          style: TextStyle(
              color: item.status == "I am Safe, and at the Gathering Point"
                  ? Colors.green
                  : item.status == "I am outside the building (in the city)"
                      ? Colors.yellowAccent
                      : Colors.red),
        ),
      ),
    ],
  );
}
