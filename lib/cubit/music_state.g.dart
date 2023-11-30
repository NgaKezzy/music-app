// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MusicStateCWProxy {
  MusicState currentMusic(int currentMusic);

  MusicState isPlaying(bool isPlaying);

  MusicState status(MusicStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MusicState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MusicState(...).copyWith(id: 12, name: "My name")
  /// ````
  MusicState call({
    int? currentMusic,
    bool? isPlaying,
    MusicStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMusicState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMusicState.copyWith.fieldName(...)`
class _$MusicStateCWProxyImpl implements _$MusicStateCWProxy {
  const _$MusicStateCWProxyImpl(this._value);

  final MusicState _value;

  @override
  MusicState currentMusic(int currentMusic) => this(currentMusic: currentMusic);

  @override
  MusicState isPlaying(bool isPlaying) => this(isPlaying: isPlaying);

  @override
  MusicState status(MusicStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MusicState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MusicState(...).copyWith(id: 12, name: "My name")
  /// ````
  MusicState call({
    Object? currentMusic = const $CopyWithPlaceholder(),
    Object? isPlaying = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return MusicState(
      currentMusic:
          currentMusic == const $CopyWithPlaceholder() || currentMusic == null
              ? _value.currentMusic
              // ignore: cast_nullable_to_non_nullable
              : currentMusic as int,
      isPlaying: isPlaying == const $CopyWithPlaceholder() || isPlaying == null
          ? _value.isPlaying
          // ignore: cast_nullable_to_non_nullable
          : isPlaying as bool,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as MusicStatus,
    );
  }
}

extension $MusicStateCopyWith on MusicState {
  /// Returns a callable class that can be used as follows: `instanceOfMusicState.copyWith(...)` or like so:`instanceOfMusicState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MusicStateCWProxy get copyWith => _$MusicStateCWProxyImpl(this);
}
