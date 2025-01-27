import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mycompass_admin_website/core/responsive.dart';

class RecentAdmin {
  final String? username, emailAddress, phoneNumber;
  final Widget Function(BuildContext) widgetEditable;

  RecentAdmin({
    this.username,
    this.emailAddress,
    this.phoneNumber,
    required this.widgetEditable,
  });
}

/// Fill the list with all admin data (replace with your actual data fetching)
List<RecentAdmin> demoRecentAdmins = [
  RecentAdmin(
    username: "admin001",
    emailAddress: "admin1@example.com",
    phoneNumber: "0123456789",
    widgetEditable: (context) => Row(
      children: [
        IconButton(
          icon: Responsive.isMobile(context)
              ? const Icon(Iconsax.edit)
              : const Row(
            children: [
              Icon(Iconsax.edit),
              SizedBox(width: 5),
              Text('تعديل'),
            ],
          ),
          color: Colors.lightBlue,
          onPressed: () {
            // Handle admin edit action (navigation or functionality)
          },
        ),
        IconButton(
          icon: Responsive.isMobile(context)
              ? const Icon(Iconsax.profile_delete)
              : const Row(
            children: [
              Icon(Iconsax.profile_delete),
              SizedBox(width: 5),
              Text('حذف'),
            ],
          ),
          color: Colors.red,
          onPressed: () {
            // Handle admin delete action (confirmation dialog etc.)
          },
        ),
      ],
    ),
  ),
  // Add more RecentAdmin objects with admin data
  RecentAdmin(
    username: "admin002",
    emailAddress: "admin2@example.com",
    phoneNumber: "0123456789",
    widgetEditable: (context) => Row(
      children: [
        IconButton(
          icon: Responsive.isMobile(context)
              ? const Icon(Iconsax.edit)
              : const Row(
            children: [
              Icon(Iconsax.edit),
              SizedBox(width: 5),
              Text('تعديل'),
            ],
          ),
          color: Colors.lightBlue,
          onPressed: () {
            // Handle admin edit action (navigation or functionality)
          },
        ),
        IconButton(
          icon: Responsive.isMobile(context)
              ? const Icon(Iconsax.profile_delete)
              : const Row(
            children: [
              Icon(Iconsax.profile_delete),
              SizedBox(width: 5),
              Text('حذف'),
            ],
          ),
          color: Colors.red,
          onPressed: () {
            // Handle admin delete action (confirmation dialog etc.)
          },
        ),
      ],
    ),
  ),
  // You can add more admins with similar structure
];
