import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CheckOutPage extends StatelessWidget {
  final double totalPrice;

  const CheckOutPage({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final checkoutUrl =
        'https://payment.spw.challenge/checkout?price=$totalPrice';

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: checkoutUrl,
              version: QrVersions.auto,
              size: 200.0,
            ),
            const Text(
              'Scan & Pay',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Price: \$${totalPrice.toString()}',
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
