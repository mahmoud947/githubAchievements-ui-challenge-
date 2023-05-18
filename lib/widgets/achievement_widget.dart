import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_achievements/models/achievement_model.dart';

import 'blur_background.dart';

class AchievementWidget extends StatelessWidget {
  const AchievementWidget({
    Key? key,
    required this.achievement,
    required this.animation,
    required this.yController,
  }) : super(key: key);

  final AchievementModel achievement;
  final Tween<double> animation;
  final AnimationController yController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 80),
        AnimatedBuilder(
          animation: Listenable.merge([
            yController,
          ]),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(animation.evaluate(
                  CurvedAnimation(
                    parent: yController,
                    curve: Curves.linear, // Use an easing curve
                  ),
                )),
              child: Stack(
                children: [
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset(achievement.imagePath),
                  )
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 40),
        Column(
          children: [
            Text(
              achievement.achName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "@mahmoud947 ${achievement.achDis}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 24),
                BluerBackground(
                  color: Colors.white,
                  child: SizedBox(
                    height: 16,
                    width: 16,
                    child: SvgPicture.asset(
                      'assets/images/win.svg',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(achievement.unlockedDate),
              ],
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const SizedBox(width: 38),
                  Container(
                    width: 1,
                    height: 10,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 24,
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text('mahmoud - stationClub #1 2nd accepted answer'),
              ],
            ),
          ],
        )
      ],
    );
  }
}
