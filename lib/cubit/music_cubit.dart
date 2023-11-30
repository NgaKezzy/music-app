import 'package:audio_player/config/print_color.dart';
import 'package:audio_player/cubit/music_state.dart';
import 'package:audio_player/model/music_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';

List<MusicModel> musics = [
  MusicModel(
      name: 'Sau Lưng Anh Có Ai Kìa',
      author: 'Thiều Bảo Trâm',
      path:
          'https://vnno-pt-1-tf-a320-zmp3.zmdcdn.me/dc9a3ed6743b66ca0c2ecf3dcce8d8df?authen=exp=1701513307~acl=/dc9a3ed6743b66ca0c2ecf3dcce8d8df/*~hmac=afb6d6227aa6de3481783b2d3a8d0c75',
      image:
          'https://vtv1.mediacdn.vn/thumb_w/650/2021/1/26/thieu-bao-tram-dang-anh-xinh-dep-nhung-duom-buon-10-16116295827361159002401-crop-16116322265561934462894.jpg'),
  MusicModel(
      name: 'Ai Hát Em Nghe',
      author: 'Orange',
      path:
          'https://vnno-vn-6-tf-a320-zmp3.zmdcdn.me/0de550afb5a32c26466efb2fd9a901f3?authen=exp=1701513226~acl=/0de550afb5a32c26466efb2fd9a901f3/*~hmac=94e937d9af6bdd77a05fea9f9dcbe50c',
      image:
          'https://109cdf7de.vws.vegacdn.vn/kv0puCNE4oNNfn7YhOpK/1/v1/songs/img/s0/0/3/162/youtube_3312095.jpg?v=1?v=1701360761'),
  MusicModel(
    name: 'Nghe Nói Anh Yêu Em',
    author: 'Châu Khải Phong',
    path:
        'https://vnno-zn-5-tf-a320-zmp3.zmdcdn.me/7d3c7564a8993aacffd261d322088821?authen=exp=1701502174~acl=/7d3c7564a8993aacffd261d322088821/*~hmac=bfa5180e7b16d0d9adb9fa4d1c26dcf9',
    image:
        'https://photo-resize-zmp3.zmdcdn.me/w600_r1x1_jpeg/cover/7/9/4/2/794229c0dc49ac8ad17ec0ce5b8a84cb.jpg',
  ),
  MusicModel(
      name: 'Lệ Lưu Ly',
      author: 'Vũ Phụng Tiên',
      path:
          'https://c3-ex-swe.nct.vn/NhacCuaTui2046/LeLuuLyOrinnRemix-VuPhungTienDTOrinn-11877571.mp3?st=VPNn6NZjzF0Z6LGLhjifYA&e=1701926716&t=1701328131569',
      image:
          'https://photo-resize-zmp3.zmdcdn.me/w600_r1x1_jpeg/cover/6/9/3/f/693f8f516bfaa717ef4043f11edfdde2.jpg'),
  MusicModel(
      name: 'Rồi Em Sẽ Gặp Một Chàng Trai Khác',
      author: ' The Masked Singer, Hippoha',
      path:
          'https://c3-ex-swe.nct.vn/Warner_Audio197/RoiEmSeGapMotChangTraiKhacFeatHippohappy-TheMaskedSinger-12419077.mp3?st=hGcQz5mDobxohqFFxmst5A&e=1701928986&t=1701329001991',
      image:
          'https://avatar-ex-swe.nixcdn.com/song/2023/11/15/d/6/1/0/1700018872628_500.jpg'),
  MusicModel(
      name: 'Từng Quen (Lofi Version)',
      author: 'Wren Evans, CaoTri',
      path:
          'https://c3-ex-swe.nct.vn/NhacCuaTui2047/TungQuenLofiVersion-WrenEvansCaoTri-12255972.mp3?st=M1tCATByNI83NY7YqDBNCg&e=1701928251&t=1701329076722',
      image:
          'https://avatar-ex-swe.nixcdn.com/song/2023/11/13/e/1/8/a/1699866717409_500.jpg'),
  MusicModel(
      name: 'Sau Này Nếu Có Yêu Ai',
      author: 'Tăng Phúc, Ngô Kiến Huy',
      path:
          'https://vnno-pt-5-tf-a320-zmp3.zmdcdn.me/5058f478102eb18af62959e5e57b73be?authen=exp=1701501720~acl=/5058f478102eb18af62959e5e57b73be/*~hmac=217370573e8825ff9ec77bcaafc8e1f1',
      image:
          'https://photo-resize-zmp3.zmdcdn.me/w600_r1x1_jpeg/cover/a/f/2/a/af2a52d9784647085f1466075e96c009.jpg')
];

class MusicCubit extends Cubit<MusicState> {
  MusicCubit() : super(MusicState());

  int _index = 0;

  Future<void> playAndStopMusic(AudioPlayer player) async {
    emit(state.copyWith(status: MusicStatus.start));

    emit(state.copyWith(
        isPlaying: !state.isPlaying, status: MusicStatus.success));
    player.state == PlayerState.playing
        ? await player.pause()
        : await player.play(UrlSource(musics[state.currentMusic].path));
  }

  Future<void> nextMusic(AudioPlayer player) async {
    _index = state.currentMusic + 1;
    if (_index == musics.length) {
      _index = 0;
      emit(state.copyWith(status: MusicStatus.start));
      emit(
        state.copyWith(
            currentMusic: 0, status: MusicStatus.success, isPlaying: true),
      );
      await player.stop();
      await player.play(UrlSource(musics[state.currentMusic].path));
      printRed(state.currentMusic.toString());
    } else {
      printYellow(state.currentMusic.toString());
      emit(state.copyWith(status: MusicStatus.start));
      emit(
        state.copyWith(
            currentMusic: state.currentMusic + 1,
            status: MusicStatus.success,
            isPlaying: true),
      );
      await player.stop();
      await player.play(UrlSource(musics[state.currentMusic].path));
    }
  }

  Future<void> backMusic(AudioPlayer player) async {
    _index = state.currentMusic - 1;
    if (_index < 0) {
      _index = 0;

      emit(state.copyWith(status: MusicStatus.start));
      emit(
        state.copyWith(
            currentMusic: 0, status: MusicStatus.success, isPlaying: true),
      );
      await player.stop();
      await player.play(UrlSource(musics[state.currentMusic].path));
    } else {
      emit(state.copyWith(status: MusicStatus.start));

      emit(
        state.copyWith(
            currentMusic: state.currentMusic - 1,
            status: MusicStatus.success,
            isPlaying: true),
      );
      await player.stop();
      await player.play(UrlSource(musics[state.currentMusic].path));
    }
  }
}
