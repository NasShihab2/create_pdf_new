import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'method.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _createPDF,
          child: const Text('Create PDF'),
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    // Load the custom Bengali font
    final bengaliFont = await rootBundle.load("images/Li_Alinur_Tatsama_ANSI_V1.ttf");

    page.graphics.drawString('Welcome to PDF Succinctly!', PdfStandardFont(PdfFontFamily.helvetica, 30));

    // Convert ByteData to Uint8List
    final imageData = await _readImageData('images/Pdf_Succinctly.jpg');
    final Uint8List uint8ImageData = Uint8List.sublistView(imageData);

    page.graphics.drawImage(
        PdfBitmap(uint8ImageData), // Use the converted Uint8List
        const Rect.fromLTWH(0, 100, 440, 550));

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfTrueTypeFont(bengaliFont.buffer.asUint8List(), 30), // Use the loaded Bengali font.
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 2);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Roll No';
    header.cells[1].value = 'Name';

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '1';
    row.cells[1].value = 'আর্য';

    row = grid.rows.add();
    row.cells[0].value = '2';
    row.cells[1].value = 'জন';

    row = grid.rows.add();
    row.cells[0].value = '3';
    row.cells[1].value = 'টনি';

    grid.draw(page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = await document.save(); // Use 'await' to get the result.
    document.dispose();

    // Save and launch the PDF file
    saveAndLaunchFile(bytes, 'Application.pdf');
  }

  Future<ByteData> _readImageData(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    return data;
  }

  // Implement a function to save and launch the PDF here
  void saveAndLaunchFile(List<int> bytes, String fileName) {
    // Implement this function to save and launch the PDF file
    // For example, you can use the `path_provider` package to save the file,
    // and the `open_file` package to launch it.
  }
}
