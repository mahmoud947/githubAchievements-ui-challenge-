import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_achievements/screens/archievments_screen.dart';
import 'package:github_achievements/cubit/achievment_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        // Customize the dark theme colors as needed
        primaryColor: Colors.black,
        backgroundColor: Colors.black,
      ),
      home: BlocProvider(
        create: (context) => AchievementCubit(),
        child: const HomePage(),
      ),
    );
  }
}

const widthAndHeight = 100.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AchievementsScreen(
        animation: _animation,
        yController: _yController,
        onScrollProgress: (value) {
          _yController.value = convertScrollProgress(value);
        },
      ),
    );
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
}

// Column(
//           children: [
//             const SizedBox(
//               height: 100,
//               width: double.infinity,
//             ),
//             AnimatedBuilder(
//               animation: Listenable.merge([
//                 _xController,
//                 _yController,
//                 _zController,
//               ]),
//               builder: (context, child) {
//                 return Transform(
//                   alignment: Alignment.center,
//                   transform: Matrix4.identity()
//                     ..rotateY(_animation.evaluate(
//                       CurvedAnimation(
//                         parent: _yController,
//                         curve: Curves.li, // Use an easing curve
//                       ),
//                     )),
//                   child: Stack(
//                     children: [
//                       SizedBox(
//                           height: 200,
//                           width: 200,
//                           child: Image.asset(
//                               "assets/images/galaxy-brain-default.png"))
//                     ],
//                   ),
//                 );
//               },
//             ),
//             Slider(
//               value: _progress,
//               min: 0.0,
//               max: 1.0,
//               onChanged: (newValue) {
//                 setState(() {
//                   _progress = newValue;
//                 });
//                 _xController.value = _progress;
//                 _yController.value = _progress;
//                 _zController.value = _progress;
//               },
//             ),
//             TextButton(
//               onPressed: () {
//                 if (_xController.isAnimating ||
//                     _yController.isAnimating ||
//                     _zController.isAnimating) {
//                   _xController.stop();
//                   _yController.stop();
//                   _zController.stop();
//                 } else {
//                   setState(() {
//                     _yController
//                       ..reset()
//                       ..repeat();
//                   });
//                 }
//               },
//               child: Text(
//                 _xController.isAnimating ||
//                         _yController.isAnimating ||
//                         _zController.isAnimating
//                     ? "Start Animation"
//                     : "Start Animation",
//               ),
//             ),
//           ],
//         ),
