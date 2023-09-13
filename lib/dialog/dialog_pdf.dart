import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:create_pdf_new/dialog/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pwImage;
import 'package:path_provider/path_provider.dart';

class DialogToPdfPage extends StatefulWidget {
  const DialogToPdfPage({super.key});

  @override
  _DialogToPdfPageState createState() => _DialogToPdfPageState();
}

class _DialogToPdfPageState extends State<DialogToPdfPage> {
  GlobalKey globalKey = GlobalKey();
  String newText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog to PDF as Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  newText = 'NEW';
                });
                final image = await captureImage(globalKey);
                const fileName = 'dialog_image.png';
                final imagePath = await saveImageAsFile(image, fileName);
                final pdfPath = await createPdf(imagePath, fileName);
                await saveAndLaunchFile(pdfPath);
              },
              child: const Text('Capture Dialog to Image'),
            ),
            RepaintBoundary(
              key: globalKey,
              child: Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: BodyWidget(
                    nidNumber: newText,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> captureImage(GlobalKey globalKey) async {
    RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final uint8List = byteData!.buffer.asUint8List();
    return uint8List;
  }

  Future<String> saveImageAsFile(Uint8List imageBytes, String fileName) async {
    final directory = await getExternalStorageDirectory();
    final path = '${directory!.path}/$fileName';
    final file = File(path);
    await file.writeAsBytes(imageBytes, flush: true);
    return path;
  }

  Future<String> createPdf(String imagePath, String pdfFileName) async {
    final pdf = pw.Document();
    final imageBytes = File(imagePath).readAsBytesSync();
    final pdfImage = pw.MemoryImage(imageBytes);
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pwImage.Image(pdfImage, width: 500, height: 300);
      },
    ));

    final directory = await getExternalStorageDirectory();
    final pdfPath = '${directory!.path}/$pdfFileName.pdf';
    final file = File(pdfPath);
    await file.writeAsBytes(await pdf.save());
    return pdfPath;
  }

  Future<void> saveAndLaunchFile(String filePath) async {
    await OpenFile.open(filePath);
  }
}
