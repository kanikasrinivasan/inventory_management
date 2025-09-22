import 'package:flutter/material.dart';
import '../widgets/profile_option_tile.dart';
import 'profile_info_screen.dart';
import 'edit_profile_screen.dart';
import 'faq_screen.dart';
import 'help_support_screen.dart';
import 'delete_account_screen.dart';
import 'logout_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage("assets/profile.png"), // Replace with real image
          ),
          const SizedBox(height: 10),
          const Text("Ethan Carter", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("ethan.carter@gmail.com", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ProfileOptionTile(
                  icon: Icons.person,
                  title: "Profile Info",
                  subtitle: "User Profile",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileInfoScreen())),
                ),
                ProfileOptionTile(
                  icon: Icons.edit,
                  title: "Edit Profile",
                  subtitle: "Update your details",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileScreen())),
                ),
                ProfileOptionTile(
                  icon: Icons.question_answer,
                  title: "FAQs",
                  subtitle: "Frequently Asked Questions",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FAQScreen())),
                ),
                ProfileOptionTile(
                  icon: Icons.support_agent,
                  title: "Help & Support",
                  subtitle: "Get assistance",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HelpSupportScreen())),
                ),
                ProfileOptionTile(
                  icon: Icons.delete_forever,
                  title: "Delete Account",
                  subtitle: "Erase your data",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DeleteAccountScreen())),
                ),
                ProfileOptionTile(
                  icon: Icons.logout,
                  title: "Logout",
                  subtitle: "Sign out of your account",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LogoutScreen())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
