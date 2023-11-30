import 'package:audio_player/model/music_model.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class AudioPlayerPage extends StatelessWidget {
   AudioPlayerPage({super.key});

List<MusicModel> musics = [
  MusicModel(
      name: 'Trách phận vô duyên',
      author: 'Linh Hương luz',
      path: '',
      cover: ''),
];


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Audio Player')]),
      ),
      body: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'Tên bài hát',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Tên ca sĩ ',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            ProgressBar(
              thumbColor: Colors.white,
              progressBarColor: Colors.white,
              baseBarColor: Colors.grey,
              progress: Duration(seconds: 100),
              total: Duration(seconds: 500),
              onSeek: (duration) {
                print('User selected a new time: $duration');
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 45,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 45,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 45,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
