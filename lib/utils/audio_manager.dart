import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

enum Sounds {
  attraction('attraction.mp3'),
  dead('dead.mp3'),
  finish('finish.mp3'),
  start('start.mp3'),
  level1('level1.mp3'),
  level2('level2.mp3'),
  level3('level3.mp3');

  final String path;

  const Sounds(this.path);

  static fromLevel(int level) {
    switch (level) {
      case 0:
        return level1;
      case 1:
        return level2;
      case 2:
        return level3;
      default:
        return dead;
    }
  }
}

class AudioManager {
  static final specialEffects = ValueNotifier(true);
  static final backgroundMusic = ValueNotifier(true);

  static Future<void> init() async {
    FlameAudio.bgm.initialize();

    await FlameAudio.audioCache
        .loadAll([for (var sound in Sounds.values) sound.path]);
  }

  static void playSpecialEffects(Sounds sound) {
    if (specialEffects.value) {
      FlameAudio.play(sound.path);
    }
  }

  static void playBackgroundMusic(Sounds sound) {
    if (backgroundMusic.value) {
      FlameAudio.bgm.play(sound.path);
    }
  }

  static void pauseBackgroundMusic() {
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundMusic() {
    if (backgroundMusic.value) {
      FlameAudio.bgm.resume();
    }
  }

  static void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

  static void clearAudioCache(String file) {
    FlameAudio.audioCache.clear(file);
  }
}
