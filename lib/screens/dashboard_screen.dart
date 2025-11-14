import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'alerts_screen.dart';
import 'add_product_screen.dart';
import 'profile_screen.dart';
import 'products_screen.dart';      // ✅ IMPORTANT

import '../models/product_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productBox = Hive.box('products');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Inventory",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: ValueListenableBuilder(
        valueListenable: productBox.listenable(),
        builder: (context, box, _) {
          
          int totalProducts = box.length;
          int lowStock = 0;
          int outOfStock = 0;
          int inStock = 0;

          for (int i = 0; i < box.length; i++) {
            final data = box.getAt(i);
            final product = ProductModel.fromMap(data);

            if (product.stock == 0) {
              outOfStock++;
            } else if (product.stock < 5) {
              lowStock++;
            } else {
              inStock++;
            }
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const Text(
                  "Alerts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Low Stock",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(
                            "$lowStock items",
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AlertsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: const Text("View"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard("Total Products", "$totalProducts"),
                    _buildStatCard("In Stock", "$inStock"),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard("Low Stock", "$lowStock"),
                    _buildStatCard("Out of Stock", "$outOfStock"),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  "Recent Activity",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                _buildActivityTile(Icons.arrow_upward, "Restocked",
                    "Apple airtags", "100 units", Colors.green),
                _buildActivityTile(Icons.arrow_downward, "Adjusted",
                    "Logitech MX keys", "50 units", Colors.orange),
              ],
            ),
          );
        },
      ),

      // -----------------------------------------------------
      // ✅ FIXED BOTTOM NAVIGATION BAR
      // -----------------------------------------------------
      bottomNavigationBar: BottomNavigationBar(
  currentIndex: 0,
  selectedItemColor: Colors.teal,
  unselectedItemColor: Colors.black54,
  type: BottomNavigationBarType.fixed,
  onTap: (index) {
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductsScreen()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductScreen()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
    }
  },
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
    BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: "Products"),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ],
),

    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityTile(
      IconData icon, String action, String product, String qty, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: "$action: ",
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            TextSpan(text: product),
          ],
        ),
      ),
      subtitle: Text(qty),
    );
  }
}
