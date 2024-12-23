import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/util/disable_glow_behavior.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_header.dart';
import '../../../widget/app_touchable.dart';

class PedometerScreen extends StatefulWidget {
  const PedometerScreen({super.key});

  @override
  State<PedometerScreen> createState() => _PedometerScreenState();
}

class _PedometerScreenState extends State<PedometerScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  int _initialSteps = 0;
  int _currentSteps = 0;
  bool _isWalking = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    _initialSteps = 0;
    super.dispose();
  }

  void onStepCount(StepCount event) {
    if (_isWalking) {
      setState(() {
        _currentSteps = event.steps - _initialSteps;
      });
    }
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
      print("event.status = ${event.status}");

      if (event.status == 'walking') {
        _isWalking = true;
      } else {
        _isWalking = false;
      }
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
  }

  Future<bool> _checkActivityRecognitionPermission() async {
    bool granted = await Permission.activityRecognition.isGranted;

    if (!granted) {
      granted = await Permission.activityRecognition.request() == PermissionStatus.granted;
    }

    return granted;
  }

  Future<void> initPlatformState() async {
    bool granted = await _checkActivityRecognitionPermission();
    if (!granted) {
      // tell user, the app will not work
    }

    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen((stepCount) {
      if (_initialSteps == 0) {
        _initialSteps = stepCount.steps;
      }
      onStepCount(stepCount);
    }).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppHeader(
            title: "Pedometer",
            leftWidget: AppTouchable.common(
              width: 40.0.sp,
              height: 40.0.sp,
              onPressed: () => Get.back(),
              decoration: const BoxDecoration(boxShadow: null),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColor.black,
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const DisableGlowBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Steps Taken',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      _currentSteps.toString(),
                      style: const TextStyle(fontSize: 60),
                    ),
                    const Divider(
                      height: 100,
                      thickness: 0,
                      color: Colors.white,
                    ),
                    const Text(
                      'Pedestrian Status',
                      style: TextStyle(fontSize: 30),
                    ),
                    Icon(
                      _status == 'walking'
                          ? Icons.directions_walk
                          : _status == 'stopped'
                              ? Icons.accessibility_new
                              : Icons.error,
                      size: 100,
                    ),
                    Center(
                      child: Text(
                        _status,
                        style: _status == 'walking' || _status == 'stopped'
                            ? const TextStyle(fontSize: 30)
                            : const TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
