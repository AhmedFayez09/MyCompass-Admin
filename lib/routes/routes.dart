// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:smart_pay_website/routes/routes_name.dart';
// import 'package:smart_pay_website/screens/dashboard/create_new_customer_screen.dart';
// import 'package:smart_pay_website/screens/dashboard/admin_dashboard_screen.dart';
// import 'package:smart_pay_website/screens/main/contractor_officer_main_screen.dart';
//
// // class RouteGenerator {
// //   static Route<dynamic> getRoute(RouteSettings settings) {
// //     switch (settings.name) {
// //       case RoutesName.createCustomer:
// //         return PageTransition(
// //           child: DashboardScreen(),
// //           type: PageTransitionType.rightToLeft,
// //           settings: settings,
// //           duration: const Duration(milliseconds: 500),
// //           reverseDuration: const Duration(milliseconds: 500),
// //         );
// //       default:
// //         return MaterialPageRoute(
// //           builder: (_) => const Scaffold(
// //             body: Center(
// //               child: Text('No route found'),
// //             ),
// //           ),
// //         );
// //     }
// //   }
// // }
//
//
// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case RoutesName.main:
//         return MaterialPageRoute(builder: (_) => MainScreen());
//       case RoutesName.createLinks:
//         return MaterialPageRoute(builder: (_) => Scaffold());
//       case RoutesName.profile:
//         return MaterialPageRoute(builder: (_) => Scaffold());
//       case RoutesName.createNewCustomer:
//         return MaterialPageRoute(builder: (_) => CreateNewCustomerScreen());
//       default:
//         return MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(child: Text("Page Not Found")),
//           ),
//         );
//     }
//   }
// }
