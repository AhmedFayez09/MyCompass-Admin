import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/functions/chect_equal_list.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/models/users_status_model.dart';
import 'package:mycompass_admin_website/screens/admin/main/user_status/non_reponsed_model.dart';

class UsersNotResponsedScreen extends StatelessWidget {
  const UsersNotResponsedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        NonResponsedModel? list = context.read<AdminCubit>().nonResponsedModel;
        return list == null
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: AppBar(backgroundColor: Colors.transparent),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("المستخدمين غير مستجابين"),
                            const SizedBox(height: defaultPadding),
                            const Divider(),
                            Row(
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
                                  ],
                                  rows: List.generate(
                                      list.nonRespondedUsers?.length ?? 0,
                                      (index) {
                                    NonRespondedUsers? item =
                                        list.nonRespondedUsers?[index];
                                    return recentCustomerDataRow(
                                      context: context,
                                      item: item,
                                    );
                                  }),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 50)),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("الموظفين غير مستجابين"),
                            const SizedBox(height: defaultPadding),
                            const Divider(),
                            Row(
                              children: [
                                DataTable(
                                  columnSpacing: defaultPadding,
                                  columns: [
                                    DataColumn(
                                      label: Text("أسم الموظف",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                  ],
                                  rows: List.generate(
                                    list.nonRespondedEmployees?.length ?? 0,
                                    (index) {
                                      NonRespondedUsers? item =
                                          list.nonRespondedEmployees?[index];
                                      return recentCustomerDataRow(
                                        context: context,
                                        item: item,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
      },
    );
  }
}

DataRow recentCustomerDataRow({
  required BuildContext context,
  required NonRespondedUsers? item,
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
                item?.userName ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
