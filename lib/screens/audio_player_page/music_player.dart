
import 'package:audio_player/cubit/music_cubit.dart';
import 'package:audio_player/cubit/music_state.dart';
import 'package:audio_player/data/music_data.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({
    super.key,
  });

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    player.onPlayerStateChanged.listen(
      (it) {
        switch (it) {
          case PlayerState.stopped:
            break;
          case PlayerState.completed:
            context
                .read<MusicCubit>()
                .nextMusic(player)
                .then((value) => getMaxDuration());
            break;
          default:
            break;
        }
      },
    );
  }

  @override
  build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final MusicCubit musicCubit = context.read<MusicCubit>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<MusicCubit, MusicState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: width,
                height: height * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(
                            musics[musicCubit.state.currentMusic].image),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                musics[musicCubit.state.currentMusic].name,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                musics[musicCubit.state.currentMusic].author,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: player.onPositionChanged,
                builder: (context, snapshot) {
                  return ProgressBar(
                    timeLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    thumbColor: Colors.white,
                    progressBarColor: Colors.white,
                    baseBarColor: Colors.grey,
                    progress: snapshot.data ?? const Duration(seconds: 0),
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
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () async {
                        await musicCubit.backMusic(player);
                        getMaxDuration();
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.blue,
                        size: 25,
                      )),
                  IconButton(
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () async {
                        await musicCubit.playAndStopMusic(player);
                        getMaxDuration();
                      },
                      icon: Icon(
                        musicCubit.state.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.blue,
                        size: 40,
                      )),
                  IconButton(
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () async {
                        await musicCubit.nextMusic(player);
                        getMaxDuration();
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
    );
  }
}
