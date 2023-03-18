import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;

class FileHelper {
  static Future<void> shareFile({required List<String> files, String? subject, String? text}) async {
    List<XFile> xFiles = [];
    String directory;
    if(Platform.isAndroid){
      directory =  await const MethodChannel('game.onechain.ai_ecard.module/utility').invokeMethod('downloadDirectory');
    } else {
      directory =  (await getApplicationDocumentsDirectory()).path;
    }
    for (int i = 0; i < files.length; i++) {
      xFiles.add(XFile('$directory/${files[i]}'));
    }
    await Share.shareXFiles(xFiles, subject: subject, text: text);
  }

  static Future<void> saveFileToStorage(String fileName, Uint8List file) async {
    String directory;
    if(Platform.isAndroid){
      directory = await const MethodChannel('game.onechain.ai_ecard.module/utility').invokeMethod('downloadDirectory');
    } else {
      directory =  (await getApplicationDocumentsDirectory()).path;
    }
    String filePath = '$directory/$fileName';
    File fileWriter = File(filePath);
    await fileWriter.writeAsBytes(file);
  }

  static Future<void> saveFileToGallery(String fileName, String? albumName, Uint8List file) async {
    await saveFileToStorage(fileName, file);
    String directory;
    if(Platform.isAndroid){
      directory = await const MethodChannel('game.onechain.ai_ecard.module/utility').invokeMethod('downloadDirectory');
    } else {
      directory =  (await getApplicationDocumentsDirectory()).path;
    }
    String filePath = '$directory/$fileName';

    if (await File(filePath).exists()) {
      await GallerySaver.saveImage(filePath, albumName: albumName ?? 'AI-Ecard');
    }
  }

  static Future<Uint8List> createImage(Widget image) async {
    ScreenshotController controller = ScreenshotController();
    Uint8List file = await controller.captureFromWidget(image);
    return file;
  }

  static Future<Uint8List> createPDF(List<Widget> image) async {
    final pdf = pw.Document();
    for (int i = 0; i < image.length; i++) {
      Uint8List file = await createImage(image[i]);
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(pw.MemoryImage(file), fit: pw.BoxFit.contain),
        );
      }));
    }
    return await pdf.save();
  }
}
