

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'music_state.g.dart';

enum MusicStatus {init, start, success, error}
@CopyWith()
class MusicState extends Equatable {
  const MusicState({this.currentMusic = 0, this.isPlaying = false, this.status= MusicStatus.init});
  final int currentMusic;
  final bool isPlaying;
  final MusicStatus status;

  @override
  List<Object> get props => [currentMusic, isPlaying, status];
}
