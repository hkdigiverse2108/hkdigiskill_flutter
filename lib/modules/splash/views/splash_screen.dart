import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/modules/splash/controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(child: AnimatedLogo()),
      ),
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  bool _assetsLoaded = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    _fade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scale = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // Preload assets, then start animation. Do NOT navigate here.
    _preloadAssets();
  }

  Future<void> _preloadAssets() async {
    try {
      await Future.wait([
        precacheImage(const AssetImage(AppImages.splashBackground), context),
        precacheImage(const AssetImage(AppImages.logo), context),
      ]);
    } catch (e) {
      // ignore, still proceed
    } finally {
      if (mounted) {
        setState(() => _assetsLoaded = true);
        // start the animation
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_assetsLoaded) {
      // small loader while precache runs
      return const SizedBox(
        width: 200,
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fade.value,
          child: Transform.scale(
            scale: _scale.value,
            child: Image.asset(
              AppImages.logo,
              width: 200,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
