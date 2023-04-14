import '/../app/providers/cache_provider.dart';
import '/providers/notification_provider.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '/providers/app_provider.dart';
import '/providers/event_provider.dart';
import '/providers/route_provider.dart';

/*
|--------------------------------------------------------------------------
| Providers
| Add your "app/providers" here.
| Providers are booted when your application start.
|
| Learn more: https://nylo.dev/docs/4.x/providers
|--------------------------------------------------------------------------
*/

final Map<Type, NyProvider> providers = {
  NotificationProvider: NotificationProvider(),
  AppProvider: AppProvider(),
  RouteProvider: RouteProvider(),
  EventProvider: EventProvider(),

  CacheProvider: CacheProvider(),
};
  
  
