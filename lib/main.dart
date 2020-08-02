import 'package:flutter/material.dart';
import 'package:signzy/app.dart';
import 'package:signzy/helper/provider_setup.dart';
import 'package:provider/provider.dart';

void main() => runApp(new SmsApp());

class SmsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
      title: "Signzy",
      theme: new ThemeData(
        primaryColor: Color(0xff303146),
        accentColor: Color(0xff58ADE2),
      ),
      debugShowCheckedModeBanner: false,
      home: new Application(),
        ),
    );
  }
}
