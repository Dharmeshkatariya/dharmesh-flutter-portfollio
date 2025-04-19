import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vikram_portfollio_dark/routes/routes.dart';
import 'package:vikram_portfollio_dark/utils/color_file.dart';
import 'package:vikram_portfollio_dark/utils/constants_file.dart';
import 'package:vikram_portfollio_dark/utils/my_custom_scroll_behavior.dart';
import 'package:vikram_portfollio_dark/utils/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final uri = Uri.base; // Get the complete current URL
  final queryParams = uri.queryParameters; // Get query parameters

  final isEmbeddingSearchWidget = queryParams['embed'] == 'search-widget';
  // const temp = true;
  if (isEmbeddingSearchWidget) {
    _runSearchWidget();
  } else {
    await _runFullApp(queryParams);
  }
  removeLoader();
}

Future<void> _runFullApp(Map<String, String> queryParams) async {
  final initialRoute = await getInitialRoute(); // Get the path part of the URL
  await getAdminConfigurationDataApi();
  UrlListener();
  runApp(MyApp(initialRoute, queryParams: queryParams));
}

void _runSearchWidget() {
  runApp(
      ScreenUtilInit(
        builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Column(
              children: [
                SizedBox(
                    height: 62,
                    child: Container()),
              ],
            ),
          ),
          initialBinding: BindingsBuilder(() {
            findTenant();
          }),
          localizationsDelegates: const [
            // ...AppLocalizations.localizationsDelegates,
            // AppLocalizations.delegate,
            // MonthYearPickerLocalizations.delegate,
            // GlobalMaterialLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
            // GlobalCupertinoLocalizations.delegate,
            // DefaultWidgetsLocalizations.delegate,

            // Add MonthYearPickerLocalizations.delegate
          ],
          // supportedLocales: AppLocalizations.supportedLocales,
        ),
      ));
}

class MyApp extends StatelessWidget {
  String initialRoute;
  final Map<String, String> queryParams;

  MyApp(this.initialRoute, {Key? key, required this.queryParams})
      : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // BreadcrumbService breadcrumbService = Get.put(BreadcrumbService());
    // AppLocale appLocale = Get.put(AppLocale());
    // appLocale.setLocal();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: ConstantsFile.themeColor.value));

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return ToastificationWrapper(
        child: ScreenUtilInit(
          builder: (context, widget) => GetMaterialApp(
              title: ConstantsFile.appName,
              debugShowCheckedModeBanner: false,
              initialBinding: BindingsBuilder(() {
                findTenant();
              }),
              localizationsDelegates: const [
                // ...AppLocalizations.localizationsDelegates,
                // AppLocalizations.delegate,
                // MonthYearPickerLocalizations.delegate,
                // GlobalMaterialLocalizations.delegate,
                // GlobalWidgetsLocalizations.delegate,
                // GlobalCupertinoLocalizations.delegate,
                // DefaultWidgetsLocalizations.delegate,

                // Add MonthYearPickerLocalizations.delegate
              ],
              // supportedLocales: AppLocalizations.supportedLocales,
              // locale: appLocale.locale,
              // fallbackLocale: controller.locale,
              scrollBehavior: MyCustomScrollBehavior(),
              builder: (context, widget) {
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: widget!,
                );
              },
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale!.languageCode) {
                    return supportedLocale;
                  }
                }
                // If the current locale doesn't match with any of the
                // supportedLocales, use the first supportedLocale, i.e., English.
                return supportedLocales.first;
              },
              theme: ThemeData(
                primarySwatch: ColorFile.primarySwatchColor,
                unselectedWidgetColor: ColorFile.grayDDColor,
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.hovered)) {
                      return ColorFile.webThemeColor;
                    } else {
                      return ColorFile.webThemeColorOpaque15;
                    }
                  }),
                  thumbVisibility: MaterialStateProperty.all(true),
                  thickness: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.hovered)) {
                      return 12.w;
                    } else {
                      return 8.w;
                    }
                  }),
                ),
                checkboxTheme: CheckboxThemeData(
                    checkColor: MaterialStateProperty.all(ColorFile.whiteColor),
                    fillColor: MaterialStateProperty.resolveWith(
                          (states) {
                        if (states
                            .any((element) => element == MaterialState.selected)) {
                          return ColorFile.webThemeColor;
                        }
                        return null;
                      },
                    )),
              ),
              getPages: Routes().appRoutes(),
              initialRoute: initialRoute,
              onGenerateRoute: (settings) {
                // if (settings.name != null) {
                //   final uri = Uri.parse(settings.name!);
                //   if (uri.path == Routes().intakeFormPage) {
                //     final templateId = queryParams[QueryParams.templateId] ?? '';
                //     final appointmentId = queryParams[QueryParams.apptId] ?? '';
                //     final patientId = queryParams[QueryParams.patientId] ?? '';
                //
                //     return GetPageRoute(
                //       page: () => IntakeFormPage(
                //         templateId: templateId,
                //         appointmentId: appointmentId,
                //         patientId: patientId,
                //       ),
                //     );
                //   }
                // }
                return null;
              },
              routingCallback: (routing) {
                final routeUri = Uri.parse(routing!.current);
                final normalizedRoute = routeUri.path;
                // // Add the current route to the breadcrumbs if it's not blank and not already present
                // if (normalizedRoute == Routes().homeScreen) {
                //   breadcrumbService.clearBreadcrumbs();
                //   final displayName = Routes().routeDisplayNames[normalizedRoute] ??
                //       normalizedRoute;
                //   if (Routes().routeDisplayNames.containsValue(displayName) &&
                //       !breadcrumbService.breadcrumbs.contains(normalizedRoute)) {
                //     breadcrumbService.addBreadcrumb(displayName);
                //   }
                // } else if (normalizedRoute != Routes().initialRoute) {
                //   final displayName = Routes().routeDisplayNames[normalizedRoute] ??
                //       normalizedRoute;
                //   if (Routes().routeDisplayNames.containsValue(displayName) &&
                //       !breadcrumbService.breadcrumbs.contains(displayName)) {
                //     breadcrumbService.addBreadcrumb(displayName);
                //   }
                // }
              }),
        ));
  }
}

