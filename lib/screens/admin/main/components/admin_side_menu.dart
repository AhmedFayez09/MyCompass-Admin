import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/widgets/admin_side_menu.dart';

class AdminSideMenu extends StatelessWidget {
  AdminSideMenu({super.key, required this.selectedIndex, required this.onIndexChanged});

  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  final List<Map<String, dynamic>> menuItems = [
    {"title": "الرئيسية", "svgSrc": "assets/icons/menu_dashboard.svg", "route": RoutesName.adminMain},
    {"title": "قائمة الموظفين", "svgSrc": "assets/icons/menu_profile.svg", "route": RoutesName.showAllStaff},
    {"title": "قائمة الأصلاح", "svgSrc": "assets/icons/maintenance.png", "route": RoutesName.adminShowAllMaintanance},
    {"title": "قائمة الصور", "svgSrc": "assets/icons/gallery_icon.svg", "route": RoutesName.adminShowAllGallery},
    {"title": "قائمة التواصل الأجتماعي", "svgSrc": "assets/icons/post_icon.svg", "route": RoutesName.adminShowAllGallery},
    {"title": "قائمة عرض كل الادمنز", "svgSrc": "assets/icons/menu_profile.svg", "route": RoutesName.adminShowAllGallery},
    {"title": "الملف الشخصي", "svgSrc": "assets/icons/menu_profile.svg", "route": RoutesName.adminProfile},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          ...List.generate(menuItems.length, (index) {
            return DrawerListTile(
              title: menuItems[index]["title"],
              svgSrc: menuItems[index]["svgSrc"],
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
