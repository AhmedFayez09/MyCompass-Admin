import 'package:flutter/material.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _contractorOfficerScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _adminScaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get contractorOfficerScaffoldKey => _contractorOfficerScaffoldKey;
  GlobalKey<ScaffoldState> get adminScaffoldKey => _adminScaffoldKey;

  void contractorOfficerControlMenu() {
    if (!_contractorOfficerScaffoldKey.currentState!.isDrawerOpen) {
      _contractorOfficerScaffoldKey.currentState!.openDrawer();
    }
  }

  void adminControlMenu() {
    if (!_adminScaffoldKey.currentState!.isDrawerOpen) {
      _adminScaffoldKey.currentState!.openDrawer();
    }
  }
}
