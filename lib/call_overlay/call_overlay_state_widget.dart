import 'package:flutter/material.dart' hide FontWeight;
import 'package:phone_state_background/phone_state_background.dart';
import 'package:system_alert_window/system_alert_window.dart';

class CallOverlayStateWidget {
  static CallOverlayStateWidget _instance = CallOverlayStateWidget();

  static CallOverlayStateWidget getInstance(){
    return _instance;
  }

  void close(){
    SystemAlertWindow.closeSystemWindow(prefMode: SystemWindowPrefMode.OVERLAY);
  }
  Future stopCallState() async {
    await PhoneStateBackground.stopPhoneStateBackground();
  }
  void show(
    PhoneStateBackgroundEvent event,
    String number
  ){
    String text = getTitleFromPhoneStatus(event);
    SystemAlertWindow.showSystemWindow(
      height: 230,
      header: Header(text, number),
      body: Body(),
      footer: Footer(number),
      margin: SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
      gravity: SystemWindowGravity.TOP,
      notificationTitle: text,
      notificationBody: number,
      prefMode: SystemWindowPrefMode.OVERLAY,
      backgroundColor: Colors.black12,
      isDisableClicks: false);
  }

  String getTitleFromPhoneStatus(PhoneStateBackgroundEvent event){
  switch (event) {
    case PhoneStateBackgroundEvent.incomingstart:
      return "Incoming";
    case PhoneStateBackgroundEvent.incomingmissed:
      return "Incoming missed";
    case PhoneStateBackgroundEvent.incomingreceived:
      return "Incoming received";
    case PhoneStateBackgroundEvent.incomingend:
      return "Incoming finished";
    case PhoneStateBackgroundEvent.outgoingstart:
      return "Outgoing";
    case PhoneStateBackgroundEvent.outgoingend:
      return "Outgoing finished";
  }
  }

  SystemWindowHeader Header(String text, String number,){
    return SystemWindowHeader(
      title: SystemWindowText(text: text, fontSize: 16, textColor: Color.fromARGB(115, 214, 213, 213)),
      padding: SystemWindowPadding.setSymmetricPadding(12, 12),
      subTitle: SystemWindowText(text: number, fontSize: 14, fontWeight: FontWeight.BOLD, textColor: Colors.white),
      decoration: SystemWindowDecoration(startColor: const Color.fromARGB(255, 37, 136, 7))); 
  }

  SystemWindowBody Body(){
    return SystemWindowBody(
      decoration: SystemWindowDecoration(startColor: Colors.white),
        rows: [
          EachRow(
            columns: [
              EachColumn(
                text: SystemWindowText(text: "Start recording this call using the below button", fontSize: 13, textColor: Colors.black54, fontWeight: FontWeight.BOLD),
              ),
            ],
            gravity: ContentGravity.LEFT,
          ),
        ],
        padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
      );
  }

  SystemWindowFooter Footer(String number){
    return SystemWindowFooter(
          buttons: [
            SystemWindowButton(
              text: SystemWindowText(text: "Start recording", fontSize: 12, textColor: Colors.white),
              tag: "start_record",
              width: 0,
              padding: SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
              height: SystemWindowButton.WRAP_CONTENT,
              decoration: SystemWindowDecoration(startColor:const Color.fromARGB(255, 9, 94, 1), borderWidth: 0, borderRadius: 30.0),
            )
          ],
          padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 10),
          decoration: SystemWindowDecoration(startColor: Colors.white),
          buttonsPosition: ButtonPosition.CENTER);
  }


}