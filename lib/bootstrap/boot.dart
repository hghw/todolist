import 'package:nylo_framework/nylo_framework.dart';

import '../config/providers.dart';

/// Boot methods for Nylo.
class Boot {
  static Future<Nylo> nylo() async => await bootApplication(providers);
  static Future<void> finished(Nylo nylo) async => await bootFinished(nylo);
}