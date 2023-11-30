import 'package:audio_player/cubit/music_state.dart';
import 'package:audio_player/model/music_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';

List<MusicModel> musics = [
  MusicModel(
    name: 'Nghe Nói Anh Yêu Em',
    author: 'Châu Khải Phong',
    path:
        'https://vnno-zn-5-tf-a320-zmp3.zmdcdn.me/7d3c7564a8993aacffd261d322088821?authen=exp=1701502174~acl=/7d3c7564a8993aacffd261d322088821/*~hmac=bfa5180e7b16d0d9adb9fa4d1c26dcf9',
    cover: '',
  ),
  MusicModel(
      name: 'Lệ Lưu Ly',
      author: 'Vũ Phụng Tiên',
      path:
          'https://c3-ex-swe.nct.vn/NhacCuaTui2046/LeLuuLyOrinnRemix-VuPhungTienDTOrinn-11877571.mp3?st=VPNn6NZjzF0Z6LGLhjifYA&e=1701926716&t=1701328131569',
      cover:
          ''),
  MusicModel(
      name: 'Rồi Em Sẽ Gặp Một Chàng Trai Khác',
      author: ' The Masked Singer, Hippoha',
      path:
          'https://c3-ex-swe.nct.vn/Warner_Audio197/RoiEmSeGapMotChangTraiKhacFeatHippohappy-TheMaskedSinger-12419077.mp3?st=hGcQz5mDobxohqFFxmst5A&e=1701928986&t=1701329001991',
      cover: ''),
  MusicModel(
      name: 'Từng Quen (Lofi Version)',
      author: 'Wren Evans, CaoTri',
      path:
          'https://c3-ex-swe.nct.vn/NhacCuaTui2047/TungQuenLofiVersion-WrenEvansCaoTri-12255972.mp3?st=M1tCATByNI83NY7YqDBNCg&e=1701928251&t=1701329076722',
      cover: ''),
  MusicModel(
      name: 'Sau Này Nếu Có Yêu Ai',
      author: 'Tăng Phúc, Ngô Kiến Huy',
      path:
          'https://vnno-pt-5-tf-a320-zmp3.zmdcdn.me/5058f478102eb18af62959e5e57b73be?authen=exp=1701501720~acl=/5058f478102eb18af62959e5e57b73be/*~hmac=217370573e8825ff9ec77bcaafc8e1f1',
      cover: '')
];

class MusicCubit extends Cubit<MusicState> {
  MusicCubit() : super(MusicState());

  void playAndStopMusic() {
    emit(state.copyWith(status: MusicStatus.start));

    emit(state.copyWith(
        isPlaying: !state.isPlaying, status: MusicStatus.success));
  }

  void nextMusic() {
    emit(state.copyWith(status: MusicStatus.start));
    int index = state.currentMusic;
    index++;

    emit(state.copyWith(currentMusic: index, status: MusicStatus.success));
  }

  void backMusic() {
    emit(state.copyWith(status: MusicStatus.start));
    int index = state.currentMusic;
    index--;

    emit(state.copyWith(currentMusic: index, status: MusicStatus.success));
  }
}
