import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:github_achievements/models/achievement_model.dart';
import 'package:palette_generator/palette_generator.dart';

part 'achievment_state.dart';

class AchievementCubit extends Cubit<AchievementState> {
  final Map<String, PaletteGenerator> paletteCache = {};
  AchievementCubit()
      : super(AchievementInitial(achievements: [
          AchievementModel(
            achDis: "answered discussions",
            achName: 'Galaxy Brain',
            unlockedDate: 'Unlocked 15 May',
            imagePath: 'assets/images/galaxy-brain-default.png',
          ),
          AchievementModel(
            achDis: "created a repository that has many stars.",
            achName: 'Starstruck',
            unlockedDate: 'Unlocked 18 May',
            imagePath: 'assets/images/starstruck-default.png',
          ),
          AchievementModel(
            achDis: "Gitty up!",
            achName: 'Quickdraw',
            unlockedDate: 'Unlocked 15 May',
            imagePath: 'assets/images/quickdraw-default.png',
          ),
          AchievementModel(
            achDis: "coauthored commits on merged pull requests.",
            achName: 'Pair Extraordinaire',
            unlockedDate: 'Unlocked 15 May',
            imagePath: 'assets/images/pair-extraordinaire-default.png',
          ),
          AchievementModel(
            achDis: "opened pull requests that have been merged.",
            achName: 'Pull Shark',
            unlockedDate: 'First unlocked on Dec 3, 2021',
            imagePath: 'assets/images/pull-shark-default.png',
          ),
          AchievementModel(
            achDis: "discovered the secrets of the universe.",
            achName: 'The Cosmic Genius',
            unlockedDate: 'Unlocked during a meteor shower',
            imagePath: 'assets/images/the-mahmoud-brain.png',
          ),
        ])) {
    preloadPalettes();
    extractDominantColor(
        (state as AchievementInitial).achievements[0].imagePath);
  }

  Future<void> preloadPalettes() async {
    for (var achievement in (state as AchievementInitial).achievements) {
      final imagePath = achievement.imagePath;
      if (!paletteCache.containsKey(imagePath)) {
        final paletteGenerator =
            await PaletteGenerator.fromImageProvider(AssetImage(imagePath));
        paletteCache[imagePath] = paletteGenerator;
      }
    }
  }

  Future<void> extractDominantColor(imagePath) async {
    if (paletteCache.containsKey(imagePath)) {
      // Retrieve the palette from the cache
      final paletteGenerator = paletteCache[imagePath];
      emit((state as AchievementInitial).copyWith(
        startColor: paletteGenerator?.lightVibrantColor?.color,
        endColor: paletteGenerator?.darkVibrantColor?.color,
      ));
    } else {
      // Generate the palette and cache it
      final paletteGenerator =
          await PaletteGenerator.fromImageProvider(AssetImage(imagePath));
      paletteCache[imagePath] = paletteGenerator;
      emit((state as AchievementInitial).copyWith(
        startColor: paletteGenerator.lightVibrantColor?.color,
        endColor: paletteGenerator.darkVibrantColor?.color,
      ));
    }
  }
}
