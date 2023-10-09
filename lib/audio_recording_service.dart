import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class AudioRecoringService {
  static final AudioRecoringService _instance = AudioRecoringService();

  final record = Record();

  static AudioRecoringService getInstance() {
    return _instance;
  }

  Future<String> getAudioPath() async{
    final directory = await getDownloadsDirectory();
    return directory!.path;
  }

  String? currentRecordingPath;

  Future<String?> startRecording() async {
    // if(await record.isRecording()){
    //   return currentRecordingPath;
    // }
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    currentRecordingPath = '${await getAudioPath()}/REM_TEST_$timeStamp.mp3';
// Check and request permission
    if (await record.hasPermission()) {
      // Start recording             
      await record.start(
        path: currentRecordingPath
      );
    }
    return currentRecordingPath;
  }

  stopRecording() async {
    await record.stop();
  }
}
