import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';

class Storage{

  Future<String> get localPath async{
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async{
    final path = await localPath;
    return File('$path/pearltracker.txt');
  }

  Future<String> readData() async{
    try{
      File file = await localFile;
      String content = await file.readAsString();
      return content;
    }catch(e){
      return '';
    }
  }

  Future<File> writeData(List content) async{
    String contents = content.join(',');
    File file = await localFile;
    return file.writeAsString(contents,mode: FileMode.WRITE);
  }

}

