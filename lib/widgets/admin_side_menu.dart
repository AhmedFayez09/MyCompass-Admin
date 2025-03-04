import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';

class AdminSideMenu extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  const AdminSideMenu({
    super.key,
    required this.onIndexChanged,
    required this.selectedIndex,
  });

    List<Map<String, dynamic>> menuItems (BuildContext context)=> [
    {
      "title": "CreateUser".tr(context),
      "svgSrc": "assets/icons/menu_dashboard.svg",
      "route": RoutesName.main
    },
    {
      "title": "CreateLinks".tr(context),
      "svgSrc": "assets/icons/menu_tran.svg",
      "route": RoutesName.createLinks
    },
    {
      "title": "push".tr(context),
      "svgSrc": "assets/icons/menu_task.svg",
      "route": RoutesName.paid
    },
    {
      "title": "PaymentReports".tr(context),
      "svgSrc": "assets/icons/menu_doc.svg",
      "route": RoutesName.paymentReports
    },
    {
      "title": "Profile".tr(context),
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
          ...List.generate(menuItems(context).length, (index) {
            return DrawerListTile(
              title: menuItems(context)[index]["title"],
              svgSrc: menuItems(context)[index]["svgSrc"],
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
