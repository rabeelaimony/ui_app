import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ui_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _navigateLater();
  }

  void _navigateLater() async {
    await Future.delayed(const Duration(seconds: 15));
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final progress = _controller.value;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1B5E20), // أخضر داكن جداً
                  Color(0xFF2E7D32), // أخضر داكن
                  Color(0xFF388E3C), // أخضر متوسط
                  Color(0xFF66BB6A), // أخضر مونسي
                  Colors.white, // لمسة بيضاء
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.2, 0.45, 0.75, 1.0],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 🌐 الشبكة
                CustomPaint(size: size, painter: GridPainter(progress)),

                // ✨ نجوم ولمعان
                CustomPaint(size: size, painter: StarsPainter(progress)),

                // 🌊 موجات Ripples
                ...List.generate(3, (i) {
                  final rippleProgress = ((progress + i * 0.3) % 1.0);
                  final radius = 120.0 + (rippleProgress * 150);
                  final opacity = (1 - rippleProgress).clamp(0.0, 1.0);

                  return Container(
                    width: radius * 2,
                    height: radius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.greenAccent.withOpacity(0.35 * opacity),
                        width: 2,
                      ),
                    ),
                  );
                }),

                // 🪩 اللوغو بخلفية شفافة وأكبر
                Transform.scale(
                  scale: 1.0 + (sin(progress * 2 * pi) * 0.05),
                  child: ClipOval(
                    child: Container(
                      width: 300, // أكبر
                      height: 300,
                      padding: const EdgeInsets.all(30),
                      color: Colors.transparent,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
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

/// 🎨 الشبكة (Cyber Grid)
class GridPainter extends CustomPainter {
  final double progress;
  GridPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(
        Offset(x + (progress * 10), 0),
        Offset(x, size.height),
        paint,
      );
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(
        Offset(0, y + (progress * 10)),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) => true;
}

/// ✨ نجوم ولمعان
class StarsPainter extends CustomPainter {
  final double progress;
  StarsPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);
    final paint = Paint();

    for (int i = 0; i < 50; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.5 + 0.5;

      final twinkle = (sin(progress * 2 * pi + i) + 1) / 2;
      paint.color = Colors.white.withOpacity(0.3 + twinkle * 0.7);

      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarsPainter oldDelegate) => true;
}
