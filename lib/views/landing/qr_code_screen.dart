import 'package:flutter/material.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  Barcode? result;
  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Quét mã'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Result: ${result!.code}',
                      style: TextStyle(fontSize: 20),
                    )
                  : Text(
                      'Scan a QR code',
                      style: TextStyle(fontSize: 20),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
