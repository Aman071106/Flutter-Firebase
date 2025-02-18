import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({super.key, required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500)) // Fade In
      ..tween('translateY', Tween(begin: -200.0, end: 0.0),
          duration: Duration(milliseconds: 5000),
          curve: Curves.easeOut); // Slide Up

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, animation, child) => Opacity(
        opacity: animation.get('opacity'), // ✅ Use .get() to access 'opacity'
        child: Transform.translate(
          offset: Offset(
              0,
              animation
                  .get('translateY')), // ✅ Use .get() to access 'translateY'
          child: child,
        ),
      ),
    );
  }
}
