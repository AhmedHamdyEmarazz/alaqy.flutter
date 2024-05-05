import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreenx extends StatelessWidget {
  static const routeName = '/splashx';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hightx = size.height;
    return Scaffold(
        body: Stack(clipBehavior: Clip.none, children: [
      Center(
          child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/alaqyx.jpeg',
                fit: BoxFit.fill,
              ))),
      Center(
          child: Column(children: [
        SizedBox(
          height: hightx - 370,
        ),
        LinearProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.white12,
        ),
        // Text(
        //   'برجاء الإنتظار',
        //   style: TextStyle(fontFamily: 'Tajawal', color: Colors.white),
        // ),
        AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'رجاء الإنتظار',
              textStyle: const TextStyle(
                fontSize: 20,
                fontFamily: 'Tajawal',
                color: Colors.white,
                overflow: TextOverflow.visible,
              ),
              speed: const Duration(milliseconds: 90),
            )
          ],
          repeatForever: true,
        ),
      ])),
    ]));
  }
}
