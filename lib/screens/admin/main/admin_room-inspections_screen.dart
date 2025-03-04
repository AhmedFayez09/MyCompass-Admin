import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/admin_recent_files.dart';

class AdminRoomInspectionsScreen extends StatelessWidget {
  const AdminRoomInspectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController horizontalScrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text('RoomMonitors'.tr(context),
            style: Theme.of(context).textTheme.bodyLarge!),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Back to previous screen
          },
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SizedBox(height: defaultPadding),
                        AllFamiliesTable(
                          isHome: false,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
