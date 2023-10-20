import 'package:device_apps/device_apps.dart';

class AppLaunch{
  static final AppLaunch _instance = AppLaunch();

  static AppLaunch getInstance(){
    return _instance;
  }

  openApp()async{
    try {
      bool isInstalled = await DeviceApps.isAppInstalled('com.example.call_status_recording_project');
      if (isInstalled) {
        DeviceApps.openApp("com.example.call_status_recording_project");
      } else {
      print("Not Found");
      }
    } catch (e) {
      print(e);
    }
  }
}