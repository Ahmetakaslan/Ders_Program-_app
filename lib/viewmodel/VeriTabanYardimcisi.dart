import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
  
class VeriTabaniYardimcisi{
   static final String databaseName = "dersler.sqlite";
    static Future<Database> connectToDatabase() async {
    String pathOfDatabase = join(await getDatabasesPath(), databaseName);
    if (await databaseExists(pathOfDatabase)) {
      print("Database already exists");
    } else {
      //you missed
      ByteData byteData = await rootBundle.load("veritabani/$databaseName");
      List<int> bytes = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      await File(pathOfDatabase).writeAsBytes(bytes, flush: true);
      print("Copied");
    }
    return openDatabase(pathOfDatabase);
  }
   
}