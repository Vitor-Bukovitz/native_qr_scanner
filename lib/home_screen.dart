import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform =
      const MethodChannel('com.app.native_qr_scanner/readQR');

  String _qrCodeResult = '';

  Future<void> _scanQr() async {
    try {
      _qrCodeResult = await platform.invokeMethod('readQR');
    } on PlatformException catch (e) {
      _qrCodeResult = 'Failed to get QR Code Result: "${e.message}".';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'QR Code Scanner',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 200,
                ),
                RaisedButton(
                  elevation: 10,
                  color: Color(0xff00d663),
                  child: Text(
                    'Ler QRCode',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: _scanQr,
                ),
                _qrCodeResult != null
                    ? Column(
                        children: [
                          Text(
                            'Resultado:\n',
                          ),
                          Text(
                            _qrCodeResult,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
