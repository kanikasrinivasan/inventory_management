import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/product_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productBox = Hive.box('products');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),

      body: ValueListenableBuilder(
        valueListenable: productBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                "No products available",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final data = box.getAt(index);
              final product =
                  ProductModel.fromMap(Map<String, dynamic>.from(data));

              // COLOR ALERTS
              Color stockColor = Colors.green;
              if (product.stock == 0) {
                stockColor = Colors.red;
              } else if (product.stock < 5) {
                stockColor = Colors.orange;
              }

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text("Stock: ${product.stock}"),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("₹ ${product.price}"),
                      const SizedBox(height: 6),
                      Text(
                        product.stock == 0
                            ? "OUT OF STOCK"
                            : product.stock < 5
                                ? "LOW STOCK"
                                : "IN STOCK",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: stockColor,
                        ),
                      ),
                    ],
                  ),

                  // EDIT & DELETE MENU
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.edit),
                                title: const Text("Edit Product"),
                                onTap: () {
                                  Navigator.pop(context);
                                  _editProduct(context, product, index);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.delete, color: Colors.red),
                                title: const Text("Delete Product"),
                                onTap: () {
                                  productBox.deleteAt(index);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  // EDIT PRODUCT FUNCTION
  void _editProduct(BuildContext context, ProductModel product, int index) {
    final nameController = TextEditingController(text: product.name);
    final stockController = TextEditingController(text: product.stock.toString());
    final priceController = TextEditingController(text: product.price.toString());

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Product Name")),
              TextField(controller: stockController, decoration: const InputDecoration(labelText: "Stock"), keyboardType: TextInputType.number),
              TextField(controller: priceController, decoration: const InputDecoration(labelText: "Price"), keyboardType: TextInputType.number),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final updated = ProductModel(
                  name: nameController.text,
                  stock: int.tryParse(stockController.text) ?? 0,
                  price: double.tryParse(priceController.text) ?? 0.0,
                );

                Hive.box('products').putAt(index, updated.toMap());
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
