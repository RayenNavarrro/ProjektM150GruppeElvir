import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  const QRCode({
    Key? key,
    this.width,
    this.height,
    this.qrSize,
    required this.qrData,
    this.gapLess,
    this.qrVersion,
    this.qrPadding,
    this.qrBorderRadius,
    this.semanticsLabel,
    this.qrBackgroundColor,
    this.qrForegroundColor,
  }) : super(key: key);

  // Required by FF (NOT USED IN WIDGET)
  final double? width;
  final double? height;
  // The (square) size of the image
  final double? qrSize;
  // Text data to the encoded
  final String qrData;
  // Adds an extra pixel in size to prevent gaps (default is true).
  final bool? gapLess;
  // `QrVersions.auto` or a value between 1 and 40.
  // See http://www.qrcode.com/en/about/version.html for limitations and details.
  final int? qrVersion;
  // Padding on all sides
  final double? qrPadding;
  // Circular border radius beside the QR code
  final double? qrBorderRadius;
  // Will be used by screen readers to describe the content of the QR code.
  final String? semanticsLabel;
  // 	The background color (default is transparent).
  final Color? qrBackgroundColor;
  //	The foreground color (default is black).
  final Color? qrForegroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(qrBorderRadius ?? 0),
      child: QrImage(
        size: qrSize,
        data: qrData,
        gapless: gapLess ?? true,
        version: qrVersion ?? QrVersions.auto,
        padding: EdgeInsets.all(qrPadding ?? 10),
        semanticsLabel: semanticsLabel ?? '',
        backgroundColor: qrBackgroundColor ?? Colors.transparent,
        foregroundColor: qrForegroundColor ?? Colors.black,
      ),
    );
  }
}

class CreateQRButton extends StatelessWidget {
  const CreateQRButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: Center(
        child: SelectionArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              // Add this QRCode widget in place of the Container
              QRCode(
                qrSize: 320,
                qrData: 'https://flutterflow.io',
              ),

              Text('https://fluterflow.io'),
            ],
          ),
        ),
      ),
    );
  }
}
