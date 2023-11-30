import 'dart:async';

import 'package:audio_player/screens/audio_player_page/audio_player_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void nextPage(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  AudioPlayerPage()));
    });
  }

  @override
  void initState() {
    super.initState();
    nextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Center(
          child: const Text(
            'Audio Player',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
