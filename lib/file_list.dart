import 'dart:io';
import 'package:call_status_recording_project/custom_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class FileList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FileListState(); //create state
  }
}

class FileListState extends State<FileList> {
  var files;

  void getFiles() async { //asyn function to get list of files
    Directory? downloadsDir = await getDownloadsDirectory();
    var fm = downloadsDir!.listSync();
    files = fm.where((element) => element is File).toList();
    setState(() {}); //update the UI
  }

  @override
  void initState() {
    getFiles(); //call getFiles () function on initial state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File list from Downloads Directory"),
      ),
      body: files == null ? Text("Searching Files") : ListView.builder(
        itemCount: files?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(files[index].path.split('/').last),
              leading: Icon(Icons.file_copy),
              trailing: Icon(Icons.play_arrow, color: Colors.blueAccent,),
              onTap: (){
                CustomAudioPlayer(filePath:files[index].path);
              },
            ),
          );
        },
      ),
    );
  }
}