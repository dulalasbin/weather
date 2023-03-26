import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  bool _shouldCancelDelayedTask = false;
  Future<void> _delayedTask() async {
    await Future.delayed(Duration(seconds: 5), () {
      if (!_shouldCancelDelayedTask) {
        Get.offAllNamed('/');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _delayedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(12),
              child: Image.asset('res/1.jpg'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(65),
              ),
            ),
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Everything About the Weather At A Glance!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'This App Displays Weather Dayta At Real Time..',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                IconButton(
                  onPressed: () {
                    Get.offAllNamed('/');
                    _shouldCancelDelayedTask = !_shouldCancelDelayedTask;
                  },
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.teal,
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
