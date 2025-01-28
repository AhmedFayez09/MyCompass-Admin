import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/widgets/admin_side_menu.dart';

class AdminSideMenu extends StatelessWidget {
  const AdminSideMenu({super.key, required this.selectedIndex, required this.onIndexChanged});

  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

    List<Map<String, dynamic>> menuItems (BuildContext context)=> [
    {"title": "Home".tr(context), "svgSrc": "assets/icons/menu_dashboard.svg", "route": RoutesName.adminMain},
    {"title": "StaffList".tr(context), "svgSrc": "assets/icons/menu_profile.svg", "route": RoutesName.showAllStaff},
    {"title": "ListOfReforms".tr(context), "svgSrc": "assets/icons/maintenance.png", "route": RoutesName.adminShowAllMaintanance},
    {"title": "ListOfImages".tr(context), "svgSrc": "assets/icons/gallery_icon.svg", "route": RoutesName.adminShowAllGallery},
    {"title": "SocialMediaList".tr(context), "svgSrc": "assets/icons/post_icon.svg", "route": RoutesName.adminShowAllGallery},
    {"title": "ListShowalladmins".tr(context), "svgSrc": "assets/icons/menu_profile.svg", "route": RoutesName.adminShowAllGallery},
    {"title": "Profile".tr(context), "svgSrc": "assets/icons/menu_profile.svg", "route": RoutesName.adminProfile},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          ...List.generate(menuItems(context).length, (index) {
            return DrawerListTile(
              title: menuItems(context)[index]["title"],
              svgSrc: menuItems(context)[index]["svgSrc"],
              isNotSvg: index == 2 ? true : false,
              isSelected: selectedIndex == index,
              press: () => onIndexChanged(index),
            );
          }),
        ],
      ),
    );
  }
}
