import 'package:nylo_framework/nylo_framework.dart';
import 'package:todolist/screens/contact.dart';
import 'package:todolist/screens/create.dart';
import 'package:todolist/screens/home.dart';
import 'package:todolist/screens/notification.dart';

appRouter() => nyRoutes((router) => {
      router.route("/home", (context) => HomePage(), transition: PageTransitionType.leftToRight),
      router.route("/create", (context) => Create(), transition: PageTransitionType.leftToRight),
      router.route("/notification", (context) => NotificationPage(), transition: PageTransitionType.leftToRight),
      router.route("/contact", (context) => ContactPage(), transition: PageTransitionType.leftToRight),
    });
