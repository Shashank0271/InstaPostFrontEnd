import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'dawerwidget_model.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DrawerWidgetModel>.reactive(
      builder: (context, model, child) => Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(model.accountName),
                accountEmail: Text(model.accountEmail)),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: model.navigateToHomePage,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              onTap: model.navigateToProfilePage,
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: model.logout,
            ),
          ],
        ),
      ),
      viewModelBuilder: () => DrawerWidgetModel(),
    );
  }
}
