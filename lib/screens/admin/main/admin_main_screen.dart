import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/core/responsive.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/managers/admin_cubit_fun/admin_fun_cubit.dart';
import 'package:mycompass_admin_website/managers/gallery/gallery_cubit.dart';
import 'package:mycompass_admin_website/managers/maintenance/maintenance_cubit.dart';
import 'package:mycompass_admin_website/managers/post/post_cubit.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_profile_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_room-inspections_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_show_all_gallery_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_show_all_maintanance_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_side_menu.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_dashboard_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_social_media_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/show_all_admins_screen.dart';
import 'package:provider/provider.dart';
import 'package:mycompass_admin_website/controllers/menu_app_controller.dart';

import 'admin_show_all_in_staff_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    AdminDashboardScreen(),
    AdminShowAllInStaffScreen(),
    AdminShowAllMaintananceScreen(),
    AdminShowAllGalleryScreen(),
    AdminSocialMediaScreen(),
    ShowAllAdminsScreen(),
    AdminProfileScreen(),
  ];

  void updateIndex(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 5) {
        context.read<AdminFunCubit>().getAllAdmins();
      } else if (index == 6) {
        context.read<AdminCubit>().getProfile();
      } else if (index == 2) {
        context.read<MaintenanceCubit>().getAllMaintenances();
      } else if (index == 3) {
        context.read<GalleryCubit>().getAllGallery();
      } else if (index == 4) {
        context.read<PostCubit>().getAllPosts();
      }
      print(index);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().contractorOfficerScaffoldKey,
      drawer: AdminSideMenu(
        onIndexChanged: updateIndex,
        selectedIndex: selectedIndex,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: AdminSideMenu(
                    onIndexChanged: updateIndex,
                    selectedIndex: selectedIndex),
              ),
            Expanded(
              flex: 5,
              child: IndexedStack(
                index: selectedIndex,
                children: screens,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
