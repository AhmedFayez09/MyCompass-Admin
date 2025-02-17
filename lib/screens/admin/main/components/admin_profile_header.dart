import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_dashboard_header.dart';
import 'package:provider/provider.dart';
import 'package:mycompass_admin_website/controllers/menu_app_controller.dart';
import 'package:mycompass_admin_website/core/responsive.dart';

class AdminProfileHeader extends StatelessWidget {
  const AdminProfileHeader({
    super.key,
    this.isNotProfile = false,
    this.title
  });

  final bool? isNotProfile;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed:
                context.read<MenuAppController>().contractorOfficerControlMenu,
          ),
        Text(
          isNotProfile == true ? title! : "Profile".tr(context),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Spacer(),
        // const ProfileCard()
      ],
    );
  }
}
