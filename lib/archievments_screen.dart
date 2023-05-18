import 'dart:ui';

import 'package:flutter/material.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({Key? key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                color: Colors.red,
                child: const Center(
                  child: Text("page 1"),
                ),
              ),
              Container(
                color: Colors.yellow,
                child: const Center(
                  child: Text("page 2"),
                ),
              ),
              Container(
                color: Colors.green,
                child: const Center(
                  child: Text("page 3"),
                ),
              )
            ],
          ),
          Positioned(
            right: 10,
            top: 10,
            width: 30,
            height: 30,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Container(
                      color: Colors.transparent,
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
