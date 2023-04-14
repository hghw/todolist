import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:todolist/screens/home.dart';
import 'package:todolist/screens/create.dart';
import 'bootstrap/boot.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //Nylo nylo = await Nylo.init(setup: Boot.nylo, setupFinished: Boot.finished);

  runApp(
    MaterialApp(home: HomePage(), color: Colors.white,)
    // AppBuild(
    //   navigatorKey: NyNavigator.instance.router.navigatorKey,
    //   onGenerateRoute: nylo.router!.generator(),
    //   debugShowCheckedModeBanner: false,
    //   initialRoute: nylo.initialRoute,
    //   themeMode: ThemeMode.light,
    // ),
  );
}
