import 'package:priya_fresh_meats/utils/exports.dart';
import 'package:priya_fresh_meats/viewmodels/category_vm/category_viewmodel.dart';
import 'package:priya_fresh_meats/viewmodels/razorpay_vm/razorpay_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initMessaging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MaterialTheme theme = MaterialTheme();
    return ScreenUtilInit(
      designSize: const Size(411.42, 867.42),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ChangeNotifierProvider(create: (_) => LocationProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(
            create: (_) => ItemDetailsProvider(ItemDetailsRepositoryImpl()),
          ),
          ChangeNotifierProvider(
            create: (_) => CategoryProvider(CategoryRepositoryImpl()),
          ),
          ChangeNotifierProvider(create: (_) => HomeViewmodel()),
          ChangeNotifierProvider(create: (_) => ShopbycategoryViewmodel()),
          ChangeNotifierProvider(create: (_) => ProfileViewModel()),
          ChangeNotifierProvider(create: (_) => SearchViewmodel()),
          ChangeNotifierProvider(create: (_) => OrderViewModel()),
          ChangeNotifierProvider(create: (_) => CategoryViewmodel()),
          ChangeNotifierProvider(create: (_) => RazorpayViewmodel()),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'PFM',
          theme: theme.light(),
          // darkTheme: theme.dark(),
          // themeMode: ThemeMode.system,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
