import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class AudioManager {
  static final specialEffects = ValueNotifier(true);
  static final backgroundMusic = ValueNotifier(true);

  static Future<void> init() async {
    FlameAudio.bgm.initialize();

    await FlameAudio.audioCache.loadAll([
      ///list sounds
      'example.mp3'
    ]);
  }

  static void playSpecialEffects(String file) {
    if (specialEffects.value) {
      FlameAudio.play(file);
    }
  }

  static void playBackgroundMusic(String file) {
    if (backgroundMusic.value) {
      FlameAudio.bgm.play(file);
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