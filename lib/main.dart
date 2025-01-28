import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompass_admin_website/controllers/language_cubit.dart';
import 'package:mycompass_admin_website/core/bloc_observer.dart';
import 'package:mycompass_admin_website/core/dio/dio_helper.dart';
import 'package:mycompass_admin_website/core/local_storage/cach_keys.dart';
import 'package:mycompass_admin_website/core/local_storage/cache_helper.dart';
import 'package:mycompass_admin_website/core/locale/app_localizations_setup.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';
import 'package:mycompass_admin_website/managers/admin_cubit_fun/admin_fun_cubit.dart';
import 'package:mycompass_admin_website/managers/announcement/announcement_cubit.dart';
import 'package:mycompass_admin_website/managers/employees/employees_cubit.dart';
import 'package:mycompass_admin_website/managers/family/family_cubit.dart';
import 'package:mycompass_admin_website/managers/gallery/gallery_cubit.dart';
import 'package:mycompass_admin_website/managers/maintenance/maintenance_cubit.dart';
import 'package:mycompass_admin_website/managers/post/post_cubit.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_edit_image_to_gallery_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/edit_employee_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/user_status/one_list.dart';
import 'package:mycompass_admin_website/screens/admin/main/users_status_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycompass_admin_website/core/constants.dart';
import 'package:mycompass_admin_website/routes/routes_name.dart';
import 'package:mycompass_admin_website/controllers/menu_app_controller.dart';
import 'package:mycompass_admin_website/screens/admin/main/add_new_admin_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/add_new_announcement_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/add_new_employee_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/add_new_family.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_add_new_image_to_gallery_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_add_new_post_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_edit_family_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_profile_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_room-inspections_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_show_all_gallery_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_show_all_maintanance_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/show%20_all_announcements_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/components/show_all_admins_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_social_media_screen.dart';
import 'package:mycompass_admin_website/screens/admin/auth/admin_login_screen.dart';
import 'package:mycompass_admin_website/screens/admin/main/admin_main_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setPathUrlStrategy();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  runApp(ChangeNotifierProvider(
    create: (context) => MenuAppController(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminCubit()
            ..initializeSocket()
            ..getUsersStatus(),
        ),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => AdminFunCubit()),
        BlocProvider(create: (context) => EmployeesCubit()),
        BlocProvider(create: (context) => GalleryCubit()),
        BlocProvider(create: (context) => FamilyCubit()),
        BlocProvider(create: (context) => AnnouncementCubit()),
        BlocProvider(create: (context) => MaintenanceCubit()),
        BlocProvider(create: (context) => PostCubit()),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'My Compass Admin',
            locale: locale,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: bgColor,
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                      .apply(bodyColor: Colors.white),
              canvasColor: secondaryColor,
            ),
            initialRoute: CacheHelper.getString(
                          key: CacheKeys.token,
                        ) ==
                        null ||
                    CacheHelper.getString(
                          key: CacheKeys.token,
                        ) ==
                        ''
                ? RoutesName.adminLogin
                : RoutesName.adminMain,
            routes: {
              /// Admin Routes
              RoutesName.adminMain: (context) => const AdminMainScreen(),
              RoutesName.adminLogin: (context) => const AdminLoginScreen(),
              RoutesName.addNewFamily: (context) => const AddNewFamilyScreen(),
              RoutesName.adminCreateNewCustomer: (context) => const Scaffold(),
              RoutesName.adminEditCustomerScreen: (context) => const Scaffold(),
              RoutesName.adminProfile: (context) => const AdminProfileScreen(),
              RoutesName.addNewAnnouncement: (context) =>
                  const AddNewAnnouncementScreen(),
              RoutesName.showAllAnnouncements: (context) =>
                  const ShowAllAnnouncementsScreen(),
              RoutesName.addNewEmployee: (context) =>
                  const AddNewEmployeeScreen(),
              RoutesName.adminShowAllGallery: (context) =>
                  const AdminShowAllGalleryScreen(),
              RoutesName.addNewImageToGallery: (context) =>
                  const AddNewImageToGalleryScreen(),
              RoutesName.showAllAdmins: (context) =>
                  const ShowAllAdminsScreen(),
              RoutesName.addNewAdmin: (context) => const AddNewAdminScreen(),
              RoutesName.socialMediaForAdmin: (context) =>
                  const AdminSocialMediaScreen(),
              RoutesName.adminAddNewPost: (context) =>
                  const AdminAddNewPostScreen(),
              RoutesName.adminShowAllMaintanance: (context) =>
                  const AdminShowAllMaintananceScreen(),
              RoutesName.showAllRoomInspections: (context) =>
                  const AdminRoomInspectionsScreen(),
              RoutesName.editFamilyScreen: (context) =>
                  const AdminEditFamilyScreen(),
              RoutesName.adminEditImageToGalleryScreen: (context) =>
                  const EditImageToGalleryScreen(),
              RoutesName.editEmployeeScreen: (context) =>
                  const EditEmployeeScreen(),
              RoutesName.usersStatusScreen: (context) =>
                  const UsersStatusScreen(),
            },
          );
        },
      ),
    );
  }
}
