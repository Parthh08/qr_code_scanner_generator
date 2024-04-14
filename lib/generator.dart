import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({super.key});

  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  String qrData = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Generate your QR'),
          actions: [
            IconButton(onPressed: () {
              Navigator.popAndPushNamed(context, "/sacn");
            }, icon: Icon(Icons.qr_code_scanner))
          ],
        ),
        body: Padding(padding: EdgeInsets.all(10),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(onSubmitted: (value){
                  setState(() {
                    qrData = value;
                  });
                },),
                if(qrData!=null)
                  PrettyQrView.data(data: qrData!),
              ],
          ),
        )
    );
  }
}
