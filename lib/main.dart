import 'package:ecommerce_api/frstPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        elevation: 3,
        scrolledUnderElevation: 10,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white.withOpacity(.80),
        titleTextStyle: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 20,
            fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(
          color: Colors.grey.shade800,
          size: 25,
        ),
      ),
    ),
    home: firstPage(),
  ));
}
