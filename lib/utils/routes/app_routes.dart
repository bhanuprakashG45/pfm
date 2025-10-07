import 'package:flutter/material.dart';
import 'package:priya_fresh_meats/res/widgets/slide_transition.dart';
import 'package:priya_fresh_meats/views/auth/login_view.dart';
import 'package:priya_fresh_meats/views/auth/otp_screen.dart';
import 'package:priya_fresh_meats/views/categories/cart_view.dart';
import 'package:priya_fresh_meats/views/categories/item_details_view.dart';
import 'package:priya_fresh_meats/views/bottomNavScreens/bottom_nav_bar.dart';
import 'package:priya_fresh_meats/views/bottomNavScreens/home_view.dart';
import 'package:priya_fresh_meats/views/categories/shopby_subcategory_view.dart';
import 'package:priya_fresh_meats/views/profile/active_orders_view.dart';
import 'package:priya_fresh_meats/views/profile/address_book_view.dart';
import 'package:priya_fresh_meats/views/profile/cancellation.dart';
import 'package:priya_fresh_meats/views/profile/contact_us.dart';
import 'package:priya_fresh_meats/views/profile/faqs_view.dart';
import 'package:priya_fresh_meats/views/profile/notification_view.dart';
import 'package:priya_fresh_meats/views/profile/orders_history_view.dart';
import 'package:priya_fresh_meats/views/bottomNavScreens/profile_view.dart';
import 'package:priya_fresh_meats/views/profile/privacy_policy.dart';
import 'package:priya_fresh_meats/views/profile/terms_and_condition.dart';
import 'package:priya_fresh_meats/views/profile/track_order_screen.dart';
import 'package:priya_fresh_meats/views/profile/wallet_transactions_view.dart';
import 'package:priya_fresh_meats/views/spashScreen/splash_view.dart';
import 'package:priya_fresh_meats/views/spashScreen/welcome_view.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String otpView = '/otp';
  static const String bottomNavBar = '/bottom';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String addressBook = '/address';
  static const String walletView = '/walletView';
  static const String ordersView = '/ordersView';
  static const String trackordersView = '/trackordersView';
  static const String notificationView = '/notificationView';
  static const String itemsView = '/itemsView';
  static const String itemDetailsView = '/itemsDetailsView';
  static const String cartView = '/cartView';
  static const String privacyPolicyView = '/privacyPolicyView';
  static const String faqsview = '/faqsview';
  static const String termsAndConditionsView = '/termsAndConditionsView';
  static const String cancellationPolicy = '/cancellationPolicy';
  static const String contactUs = '/contactUs';
  static const String razorpay = '/razorpay';
  static const String shopbySubCategoryUrl = '/subcategory';
  static const String activeOrders = '/activeOrders';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case welcome:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: const WelcomeView(),
        );
      case bottomNavBar:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: BottomNavBar(),
        );
      case login:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: const LoginView(),
        );
      case otpView:
        final phoneNumber = settings.arguments as String;
        return SlideTransitionRoute.create(
          settings: settings,
          destination: OtpScreen(phoneNumber: phoneNumber),
        );
      case notificationView:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: NotificationScreen(),
        );
      case cartView:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: CartView(),
        );

      case home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case contactUs:
        return MaterialPageRoute(builder: (_) => ContactUsPage());
      case cancellationPolicy:
        return MaterialPageRoute(builder: (_) => CancellationPolicyView());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case addressBook:
        return MaterialPageRoute(builder: (_) => AddressBookView());
      case walletView:
        return MaterialPageRoute(builder: (_) => WalletTransactionsView());
      case ordersView:
        return MaterialPageRoute(builder: (_) => OrdersHistoryView());
      case trackordersView:
        final itemId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => TrackOrderScreen(orderId: itemId),
        );
      case privacyPolicyView:
        return MaterialPageRoute(builder: (_) => PrivacyPolicyView());
      case termsAndConditionsView:
        return MaterialPageRoute(builder: (_) => TermsAndConditonView());
      case itemDetailsView:
        final itemId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ItemDetailsView(itemId: itemId),
        );
      case faqsview:
        return MaterialPageRoute(builder: (_) => FaqsScreen());
      case shopbySubCategoryUrl:
        final args = settings.arguments as Map<String, dynamic>;
        final itemId = args['itemId'] as String;
        final itemName = args['itemName'] as String;
        return MaterialPageRoute(
          builder:
              (_) => ShopbySubcategoryView(itemId: itemId, itemName: itemName),
        );
      case activeOrders:
        return MaterialPageRoute(builder: (_) => const ActiveOrdersView());
      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('No route defined for this path')),
              ),
        );
    }
  }
}
