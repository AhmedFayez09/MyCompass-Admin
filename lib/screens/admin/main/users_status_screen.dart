import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/functions/chect_equal_list.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/models/users_status_model.dart';
import 'package:mycompass_admin_website/screens/admin/main/user_status/one_list.dart';
import 'package:mycompass_admin_website/screens/admin/main/user_status/three_list.dart';
import 'package:mycompass_admin_website/screens/admin/main/user_status/two_list.dart';
import 'package:mycompass_admin_website/screens/admin/main/user_status/users_not_responsed_screen.dart';

List<String> usersStatus = [
  'I am Safe, and at the Gathering Point',
  'I am outside the building (in the city)',
  'I need help'
];

class UsersStatusScreen extends StatelessWidget {
  const UsersStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = context.read<AdminCubit>();
        var list = cubit.usersStatusModel?.result;
        var oneList = cubit.usersStatusModel?.oneList;
        var twoList = cubit.usersStatusModel?.twoList;
        var threeList = cubit.usersStatusModel?.threeList;

        return list == null
            ? const Center(child: CircularProgressIndicator())
            : Directionality(
                textDirection: TextDirection.rtl,
                child: SafeArea(
                  child: Scaffold(
                    body: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  BackButton(),
                                  Text(
                                    "UserList".tr(context),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    "${"theirnumber".tr(context)} (${list.length ?? 0}) ",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  )
                                ],
                              ),
                              TextButton(
                                  style: const ButtonStyle(
                                    padding:
                                        WidgetStatePropertyAll(EdgeInsets.zero),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<AdminCubit>()
                                        .getNotResponsed();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UsersNotResponsedScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Userswhodidnotrespond".tr(context),
                                    style: TextStyle(fontSize: 14),
                                  ))
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OneList(list: oneList),
                                      ));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${"IamSafe".tr(context)} (${oneList?.length ?? 0})',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Image.asset(
                                        "assets/images/1.jpg",
                                        width: 100,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TwoList(list: twoList),
                                      ));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${"Iamoutside".tr(context)} (${twoList?.length ?? 0})',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Image.asset(
                                        "assets/images/2.jpg",
                                        width: 100,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ThreeList(list: threeList),
                                      ));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${"Ineedhelp".tr(context)} (${threeList?.length ?? 0})',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Image.asset(
                                        "assets/images/3.jpg",
                                        width: 100,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              );
      },
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
