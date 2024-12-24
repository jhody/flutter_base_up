
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yleon/logic/locale_logic.dart';
import 'package:yleon/common_libs.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }
  //Para q se refreje en las URL
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Start app
  registerSingletons();

  runApp(MyApp());
  await appLogic.bootstrap();

  if (!kIsWeb) {
    FlutterNativeSplash.remove();
  }
}

class MyApp extends StatelessWidget with GetItMixin{
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = watchX((SettingsLogic s) => s.currentLocale);
    return MaterialApp.router(
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      title: 'Flutter Demo',
      locale: locale == null ? null : Locale(locale),//locale: Locale('es'), // Establecer español como idioma predeterminado
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.routerDelegate,
      localizationsDelegates: [
        AppLocalizations.delegate,    // El delegado de las traducciones generadas
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(fontFamily: $styles.text.body.fontFamily, useMaterial3: true),
      color: $styles.colors.black,
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
/// Crear singletons (logica y servicios) that can be shared across the app.
void registerSingletons(){
  // Top level app controller
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
  // Settings
  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
  // Localizations
  GetIt.I.registerLazySingleton<LocaleLogic>(() => LocaleLogic());
}


AppLogic get appLogic => GetIt.I.get<AppLogic>();
LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();
SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();


/// Global helpers for readability
AppLocalizations get $strings => localeLogic.strings;
AppStyle get $styles => WondersAppScaffold.style;


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.appBarTitleWelcome),  // Usando la localización
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
