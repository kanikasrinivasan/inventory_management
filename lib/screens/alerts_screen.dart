import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Alerts",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),

        // 🔹 3-dot popup menu
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "mark_read") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All alerts marked as read")),
                );
              } else if (value == "delete") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All alerts deleted")),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "mark_read",
                child: Text("Mark all as read"),
              ),
              const PopupMenuItem(
                value: "delete",
                child: Text("Delete"),
              ),
            ],
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAlertTile("Low Stock", "10 items remaining", Colors.orange),
          _buildAlertTile("Out of Stock", "5 items out", Colors.red),
          _buildAlertTile("Restocked", "20 items added", Colors.green),
        ],
      ),
    );
  }

  // 🔹 Helper widget for alerts
  Widget _buildAlertTile(String title, String subtitle, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(Icons.notifications, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}