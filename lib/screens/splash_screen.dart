import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ui_app/screens/login_screen.dart';
import 'package:ui_app/screens/home_screen.dart';
import 'package:ui_app/services/app_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _backgroundController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _textAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeInOut),
    );

    _startAnimations();
    _backgroundController.repeat();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 3000));
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    // مدة الانتظار قبل الانتقال (هنا 5 ثواني)
    await Future.delayed(const Duration(seconds: 0));

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const LoginScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
              ),
            ),
            child: Stack(
              children: [
                // Internet-themed animated background
                ...List.generate(25, (index) {
                  final double animationValue = _backgroundAnimation.value;
                  final double screenWidth = MediaQuery.of(context).size.width;
                  final double screenHeight = MediaQuery.of(
                    context,
                  ).size.height;

                  final double baseX = (index % 5) * (screenWidth / 5);
                  final double baseY = (index ~/ 5) * (screenHeight / 6);

                  // Smooth floating animation
                  final double offsetX =
                      20 * sin(animationValue * 2 * pi + index * 0.3);
                  final double offsetY =
                      15 * cos(animationValue * 2 * pi + index * 0.5);

                  return Positioned(
                    left: baseX + offsetX,
                    top: baseY + offsetY,
                    child: Transform.rotate(
                      angle: animationValue * 2 * pi * 0.1 + index * 0.2,
                      child: Opacity(
                        opacity:
                            0.08 + 0.04 * sin(animationValue * 2 * pi + index),
                        child: Icon(
                          [
                            Icons.wifi,
                            Icons.router_outlined,
                            Icons.cloud_outlined,
                            Icons.signal_cellular_alt,
                            Icons.cast_connected,
                          ][index % 5],
                          color: Colors.white,
                          size:
                              22 +
                              6 * sin(animationValue * 2 * pi + index * 0.7),
                        ),
                      ),
                    ),
                  );
                }),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Animation
                      AnimatedBuilder(
                        animation: _logoAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _logoAnimation.value,
                            child: Container(
                              width: 200,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/logo.Png', // ضع مسار صورة اللوغو هنا
                                  fit: BoxFit.contain,
                                  width: 150,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 40),

                      // Text Animation
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _textAnimation,
                          child: Column(
                            children: [
                              const SizedBox(height: 15),

                              // النص الجديد مع الجملة القديمة
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    const Text(
                                      'أول مزود إنترنت خاص في سوريا',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(width: 5),
                                        const Text(
                                          ' مع آية حياتك ONLINE',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              8,
                                              150,
                                              13,
                                            ), // أخضر
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.wifi,
                                          color: Color.fromARGB(
                                            255,
                                            18,
                                            218,
                                            25,
                                          ), // أخضر
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 80),

                      // Loading Indicator
                      FadeTransition(
                        opacity: _textAnimation,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
