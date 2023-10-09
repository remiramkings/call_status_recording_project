import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state_background/phone_state_background.dart';
import 'package:system_alert_window/system_alert_window.dart';

class CallStateService {
  static CallStateService _instance = CallStateService();

  static CallStateService getInstance(){
    return _instance;
  }

  Future checkPermission() async {
    if(!await PhoneStateBackground.checkPermission()){
      await PhoneStateBackground.requestPermissions();
    }
    await requestPhonePermission();
    await requestOverlayPermission();
  }

  Future<bool> requestPhonePermission() async {
    var status = await Permission.phone.request();

    return switch (status) {
      PermissionStatus.denied ||
      PermissionStatus.restricted ||
      PermissionStatus.limited ||
      PermissionStatus.permanentlyDenied =>
        false,
      PermissionStatus.provisional || PermissionStatus.granted => true,
    };
  }

  Future<void> requestOverlayPermission() async {
    await SystemAlertWindow.requestPermissions(prefMode: SystemWindowPrefMode.OVERLAY);
  }

  Future<void> initBackgroundService(
    dynamic Function(PhoneStateBackgroundEvent, String, int) backgroundCallback,
    dynamic Function(String ) onClickCallback) async {
    await PhoneStateBackground.initialize(backgroundCallback);
    SystemAlertWindow.registerOnClickListener(onClickCallback);
  }
}