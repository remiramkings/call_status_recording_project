import 'package:flutter/material.dart';

class AudioRecordWidget extends StatefulWidget {
  const AudioRecordWidget({super.key});

  @override
  State<AudioRecordWidget> createState() => _AudioRecordWidgetState();
}

class _AudioRecordWidgetState extends State<AudioRecordWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Container(
          child: Text("Reong"),
        ));
  }
}