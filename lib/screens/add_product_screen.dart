import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'draft_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String? selectedCategory;
  File? _pickedImage;

  // store drafts (frontend only)
  static final List<Map<String, dynamic>> _drafts = [];

  final List<String> categories = [
    "Electronics",
    "Clothing",
    "Accessories",
    "Storage",
    "Smart Home"
  ];

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

  void _saveAsDraft() {
    final draftProduct = {
      "name": nameController.text.isEmpty
          ? "Unnamed Product"
          : nameController.text,
      "sku": DateTime.now().millisecondsSinceEpoch.toString(),
      "category": selectedCategory ?? "Uncategorized",
      "stock": 124,
      "image": _pickedImage?.path,
      "notes": notesController.text,
      "cost": costController.text,
      "mrp": mrpController.text,
    };

    _drafts.add(draftProduct);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DraftScreen(drafts: _drafts),
      ),
    );
  }

  void _addProduct() {
    if (nameController.text.isEmpty ||
        costController.text.isEmpty ||
        mrpController.text.isEmpty ||
        selectedCategory == null ||
        _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    final newProduct = {
      "name": nameController.text,
      "sku": DateTime.now().millisecondsSinceEpoch.toString(),
      "category": selectedCategory!,
      "stock": 10,
      "image": _pickedImage!.path,
      "notes": notesController.text,
      "cost": costController.text,
      "mrp": mrpController.text,
    };

    Navigator.pop(context, newProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product",
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _pickedImage == null
                    ? const Center(
                        child: Icon(Icons.add, size: 40, color: Colors.black54),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _pickedImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Product Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            const Text("Enter the product information below",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 16),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Product Name",
                hintText: "Enter product name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: costController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Cost",
                      prefixText: "₹",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: mrpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "MRP",
                      prefixText: "₹",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories
                  .map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Notes (optional)",
                hintText: "Notes",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: _saveAsDraft,
                    child: const Text("Save as Draft"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: _addProduct,
                    child: const Text("Add Product"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined), label: "Products"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
        onTap: (index) {
          // TODO: Navigate to respective screens
        },
      ),
    );
  }
}
