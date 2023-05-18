import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_achievements/models/achievement_model.dart';
import 'package:github_achievements/widgets/achievement_widget.dart';
import 'package:github_achievements/widgets/blur_background.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({
    Key? key,
    required this.animation,
    required this.yController,
    required this.scrollProgress,
  });
  final Tween<double> animation;
  final AnimationController yController;
  final Function(double value) scrollProgress;
  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  late PageController _controller;

  late List<AchievementModel> achievements;

  late Color startBackgroundColor;
  late Color endBackgroundColor;

  @override
  void initState() {
    super.initState();

    startBackgroundColor = Colors.transparent;
    endBackgroundColor = Colors.transparent;
    _controller = PageController();
    achievements = [
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
    ];

    _extractDominantColor(achievements[0].imagePath);
    _controller.addListener(_handlePageChange);
  }

  Future<void> _extractDominantColor(imagePath) async {
    final paletteGenerator =
        await PaletteGenerator.fromImageProvider(AssetImage(imagePath));
    setState(() {
      startBackgroundColor =
          paletteGenerator.lightVibrantColor?.color ?? Colors.transparent;

      endBackgroundColor =
          paletteGenerator.darkVibrantColor?.color ?? Colors.transparent;
    });
  }

  void _handlePageChange() async {
    double scrollProgress = _controller.page ?? 0.0;
    setState(() {
      widget.scrollProgress(scrollProgress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  startBackgroundColor,
                  endBackgroundColor,
                ],
              ),
            ),
          ),
          PageView(
            onPageChanged: (value) async {
              await _extractDominantColor(achievements[value].imagePath);
            },
            controller: _controller,
            children: [
              AchievementWidget(
                animation: widget.animation,
                yController: widget.yController,
                achievement: achievements[0],
              ),
              AchievementWidget(
                animation: widget.animation,
                yController: widget.yController,
                achievement: achievements[1],
              ),
              AchievementWidget(
                animation: widget.animation,
                yController: widget.yController,
                achievement: achievements[2],
              ),
              AchievementWidget(
                animation: widget.animation,
                yController: widget.yController,
                achievement: achievements[3],
              ),
              AchievementWidget(
                animation: widget.animation,
                yController: widget.yController,
                achievement: achievements[4],
              ),
            ],
          ),
          const Positioned(
            right: 10,
            top: 10,
            width: 30,
            height: 30,
            child: BluerBackground(
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            left: 16,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Share',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            right: 0,
            left: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 5,
                effect: SlideEffect(
                    spacing: 4,
                    radius: 100,
                    dotWidth: 8,
                    dotHeight: 8,
                    dotColor: Colors.white.withOpacity(0.3),
                    activeDotColor: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
