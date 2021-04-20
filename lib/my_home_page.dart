import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var result = "...";

  startScan() async {
    var colorCode = '';
    var cancelButtonText = '';
    var isShowFlashIcon = false;
    var scanMode = ScanMode.DEFAULT;

    var scanResult = await FlutterBarcodeScanner.scanBarcode(
        colorCode, cancelButtonText, isShowFlashIcon, scanMode);

    if (scanResult != '-1') {
      setState(
        () {
          result = scanResult;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter BarCode Scanner"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            child: Text(result),
          ),
          ElevatedButton(
              onPressed: () async {
                if (await canLaunch(result)) {
                  await launch(result);
                }
              },
              child: Text('luanch'))
        ],
      ),
      floatingActionButton: Container(
        height: 50,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          onPressed: () {
            startScan();
          },
          icon: Icon(Icons.qr_code_outlined),
          label: Text('Scan'),
        ),
      ),
    );
  }
}
