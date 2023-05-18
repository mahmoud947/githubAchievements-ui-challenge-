import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_achievements/widgets/achievement_widget.dart';
import 'package:github_achievements/widgets/blur_background.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen(
      {Key? key, required this.animation, required this.yController});
  final Tween<double> animation;
  final AnimationController yController;

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  late PageController _controller;

  get pi => null;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _controller.addListener(_handlePageChange);
  }

  double convertScrollProgress(double value) {
    final minValue = 0.0;
    final maxValue = 1.0;

    if (value < minValue) {
      return minValue;
    } else if (value > maxValue) {
      final range = maxValue - minValue;
      final repeatedValue = (value - minValue) % range;
      return repeatedValue + minValue;
    } else {
      return (value - minValue) / (maxValue - minValue);
    }
  }

  void _handlePageChange() {
    double scrollProgress = _controller.page ?? 0.0;

    setState(() {
      print(convertScrollProgress(scrollProgress));
      widget.yController.value = convertScrollProgress(scrollProgress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              AchievementWidget(
                achDis: "answered discussions",
                achName: 'Galaxy Brain',
                unlockedDate: 'Unlocked 15 May',
                imagePath: 'assets/images/galaxy-brain-default.png',
                animation: widget.animation,
                yController: widget.yController,
              ),
              AchievementWidget(
                achDis: "answered discussions",
                achName: 'Galaxy Brain',
                unlockedDate: 'Unlocked 15 May',
                imagePath: 'assets/images/pair-extraordinaire-default.png',
                animation: widget.animation,
                yController: widget.yController,
              ),
              AchievementWidget(
                achDis: "answered discussions",
                achName: 'Galaxy Brain',
                unlockedDate: 'Unlocked 15 May',
                imagePath: 'assets/images/galaxy-brain-default.png',
                animation: widget.animation,
                yController: widget.yController,
              ),
              AchievementWidget(
                achDis: "answered discussions",
                achName: 'Galaxy Brain',
                unlockedDate: 'Unlocked 15 May',
                imagePath: 'assets/images/galaxy-brain-default.png',
                animation: widget.animation,
                yController: widget.yController,
              ),
              AchievementWidget(
                achDis: "answered discussions",
                achName: 'Galaxy Brain',
                unlockedDate: 'Unlocked 15 May',
                imagePath: 'assets/images/galaxy-brain-default.png',
                animation: widget.animation,
                yController: widget.yController,
              ),
              AchievementWidget(
                achDis: "answered discussions",
                achName: 'Galaxy Brain',
                unlockedDate: 'Unlocked 15 May',
                imagePath: 'assets/images/galaxy-brain-default.png',
                animation: widget.animation,
                yController: widget.yController,
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
                count: 3,
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
