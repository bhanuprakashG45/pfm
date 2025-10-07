import 'dart:async';
import 'package:priya_fresh_meats/utils/exports.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _rotateController;
  late AnimationController _pulseController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _pulseAnimation;

  final SharedPref _pref = SharedPref();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();

    Timer(const Duration(seconds: 3), () async {
      final token = await _pref.getAccessToken();
      debugPrint(token);
      if (token == '') {
        Navigator.pushReplacementNamed(context, AppRoutes.welcome);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.bottomNavBar);
      }
    });
  }

  void _initializeAnimations() {
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    _fadeController.forward();

    Future.delayed(const Duration(milliseconds: 200), () {
      _scaleController.forward();
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      _rotateController.repeat(reverse: true);
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      _pulseController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _rotateController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _scaleAnimation,
            _fadeAnimation,
            _rotateAnimation,
            _pulseAnimation,
          ]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value * _pulseAnimation.value,
              child: Transform.rotate(
                angle: _rotateAnimation.value,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Hero(
                    tag: 'app_logo',
                    child: Image.asset(
                      'assets/images/splashfinal.png',
                      height: 300.h,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
