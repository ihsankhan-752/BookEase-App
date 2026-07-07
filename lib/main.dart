import 'package:bookease/controllers/auth_controller.dart';
import 'package:bookease/controllers/booking_controller.dart';
import 'package:bookease/controllers/image_controller.dart';
import 'package:bookease/controllers/review_controller.dart';
import 'package:bookease/controllers/service_provider_controller.dart';
import 'package:bookease/controllers/socket_controller.dart';
import 'package:bookease/controllers/user_controller.dart';
import 'package:bookease/routes/app_routes.dart';
import 'package:bookease/services/storage_services.dart';
import 'package:bookease/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const BookEaseApp());
}

class BookEaseApp extends StatelessWidget {
  const BookEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => ImageController()),
        ChangeNotifierProvider(create: (_) => ServiceController()),
        ChangeNotifierProvider(create: (_) => BookingController()),
        ChangeNotifierProvider(create: (_) => ReviewController()),
        ChangeNotifierProvider(
          create: (_) => SocketController(navigatorKey: navigatorKey),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: AppConstants.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
