

import 'dart:ui';

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
      //   scaffoldBackgroundColor: const Color(0xFF111111),useMaterial3: true),
      home:AuthScreen(),
      builder: (context, child) {
        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            const Positioned(top: 51, left: 0, right: 0, child: NoInternetBanner()),
          ],
        );
      },
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: GlassCallActionBar(),
      ),
    );
  }
}






class GlassCallActionBar extends StatelessWidget {
  const GlassCallActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: screenWidth * 0.78,
        height: 112,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Soft outside blur edge
            Positioned.fill(
              child: CustomPaint(
                painter: _SoftOuterEdgePainter(),
              ),
            ),

            // Main glass body
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 18,
                    sigmaY: 18,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xff242424).withOpacity(0.90),
                          const Color(0xff191919).withOpacity(0.96),
                          const Color(0xff151515).withOpacity(0.98),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Thin glass border and highlights
            Positioned.fill(
              child: CustomPaint(
                painter: _ReferenceThinBorderPainter(),
              ),
            ),

            // Icons
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CallIcon(
                    icon: Icons.videocam_outlined,
                    onTap: () {},
                  ),
                  _CallIcon(
                    icon: Icons.call_outlined,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CallIcon({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      radius: 56,
      onTap: onTap,
      splashColor: Colors.white.withOpacity(0.05),
      highlightColor: Colors.white.withOpacity(0.025),
      child: SizedBox(
        width: 105,
        height: 95,
        child: Center(
          child: Icon(
            icon,
            color: Colors.white.withOpacity(0.97),
            size: 64,
          ),
        ),
      ),
    );
  }
}

class _SoftOuterEdgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      2,
      2,
      size.width - 4,
      size.height - 4,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(size.height / 2),
    );

    // Reference jaisa very soft outer grey edge
    final softPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        3.6,
      )
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.15),
          Colors.white.withOpacity(0.045),
          Colors.black.withOpacity(0.35),
        ],
        stops: const [0.0, 0.42, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, softPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ReferenceThinBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 2;

    final rect = Rect.fromLTWH(
      1.2,
      1.2,
      size.width - 2.4,
      size.height - 2.4,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(radius),
    );

    // Main thin border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.05
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.23),
          Colors.white.withOpacity(0.075),
          Colors.black.withOpacity(0.42),
        ],
        stops: const [0.0, 0.43, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, borderPaint);

    // Top highlight - same as previous
    final topShinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.15
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.8,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(0.11),
          Colors.white.withOpacity(0.20),
          Colors.white.withOpacity(0.08),
          Colors.white.withOpacity(0.00),
        ],
        stops: const [0.0, 0.25, 0.50, 0.75, 1.0],
      ).createShader(rect);

    canvas.drawLine(
      Offset(radius + 18, 2.2),
      Offset(size.width - radius - 18, 2.2),
      topShinePaint,
    );

    // Left curved subtle reflection
    final curvePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        1.4,
      )
      ..color = Colors.white.withOpacity(0.11);

    final leftArcRect = Rect.fromLTWH(
      3.5,
      4.5,
      size.height - 9,
      size.height - 9,
    );

    canvas.drawArc(
      leftArcRect,
      2.55,
      1.45,
      false,
      curvePaint,
    );

    // Right curved subtle reflection
    final rightArcRect = Rect.fromLTWH(
      size.width - size.height + 5.5,
      4.5,
      size.height - 9,
      size.height - 9,
    );

    canvas.drawArc(
      rightArcRect,
      -0.85,
      1.45,
      false,
      curvePaint,
    );

    // Bottom reference-like soft grey edge
    final bottomEdgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.05
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.9,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(0.045),
          Colors.white.withOpacity(0.085),
          Colors.white.withOpacity(0.045),
          Colors.white.withOpacity(0.00),
        ],
        stops: const [0.0, 0.22, 0.50, 0.78, 1.0],
      ).createShader(rect);

    canvas.drawLine(
      Offset(radius + 18, size.height - 2.2),
      Offset(size.width - radius - 18, size.height - 2.2),
      bottomEdgePaint,
    );

    // Very soft dark depth just under bottom edge
    final bottomDepthPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        2.4,
      )
      ..color = Colors.black.withOpacity(0.28);

    canvas.drawLine(
      Offset(radius + 20, size.height - 1.1),
      Offset(size.width - radius - 20, size.height - 1.1),
      bottomDepthPaint,
    );

    // Inner soft shadow around body
    final innerRect = Rect.fromLTWH(
      4.5,
      4.5,
      size.width - 9,
      size.height - 9,
    );

    final innerRRect = RRect.fromRectAndRadius(
      innerRect,
      Radius.circular(radius),
    );

    final innerShadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        1.2,
      )
      ..color = Colors.black.withOpacity(0.30);

    canvas.drawRRect(innerRRect, innerShadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
 

