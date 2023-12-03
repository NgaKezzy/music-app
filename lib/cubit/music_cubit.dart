import 'dart:async';

import 'package:audio_player/config/print_color.dart';
import 'package:audio_player/cubit/music_state.dart';
import 'package:audio_player/data/music_data.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';

Duration maxDuration = const Duration(seconds: 0);
final AudioPlayer player = AudioPlayer();
void getMaxDuration() {
  Timer(const Duration(seconds: 1), () {
    player.getDuration().then((value) {
      maxDuration = value ?? const Duration(seconds: 0);
    });
  });
}

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

  Future<void> playIndex(AudioPlayer player, int index) async {
    emit(state.copyWith(status: MusicStatus.start));

    emit(state.copyWith(
        isPlaying: true, status: MusicStatus.success, currentMusic: index));

    await player.stop();
    await player.play(UrlSource(musics[index].path));
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
