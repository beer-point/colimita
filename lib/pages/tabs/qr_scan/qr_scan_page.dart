import 'package:colimita/callables.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

import 'loading_overlay.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  Barcode? result;
  QRViewController? controller;
  bool syncing = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    void handleClose() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          if (syncing) LoadingOverlay(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: handleClose,
                      icon: const Icon(Icons.close),
                      iconSize: 32,
                      color: Colors.white,
                    ),
                  ],
                ),
                Text(
                  '¡Escanea el codigo QR!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated(context),
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 5,
        cutOutSize: scanArea,
      ),
    );
  }

  void Function(QRViewController) _onQRViewCreated(BuildContext context) =>
      (QRViewController controller) async {
        setState(() {
          this.controller = controller;
        });

        final scannedData = await controller.scannedDataStream.first;
        Vibration.vibrate(duration: 50);
        try {
          setState(() {
            syncing = true;
          });
          controller.pauseCamera();

          await syncWithStation(
            {"code": scannedData.code, "stationId": 'B1UNaOTznfzZXgxxUTnc'},
          );

          controller.resumeCamera();
          setState(() {
            syncing = false;
          });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text('Codigo invalido'),
            ),
          );
        }
        Navigator.pop(context);
      };

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
