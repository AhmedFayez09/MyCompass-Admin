import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/core/responsive.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';

class RecentFamily {
  final String? icon, nameOfRelation, numberOfApartment, username, emailAddress, phoneNumber, address, theirSpecialDay;
  final Widget Function(BuildContext) widgetEditable;

  RecentFamily({
    this.icon,
    this.numberOfApartment,
    this.username,
    this.emailAddress,
    this.phoneNumber,
    this.address,
    this.nameOfRelation,
    this.theirSpecialDay,
    required this.widgetEditable,
  });
}

/// Fill the list with all customer data

List demoRecentCustomers = [
  RecentFamily(
    icon: "assets/icons/menu_profile.svg",
    numberOfApartment: '4',
    username: "محمد عبدالرحيم",
    emailAddress: "moihamedi@gmail.com",
    phoneNumber: "0123456789",
    address: "القاهرة",
    nameOfRelation: "الأب",
    theirSpecialDay: "Monday",
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
            Navigator.pushNamed(context, RoutesName.editFamilyScreen);
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
            print('Delete');
          },
        ),
      ],
    ),
  ),
  RecentFamily(
    icon: "assets/icons/menu_profile.svg",
    numberOfApartment: '2',
    username: "محمود جمعة",
    emailAddress: "mahmoudi@gmail.com",
    phoneNumber: "0123456789",
    address: "بورسعيد",
    nameOfRelation: "الأخت الثانية",
    theirSpecialDay: "Monday",
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
            Navigator.pushNamed(context, RoutesName.editFamilyScreen);
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
            print('Delete');
          },
        ),
      ],
    ),
  ),
  RecentFamily(
    icon: "assets/icons/menu_profile.svg",
    numberOfApartment: '3',
    username: "سعاد عمار",
    emailAddress: "sooadi@gmail.com",
    phoneNumber: "0123456789",
    address: "القاهرة",
    nameOfRelation: "الأخت الأولي",
    theirSpecialDay: "Monday",
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
            Navigator.pushNamed(context, RoutesName.editFamilyScreen);
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
            print('Delete');
          },
        ),
      ],
    ),
  ),
  RecentFamily(
    icon: "assets/icons/menu_profile.svg",
    numberOfApartment: '1',
    username: "أنس معاذ",
    emailAddress: "anasi@gmail.com",
    phoneNumber: "0123456789",
    address: "القاهرة",
    nameOfRelation: "الأخ الثاني",
    theirSpecialDay: "Monday",
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
            Navigator.pushNamed(context, RoutesName.editFamilyScreen);
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
            print('Delete');
          },
        ),
      ],
    ),
  ),
  RecentFamily(
    icon: "assets/icons/menu_profile.svg",
    numberOfApartment: '5',
    username: "وحيد سلامه",
    emailAddress: "wahid@gmail.com",
    phoneNumber: "0123456789",
    address: "أسيوط",
    nameOfRelation: "الأخ الثالث",
    theirSpecialDay: "Monday",
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
            Navigator.pushNamed(context, RoutesName.editFamilyScreen);
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
            print('Delete');
          },
        ),
      ],
    ),
  ),
  RecentFamily(
    icon: "assets/icons/menu_profile.svg",
    numberOfApartment: '6',
    username: "عبدالرحمن أحمد عبده",
    emailAddress: "abdelrahman@gmail.com",
    phoneNumber: "0123456789",
    address: "المنوفية",
    nameOfRelation: "الأخ الأول",
    theirSpecialDay: "Monday",
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
            Navigator.pushNamed(context, RoutesName.editFamilyScreen);
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
            print('Delete');
          },
        ),
      ],
    ),
  ),
  RecentFamily(
    icon: "assets/icons/menu_profile.svg",
    numberOfApartment: '7',
    username: "سارة محمود",
    emailAddress: "sara@gmail.com",
    phoneNumber: "0123456789",
    address: "الجيزة",
    nameOfRelation: "الأم",
    theirSpecialDay: "Monday",
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
            Navigator.pushNamed(context, RoutesName.editFamilyScreen);
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
            print('Delete');
          },
        ),
      ],
    ),
  ),
];
Widget buildRecentCustomers(BuildContext context) {
  return ListView.builder(
    itemCount: demoRecentCustomers.length,
    itemBuilder: (context, index) {
      final customer = demoRecentCustomers[index];
      return Card(
        child: ListTile(
          leading: customer.icon != null
              ? Image.asset(customer.icon!)
              : const Icon(Icons.person),
          title: Text(customer.username ?? ""),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email: ${customer.emailAddress ?? ''}"),
              Text("Phone: ${customer.phoneNumber ?? ''}"),
              Text("Date: ${customer.date ?? ''}"),
              Text("Address: ${customer.address ?? ''}"),
            ],
          ),
          trailing: IconButton(
            icon: Responsive.isMobile(context)
          ? const Icon(Iconsax.edit, color: Colors.blue)
          : const Row(
              children: [
                Icon(Iconsax.edit),
                SizedBox(width: 5),
                Text('تعديل'),
              ],
            ),
            color: Colors.blue,
            onPressed: () {

            },
          ),
        ),
      );
    },
  );
}