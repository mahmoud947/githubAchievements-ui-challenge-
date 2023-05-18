import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_achievements/cubit/achievment_cubit.dart';
import 'package:github_achievements/models/achievement_model.dart';
import 'package:github_achievements/widgets/achievement_widget.dart';
import 'package:github_achievements/widgets/blur_background.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AchievementsScreen extends StatelessWidget {
  AchievementsScreen({
    Key? key,
    required this.animation,
    required this.yController,
    required this.onScrollProgress,
  });
  final Tween<double> animation;
  final AnimationController yController;
  final Function(double value) onScrollProgress;
  late PageController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = PageController();

    _controller.addListener(
      () {
        double scrollProgress = _controller.page ?? 0.0;

        onScrollProgress(scrollProgress);
      },
    );

    return BlocBuilder<AchievementCubit, AchievementState>(
      builder: (context, state) {
        if (state is AchievementInitial) {
          return Scaffold(
            body: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        (state).startColor ?? Colors.black,
                        (state).endColor ?? Colors.black
                      ],
                    ),
                  ),
                ),
                PageView.builder(
                  onPageChanged: (value) async {
                    await context.read<AchievementCubit>().extractDominantColor(
                          state.achievements[value].imagePath,
                        );
                  },
                  controller: _controller,
                  itemCount: state.achievements.length,
                  itemBuilder: (_, index) {
                    return AchievementWidget(
                      animation: animation,
                      yController: yController,
                      achievement: state.achievements[index],
                    );
                  },
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
                      count: state.achievements.length,
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
        } else {
          return Container();
        }
      },
    );
  }
}
