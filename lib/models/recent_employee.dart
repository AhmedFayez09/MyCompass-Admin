import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mycompass_admin_website/core/responsive.dart';

class RecentEmployee {
  final String? icon, name, emailAddress, phoneNumber, department, jobTitle;
  final Widget Function(BuildContext) widgetEditable;

  RecentEmployee({
    this.icon,
    this.name,
    this.emailAddress,
    this.phoneNumber,
    this.department,
    this.jobTitle,
    required this.widgetEditable,
  });
}

/// Fill the list with all employee data (replace with your actual data fetching)
List<RecentEmployee> demoRecentEmployees = [
  RecentEmployee(
    icon: "assets/icons/menu_profile.svg",
    name: "محمد عمر",
    emailAddress: "moihamedi@gmail.com",
    phoneNumber: "0123456789",
    department: "الموارد البشرية",
    jobTitle: "مدير الموارد البشرية",
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
            // Handle employee edit action (navigation or functionality)
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
            // Handle employee delete action (confirmation dialog etc.)
          },
        ),
      ],
    ),
  ),
  // Add more RecentEmployee objects with employee data
  RecentEmployee(
    icon: "assets/icons/menu_profile.svg",
    name: "محمود عبدالرحيم",
    emailAddress: "moihamedi@gmail.com",
    phoneNumber: "0123456789",
    department: "الموارد البشرية",
    jobTitle: "مدير الموارد البشرية",
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
            // Handle employee edit action (navigation or functionality)
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
            // Handle employee delete action (confirmation dialog etc.)
          },
        ),
      ],
    ),
  ),
  RecentEmployee(
    icon: "assets/icons/menu_profile.svg",
    name: "عمر عبدالرحيم",
    emailAddress: "moihamedi@gmail.com",
    phoneNumber: "0123456789",
    department: "الموارد البشرية",
    jobTitle: "مدير الموارد البشرية",
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
            // Handle employee edit action (navigation or functionality)
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
            // Handle employee delete action (confirmation dialog etc.)
          },
        ),
      ],
    ),
  ),
  RecentEmployee(
    icon: "assets/icons/menu_profile.svg",
    name: "مني عبدالرحيم",
    emailAddress: "moihamedi@gmail.com",
    phoneNumber: "0123456789",
    department: "الموارد البشرية",
    jobTitle: "مدير الموارد البشرية",
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
            // Handle employee edit action (navigation or functionality)
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
            // Handle employee delete action (confirmation dialog etc.)
          },
        ),
      ],
    ),
  ),
];

