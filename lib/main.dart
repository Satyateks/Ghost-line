

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/initial_binding.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/no_internet_banner.dart';
import 'features/auth/ui/login.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const GhostLineApp());
}


class GhostLineApp extends StatelessWidget {
  const GhostLineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GhostLine',
      debugShowCheckedModeBanner: false, 
      initialBinding: InitialBinding(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // theme: ThemeData(//colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      //   fontFamily: 'Inter', useMaterial3: true,
      //   scaffoldBackgroundColor: const Color(0xFF111111),
      //   useMaterial3: true),
      home:AuthScreen(),
      builder: (context, child) {
        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            const Positioned( top: 51, left: 0, right: 0, child: NoInternetBanner()),
          ],
        );
      },
    );
  }
} 
 