void removeLoader() {
  final loader = html.document.getElementById('flutter-loader');
  if (loader != null) {
    loader.remove();
  }
}

getAdminConfigurationDataApi() async {
  // findTenant();
  // SystemSettingModel? settingsData =
  // await ApiServices().getAdminConfigurationDataApi(skipHeader: true);
  // if (settingsData != null && settingsData.data != null) {
  //   Common().setThemeColor(
  //       themeColor: ColorFile.hexToColor(settingsData.data!.brandColor!));
  //   if (settingsData.data!.faviconDetails != null &&
  //       settingsData.data!.faviconDetails!.file!.isNotEmpty) {
  //     Common().setFavicon(settingsData.data!.faviconDetails!.file!);
  //   }
  //   var encodedString = jsonEncode(settingsData.toJson());
  //   await SharedPref()
  //       .setStringPref(SharedPref().keySystemSettingData, encodedString);
  // }
}

void findTenant() {
  // Get.put<TenantController>(TenantController());
  // var dynamicUrl = html.window.location.host;
  // if (dynamicUrl.contains('localhost')) {
  //   Get.find<TenantController>().tenantAddress = ApiEndPoint().devTenant;
  // } else {
  //   Get.find<TenantController>().tenantAddress = dynamicUrl;
  // }
}

class UrlListener {
  Timer? debounceTimer;

  UrlListener() {
    html.window.onPopState.listen((event) {
      _checkLoginAndNavigate();
    });
  }

  void _checkLoginAndNavigate() async {
    bool isProviderLogin = await SharedPref().isProviderLoggedIn();
    if (isProviderLogin) {
      String currentRoute = Get.currentRoute;
      if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
      debounceTimer = Timer(const Duration(milliseconds: 300), () {
        String providerInternalRoute = Get.currentRoute;
        if (Routes()
            .providerInternalRoutes
            .values
            .any((route) => providerInternalRoute.contains(route))) {
          Get.toNamed(providerInternalRoute);
        } else {
          Get.toNamed(currentRoute);
        }
      });
    }
  }
}

getInitialRoute() async {
  String initialRoute = '';
  bool isProviderLogin = await SharedPref().isProviderLoggedIn();
  if (isProviderLogin) {
    String currentRoute = Get.currentRoute;
    if (Routes()
        .providerInternalRoutes
        .values
        .any((route) => currentRoute.contains(route))) {
      initialRoute = currentRoute;
    } else {
      initialRoute = Routes().initialRoute;
    }
  } else {
    initialRoute = Routes().initialRoute;
  }

  return initialRoute;
}
