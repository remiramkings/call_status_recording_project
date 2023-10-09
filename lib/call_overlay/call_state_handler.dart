import 'package:call_status_recording_project/call_overlay/call_overlay_state_widget.dart';
import 'package:call_status_recording_project/call_overlay/call_state_service.dart';
import 'package:phone_state_background/phone_state_background.dart';

callStateHandler(
  PhoneStateBackgroundEvent event,
  String number,
  int duration,){
  if(event == PhoneStateBackgroundEvent.incomingend
    || event == PhoneStateBackgroundEvent.outgoingend){
      // CallOverlayStateWidget
      //   .getInstance()
      //   .close();
      return;
    }
  CallOverlayStateWidget
    .getInstance()
    .show(event, number);
}