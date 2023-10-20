import 'dart:io';
import 'dart:ui';
import 'package:call_status_recording_project/Notification_Services.dart';
import 'package:call_status_recording_project/app_launch.dart';
import 'package:call_status_recording_project/file_list.dart';
import 'package:call_status_recording_project/audio_record_widget.dart';
import 'package:call_status_recording_project/audio_recording_service.dart';
import 'package:call_status_recording_project/call_overlay/call_state_handler.dart';
import 'package:call_status_recording_project/call_overlay/call_state_service.dart';
import 'package:call_status_recording_project/overlay_call_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state_background/phone_state_background.dart';
import 'package:system_alert_window/system_alert_window.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

NotificationService notificationService = NotificationService();

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
void callBack(String tag) {
  WidgetsFlutterBinding.ensureInitialized();
  print(tag);
  switch (tag) {
    case "start_record":
      // Navigator.push(navigatorKey.currentState!.context,
      //       MaterialPageRoute(builder: (context) => AudioRecordWidget()));
      // AudioRecoringService.getInstance().startRecording();
      AppLaunch.getInstance().openApp();
      break;
    case "close":
      SystemAlertWindow.closeSystemWindow(
          prefMode: SystemWindowPrefMode.OVERLAY);
      break;
    default:
      SystemAlertWindow.closeSystemWindow(
          prefMode: SystemWindowPrefMode.OVERLAY);
  }
}

/// Defines a callback that will handle all background incoming events
@pragma(
    'vm:entry-point') // Be sure to annotate your callback function to avoid issues in release mode on Flutter >= 3.3.0
Future<void> phoneStateBackgroundCallbackHandler(
  PhoneStateBackgroundEvent event,
  String number,
  int duration,
) async {
  callStateHandler(event, number, duration);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Example());
  }
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Container(
          child: Text("Reong"),
        ));
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> with WidgetsBindingObserver {
  bool startRecording = true;
  bool stopRecording = false;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await CallStateService.getInstance().checkPermission();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // SystemAlertWindow.removeOnClickListener();
    super.dispose();
  }

  Future initAll() async {
    final callStateService = CallStateService.getInstance();
    callStateService.checkPermission();
    callStateService.initBackgroundService(
        phoneStateBackgroundCallbackHandler, callBack);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    //AudioRecoringService.getInstance().startRecording();
    initAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone State"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Hang on, the system will do all the things for you"),
            Visibility(
              visible: startRecording,
              child: ElevatedButton(
                  onPressed: () {
                    AudioRecoringService.getInstance().startRecording();
                    setState(() {
                      startRecording = false;
                      stopRecording = true;
                    });
                  },
                  child: Text('Start recording')),
            ),
            Visibility(
              visible: stopRecording,
              child: ElevatedButton(
                  onPressed: () {
                    AudioRecoringService.getInstance().stopRecording();

                    startRecording = true;
                    stopRecording = false;

                    setState(() {});
                  },
                  child: Text('Stop recording')),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FileList()),
                  );
                },
                child: const Text('Get files'))
          ],
        ),
      ),
    );
  }
}
