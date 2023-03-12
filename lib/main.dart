import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:g_user/Config/config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'Pages/Authentication/signIn_page.dart';
import 'Pages/Home/home_page.dart';
import 'Routes/onGenerateRoute.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GUserApp.initMain();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GuserApp',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // locale: const Locale('fr', 'CA'),
      home: GUserApp.constSharedPreferences!.getString(GUserApp.userToken) != null
              ? const HomePage()
              : const SignInPage(),
      onGenerateRoute: GUserRoute.onGenerateRoute,
    );
  }
}
