import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:yleon/common_libs.dart';
import 'package:yleon/ui/screens/page_not_found/page_not_found.dart';
import 'package:yleon/ui/screens/intro/intro_screen.dart';

/// Shared paths / urls used across the app
class ScreenPaths {
  static String splash = '/';
  static String intro = '/welcome';
  static String home = '/home';
  static String settings = '/settings';

}
final appRouter = GoRouter(
  redirect: _handleRedirect,
  errorPageBuilder: (context, state) => MaterialPage(child: PageNotFound(state.uri.toString())),
  routes:[
    ShellRoute(
        builder: (context, router, navigator) {
          return WondersAppScaffold(child: navigator);
        },
        routes:[
          AppRoute(ScreenPaths.splash, (_) => Container(color: $styles.colors.greyStrong)),
          AppRoute(ScreenPaths.intro, (_) => IntroScreen()),
          AppRoute(ScreenPaths.home, (_) => IntroScreen()),
        ]
    ),]
);


/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}

String? get initialDeeplink => _initialDeeplink;
String? _initialDeeplink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && state.uri.path != ScreenPaths.splash) {
    debugPrint('Redirecting from ${state.uri.path} to ${ScreenPaths.splash}.');
    _initialDeeplink ??= state.uri.toString();
    return ScreenPaths.splash;
  }
  if (appLogic.isBootstrapComplete && state.uri.path == ScreenPaths.splash) {
    debugPrint('Redirecting from ${state.uri.path} to ${ScreenPaths.home}');
    return ScreenPaths.home;
  }
  if (!kIsWeb) debugPrint('Navigate to: ${state.uri}');
  return null; // do nothing
}