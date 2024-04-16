import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner_generator/generator.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  String? _scannedResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Scan QR',
          style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRGenerator()),
              );
            },
            icon: const Icon(Icons.qr_code),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Center(
              child: SizedBox(
                height: 300, // Adjust the height as needed
                width: 300, // Take full width
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.noDuplicates,
                    returnImage: true,
                  ),
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;
                    for (final barcode in barcodes) {
                      print('Barcode Found! ${barcode.rawValue}');
                      setState(() {
                        _scannedResult = barcode.rawValue;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Scanned Result: $_scannedResult'),
                        ),
                      );
                      if (barcode.type == BarcodeType.url) {
                        _launchURL(barcode.rawValue!);
                      }
                    }
                    if (image != null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('QR Code Scanned'),
                            content: Image(
                              image: MemoryImage(image),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 30,),
            const Row(
                children: <Widget>[
                  Expanded(
                      child: Divider()
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("OR"),
                  ),

                  Expanded(
                      child: Divider()
                  ),
                ]
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QRGenerator()),
                );
              },
              child: const Text('Generate QR',style: TextStyle(fontWeight: FontWeight.w800),),
            ),
          ],
        ),
      ),
    );
  }

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
