import 'package:audio_player/cubit/music_cubit.dart';
import 'package:audio_player/cubit/music_state.dart';
import 'package:audio_player/data/music_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongList extends StatefulWidget {
  const SongList({
    super.key,
  });

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  late MusicCubit musicCubit;
  late int indexSelect;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    musicCubit = context.read<MusicCubit>();
    if (musicCubit.state.isPlaying) {
      setState(() {
        indexSelect = musicCubit.state.currentMusic;
      });
    } else {
      setState(() {
        indexSelect = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<MusicCubit, MusicState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                  child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: musics.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return _ItemSongList(
                    onTapCallBack: () async {
                      setState(() {
                        indexSelect = index;
                        getMaxDuration();
                      });
                      await musicCubit.playIndex(player, index);
                    },
                    name: musics[index].name,
                    image: musics[index].image,
                    author: musics[index].author,
                    isSelect: indexSelect == index,
                  );
                },
              )),
            ],
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class _ItemSongList extends StatelessWidget {
  _ItemSongList(
      {this.name = '',
      this.author = '',
      this.image = '',
      this.isSelect = false,
      required this.onTapCallBack});
  final String image;
  final String name;
  final String author;
  late bool isSelect;
  final VoidCallback onTapCallBack;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        onTapCallBack.call();
      },
      child: Container(
        height: 80,
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isSelect ? Colors.green : const Color(0xff2D4356),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(image),
                ),
              ),
              child: Icon(
                isSelect ? Icons.pause : Icons.play_arrow,
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: width - 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    author,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
