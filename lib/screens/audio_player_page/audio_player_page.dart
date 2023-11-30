import 'dart:async';

import 'package:audio_player/cubit/music_cubit.dart';
import 'package:audio_player/cubit/music_state.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AudioPlayerPage extends StatefulWidget {
  AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  int currentMusic = 0;

  final player = AudioPlayer();

  Duration maxDuration = const Duration(seconds: 0);
  Duration time = const Duration(seconds: 0);

  void getMaxDuration() {
    player.getDuration().then((value) {
      maxDuration = value ?? Duration(seconds: 0);
    });
  }

  void getTime() {
    Timer(Duration(seconds: 1), () {
      player.getDuration().then((value) {
        time = value ?? Duration(seconds: 0);
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final musicCubit = context.read<MusicCubit>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFFF9B50), Color(0xFF952323)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<MusicCubit, MusicState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Music',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: width,
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn.voh.com.vn/voh/Image/2018/12/20/113569468787218822010901725631029n2_20181220132032.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    musics[state.currentMusic].name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    musics[state.currentMusic].author,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    stream: player.onPositionChanged,
                    builder: (context, snapshot) {
                      return ProgressBar(
                        thumbColor: Colors.white,
                        progressBarColor: Colors.white,
                        baseBarColor: Colors.grey,
                        progress: snapshot.data ?? Duration(seconds: 0),
                        total: maxDuration,
                        onSeek: (duration) {
                          player.seek(duration);
                          setState(() {});
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            player.stop();
                            musicCubit.backMusic();
                            player.play(UrlSource(musics[currentMusic].path));
                            getMaxDuration();
                            getTime();
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Colors.blue,
                            size: 25,
                          )),
                      IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            player.state == PlayerState.playing
                                ? player.pause()
                                : player.play(
                                    UrlSource(musics[state.currentMusic].path));
                            musicCubit.playAndStopMusic();
                            getMaxDuration();
                            getTime();
                          },
                          icon: Icon(
                            state.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.blue,
                            size: 40,
                          )),
                      IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            player.stop();
                            musicCubit.nextMusic();
                            player.play(
                                UrlSource(musics[state.currentMusic].path));
                            getMaxDuration();
                            getTime();
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            color: Colors.blue,
                            size: 25,
                          )),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
