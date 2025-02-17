import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/responsive.dart';
import 'package:mycompass_admin_website/screens/admin/auth/component/admin_desktop_login_form.dart';
import 'package:mycompass_admin_website/screens/admin/auth/component/admin_mobile_login_form.dart';
import 'package:mycompass_admin_website/screens/admin/auth/component/admin_tablet_login_form.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Responsive(
          mobile: AdminMobileLoginForm(
            emailController: emailController,
            passwordController: passwordController,
          ),
          tablet: AdminTabletLoginForm(
            emailController: emailController,
            passwordController: passwordController,
          ),
          desktop: AdminDesktopLoginForm(
            emailController: emailController,
            passwordController: passwordController,
          ),
        ),
      ),
    );
  }
}
