import 'package:flutter/material.dart';
import 'add_product_screen.dart'; // import your AddProductScreen file

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Wireless Headphones",
      "sku": "123456",
      "category": "Electronics",
      "stock": 124,
      "image": "assets/images/headphones.jpg",
    },
    {
      "name": "Anker USB- C Cable 2m",
      "sku": "789012",
      "category": "Cable",
      "stock": 42,
      "image": "assets/images/cable.jpg",
    },
    {
      "name": "Leather Wallet",
      "sku": "345678",
      "category": "Accessories",
      "stock": 2,
      "image": "assets/images/wallet.jpg",
    },
    {
      "name": "Smartwatch",
      "sku": "901234",
      "category": "Electronics",
      "stock": 124,
      "image": "assets/images/smartwatch.jpg",
    },
    {
      "name": "Samsung T7 Portable SSD 1TB",
      "sku": "761234",
      "category": "Storage",
      "stock": 2,
      "image": "assets/images/ssd.jpg",
    },
    {
      "name": "Google Nest Hub 2nd Gen",
      "sku": "642434",
      "category": "Smart Home",
      "stock": 124,
      "image": "assets/images/nesthub.jpg",
    },
  ];

  Future<void> _navigateToAddProduct() async {
    final newProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddProductScreen()),
    );

    if (newProduct != null) {
      setState(() {
        products.add(newProduct);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddProduct, // ➕ Add Product Button
          )
        ],
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search products",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),

          // 📦 Product List
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      product["image"],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    product["name"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "SKU: ${product["sku"]} | Category: ${product["category"]}",
                  ),
                  trailing: Text(
                    "Stock: ${product["stock"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: (product["stock"] <= 5)
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
