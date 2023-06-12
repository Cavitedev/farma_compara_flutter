import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

import 'core/constants/app_constants.dart';
import 'core/router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  await initializeDateFormatting('es_ES', null);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Intl.defaultLocale = 'es_ES';

    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) => buildRoutes(context, ref),
      ),
      routeInformationParser: const RoutemasterParser(),
      title: appName,
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue).copyWith(secondary: Colors.deepOrangeAccent.shade400),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      locale: const Locale('es', "ES"),

      debugShowCheckedModeBanner: false,
    );
  }
}
