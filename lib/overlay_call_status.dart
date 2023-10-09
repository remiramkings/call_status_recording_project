import 'package:flutter/material.dart';

class OverlayCallStatus extends StatefulWidget {
  const OverlayCallStatus({super.key});

  @override
  State<OverlayCallStatus> createState() => _OverlayCallStatusState();
}

class _OverlayCallStatusState extends State<OverlayCallStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 18, 105, 23),
        borderRadius: const BorderRadius.all(Radius.circular(10))

      ),
      child: Icon(Icons.call, color: Colors.white,),
    );
  }
}