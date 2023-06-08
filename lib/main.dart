import 'package:farma_compara_flutter/application/cart/cart_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'core/constants/app_constants.dart';
import 'core/router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(cartNotifierProvider, (previous, next) {

      if(previous == null) return;
      if(next.items.length > previous.items.length){
        final snackBar = SnackBar(
          content: const Text('Agregado al carrito'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () {
              ref.read(cartNotifierProvider.notifier).removeItem(next.items.last);
            },
          ),
        );

        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    });


    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) => routerMap,
      ),
      routeInformationParser: const RoutemasterParser(),
      title: appName,
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,

        useMaterial3: true,
      ),
    );
  }
}
