import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({Key? key}) : super(key: key);

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
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.qr_code_scanner),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              TextField(
                onSubmitted: (value) {
                  setState(() {
                    qrData = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your text here to generate QR',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(onPressed: (){}, child: Text('Generate')),
              SizedBox(height: 30,),
              if (qrData.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurpleAccent.withOpacity(0.2),
                        spreadRadius: 7,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: PrettyQr(
                    typeNumber: 3,
                    size: 200,
                    data: qrData,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
