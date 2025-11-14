import 'dart:io';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Widget productImage;

    if (product["image"].toString().startsWith("/")) {
      productImage = Image.file(File(product["image"]),
          width: double.infinity, height: 250, fit: BoxFit.cover);
    } else {
      productImage = Image.asset(product["image"],
          width: double.infinity, height: 250, fit: BoxFit.cover);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product["name"]),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productImage,
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product["name"],
                      style:
                          const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  Text("SKU: ${product["sku"]}",
                      style: const TextStyle(fontSize: 16)),
                  Text("Category: ${product["category"]}",
                      style: const TextStyle(fontSize: 16)),
                  Text("Stock: ${product["stock"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: product["stock"] <= 5 ? Colors.red : Colors.green,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
