import 'package:flutter/material.dart';
import 'package:signzy/view/dashboard/dashboardView.dart';
import 'package:signzy/core/queryPermissions.dart';

class Application extends StatefulWidget {
  @override
  ApplicationState createState() => new ApplicationState();
}

class ApplicationState extends State<Application> {
  bool permissionsGranted = false;

  @override
  void initState() {
    super.initState();

    queryPermissions().then((bool val) {
      setState(() {
        permissionsGranted = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Container(
          width: MediaQuery.of(context).size.width*0.25,
            child: Image.asset("assets/images/logo_blue.jpg",height: 56,)),
        elevation: 0.7,
      ),
      body: permissionsGranted
          ? new DashboardPage()
          : new Center(
              child: new CircularProgressIndicator(),
            ),
    );
  }
}
