import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'app_drawer22.dart';
import 'businesskoshk.dart';

class BusinessKoshkw extends StatefulWidget {
  static const routeName = '/BusinessKoshkw';
  final String busid;

  const BusinessKoshkw(this.busid, {super.key});
  @override
  BusinessKoshkwState createState() => BusinessKoshkwState();
}

class BusinessKoshkwState extends State<BusinessKoshkw> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), (() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => BusinessKoshk(true)));
    }));

    return Scaffold(
        drawer: AppDrawer22(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 252, 250, 250),
          foregroundColor: Colors.black,
          centerTitle: true,
          toolbarHeight: 135,
          title: Container(
              padding: const EdgeInsets.only(
                right: 50,
                //    horizontal: 30,
              ),
              child: Column(children: [
                AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        '     ',
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.cyanAccent,
                          overflow: TextOverflow.visible,
                        ),
                        speed: const Duration(seconds: 4),
                      )
                    ],
                    //  totalRepeatCount: 2,
                    repeatForever: true,
                    onNext: (p0, p1) async {
                      // slip == true
                      //     ? null
                      //     : setState(() {
                      //         stopp = true;
                      //       });
                    }),
                SizedBox(
                  height: 70,
                ),
                Text(
                  'الكشك',
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      //    RestartWidget.restartApp(context);
                    },
                    child: Center(
                        child: SizedBox(
                            //   height: 100,
                            //   width: double.infinity,
                            child: Image.asset(
                      'assets/alaqy.jpeg',
                      fit: BoxFit.contain,
                    )))),
                SizedBox(
                  height: 25,
                ),
              ])),
          actions: [],
        ),
        //  drawer: AppDrawer(),
        body: Center(
          child: LinearProgressIndicator(),
        ));
  }
}
