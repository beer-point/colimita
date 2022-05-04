import 'package:colimita/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:colimita/pages/auth/login/login_page.dart';
import 'package:colimita/pages/auth/signup/signup_page.dart';
import 'package:colimita/pages/beer/beer_page.dart';
import 'package:colimita/pages/map/map_page.dart';
import 'package:colimita/pages/payments/add_card_page.dart';
import 'package:colimita/pages/payments/create_payment_page.dart';
import 'package:colimita/pages/payments/payments_page.dart';
import 'package:colimita/pages/payments/select_payment_page.dart';
import 'package:colimita/pages/payments/validate_card_page.dart';
import 'package:colimita/pages/profile/profile_page.dart';
import 'package:colimita/pages/sessions/session_page.dart';
import 'package:colimita/pages/splash_page.dart';
import 'package:colimita/pages/tabs/tabs_page.dart';
import 'package:colimita/pages/transaction/transaction_page.dart';
import 'package:colimita/shared/properties.dart';
import 'package:colimita/theme/theme.dart';
import 'package:colimita/widgets/errors_stream.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Properties.readProperties();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: BaseApp());
  }
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class BaseApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      // final pushNotificationService = PushNotificationManager();
      // pushNotificationService.init();

      final subscription =
          errorMessageStreamController.stream.listen((errorMessage) {
        rootScaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: AppTheme.lightTheme.errorColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
      return subscription.cancel;
    }, [errorMessageStreamController.stream]);

    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      routes: _getRoutes(),
    );
  }

  Map<String, WidgetBuilder> _getRoutes() {
    return {
      /// Weird bug where pushReplacementNamed '/login' route in
      /// the SplashPage widgets make Material App to first push
      /// the '/' route. Refactoring '/' to '/home' fixed the issue
      '/home': (context) => TabsPage(),
      '/splash': (context) => SplashPage(),
      '/login': (context) => LoginPage(),
      '/signup': (context) => SignupPage(),
      '/forgot-password': (context) => ForgotPasswordPage(),
      '/beer': (context) => BeerPage(),
      '/map': (context) => MapPage(),
      '/payments': (context) => PaymentsPage(),
      '/profile': (context) => ProfilePage(),
      '/session': (context) => SessionPage(),
      '/transaction': (context) => TransactionPage(),
      '/payments/add-card': (context) => AddCardPage(),
      '/payments/select-payment-method': (context) => SelectPaymentPage(),
      '/payments/validate-card': (context) => ValidateCardPage(),
      '/payments/create': (context) => CreatePaymentPage(),
    };
  }
}
