import 'package:flutter/material.dart';
import '../resources/themes/styles/color_styles.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:latlong2/latlong.dart';
// Add your helper methods here
// ...

/// helper to find correct color from the [context].
class ThemeColor {
  static ColorStyles get(BuildContext context, {String? themeId}) {
    Nylo nylo = Backpack.instance.read('nylo');
    List<BaseThemeConfig<ColorStyles>> appThemes =
        nylo.appThemes as List<BaseThemeConfig<ColorStyles>>;

    if (themeId == null) {
      BaseThemeConfig<ColorStyles> themeFound = appThemes.firstWhere(
          (theme) =>
              theme.id ==
              getEnv(Theme.of(context).brightness == Brightness.light
                  ? 'LIGHT_THEME_ID'
                  : 'DARK_THEME_ID'),
          orElse: () => appThemes.first);
      return themeFound.colors;
    }

    BaseThemeConfig<ColorStyles> baseThemeConfig = appThemes.firstWhere(
        (theme) => theme.id == themeId,
        orElse: () => appThemes.first);
    return baseThemeConfig.colors;
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

/// helper to set colors on TextStyle
extension ColorsHelper on TextStyle {
  TextStyle? setColor(
      BuildContext context, Color Function(ColorStyles color) newColor,
      {String? themeId}) {
    return copyWith(color: newColor(ThemeColor.get(context, themeId: themeId)));
  }
}

/// API helper
// api<T>(dynamic Function(T request) request,
//         {BuildContext? context,
//         Map<String, dynamic> headers = const {},
//         String? bearerToken,
//         String? baseUrl}) async =>
//     await nyApi<T>(
//         request: request,
//         apiDecoders: apiDecoders,
//         context: context,
//         headers: headers,
//         bearerToken: bearerToken,
//         baseUrl: baseUrl);

/// Event helper
//event<T>({Map? data}) async => nyEvent<T>(params: data, events: events);

/// Return an object from your modelDecoders using [data].
// T dataToModel<T>({required dynamic data}) {
//   assert(T != dynamic,
//       "You must provide a Type from your modelDecoders from within your config/decoders.dart file");
//   assert(modelDecoders.containsKey(T),
//       "Your modelDecoders variable inside config/decoders.dart must contain a decoder for Type: $T");
//   return modelDecoders[T](data);
// }

Future<LatLng?> showLocationPicker({
  required BuildContext context,
}) async {
  assert(context != null);
  LatLng? result;
  await routeTo("/map-picker", onPop: (value) {
    if (value != null) {
      result = value;
    }
  });

  return result;
}
