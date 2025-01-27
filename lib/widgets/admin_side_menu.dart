import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';

class AdminSideMenu extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  AdminSideMenu({
    super.key,
    required this.onIndexChanged,
    required this.selectedIndex,
  });

  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "إنشاء مستخدم",
      "svgSrc": "assets/icons/menu_dashboard.svg",
      "route": RoutesName.main
    },
    {
      "title": "إنشاء روابط",
      "svgSrc": "assets/icons/menu_tran.svg",
      "route": RoutesName.createLinks
    },
    {
      "title": "دفع",
      "svgSrc": "assets/icons/menu_task.svg",
      "route": RoutesName.paid
    },
    {
      "title": "تقارير الدفع",
      "svgSrc": "assets/icons/menu_doc.svg",
      "route": RoutesName.paymentReports
    },
    {
      "title": "الملف الشخصي",
      "svgSrc": "assets/icons/menu_profile.svg",
      "route": RoutesName.profile
    },
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
              isSelected: selectedIndex == index,
              press: () => onIndexChanged(index),
            );
          }),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
    this.isNotSvg = false,
    required this.isSelected,
  });

  final String title, svgSrc;
  final VoidCallback press;
  final bool isSelected;
  final bool? isNotSvg;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: isNotSvg == true
            ? kIsWeb
                ? Image.network(
                    svgSrc,
                    color: isSelected ? Colors.blueAccent : Colors.white54,
                    height: 16,
                  )
                : Image.asset(
                    svgSrc,
                    color: isSelected ? Colors.blueAccent : Colors.white54,
                    height: 16,
                  )
            : SvgPicture.asset(
                svgSrc,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.blueAccent : Colors.white54,
                  BlendMode.srcIn,
                ),
                height: 16,
              ),
        title: Text(
          title,
          style: GoogleFonts.cairo(
            color: isSelected ? Colors.blue : Colors.white54,
          ),
        ),
      ),
    );
  }
}
