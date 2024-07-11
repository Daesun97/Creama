import 'package:creama/firebase_options.dart';
import 'package:creama/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(
    const ProviderScope(
      child: Creama(),
    ),
  );
}

class Creama extends ConsumerWidget {
  const Creama({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'Creama',
      themeMode: ThemeMode.system,
      theme: FlexThemeData.light(
        scheme: FlexScheme.espresso,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          sliderTrackHeight: 1,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          inputDecoratorUnfocusedBorderIsColored: false,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
          appBarBackgroundSchemeColor: SchemeColor.primary,
          bottomSheetRadius: 5.0,
          bottomSheetElevation: 10.0,
          bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.tertiary,
          bottomNavigationBarUnselectedLabelSchemeColor:
              SchemeColor.primaryContainer,
          bottomNavigationBarSelectedIconSchemeColor: SchemeColor.tertiary,
          bottomNavigationBarUnselectedIconSchemeColor:
              SchemeColor.primaryContainer,
          bottomNavigationBarBackgroundSchemeColor: SchemeColor.primary,
          menuItemBackgroundSchemeColor: SchemeColor.primary,
          menuItemForegroundSchemeColor: SchemeColor.primary,
          menuIndicatorBackgroundSchemeColor: SchemeColor.tertiary,
          menuIndicatorForegroundSchemeColor: SchemeColor.tertiary,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.espresso,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          sliderTrackHeight: 1,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          inputDecoratorUnfocusedBorderIsColored: false,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
          bottomSheetRadius: 5.0,
          bottomSheetElevation: 10.0,
          bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.tertiary,
          bottomNavigationBarUnselectedLabelSchemeColor:
              SchemeColor.primaryContainer,
          bottomNavigationBarSelectedIconSchemeColor: SchemeColor.tertiary,
          bottomNavigationBarUnselectedIconSchemeColor:
              SchemeColor.primaryContainer,
          bottomNavigationBarBackgroundSchemeColor: SchemeColor.primary,
          menuItemBackgroundSchemeColor: SchemeColor.primary,
          menuItemForegroundSchemeColor: SchemeColor.primary,
          menuIndicatorBackgroundSchemeColor: SchemeColor.tertiary,
          menuIndicatorForegroundSchemeColor: SchemeColor.tertiary,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
    );
  }
}
