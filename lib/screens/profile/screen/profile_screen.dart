import 'package:color_predection_game/screens/auth/login/signin_screen.dart';
import 'package:color_predection_game/screens/profile/controllers/profile_controller.dart';
import 'package:color_predection_game/screens/profile/screen/profile_options/address_screen.dart';
import 'package:color_predection_game/screens/profile/screen/profile_options/bank_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// --- The Main Profile Screen ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background for the list area
      // The body is a Column containing the header and the list
      body: Column(
        children: [
          // 1. The custom header widget from your image
          ProfileHeader(),
          // 2. An Expanded ListView to fill the remaining space
          Expanded(child: ProfileMenuList()),
        ],
      ),
    );
  }
}

// --- Custom Header Widget ---
class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    // Replicating the colors from the image
    const Color primaryPurple = Colors.purple;
    const Color buttonBlue = Color(0xFF1976D2);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        16,
        40,
        16,
        16,
      ), // Added top padding for status bar
      decoration: const BoxDecoration(color: primaryPurple),
      child: Column(
        children: [
          // Top section: Profile info and notification icon
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFF80DEEA), // Light cyan
                child: Text(
                  '9',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User: 917256073163',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'ID: 13733',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              const Spacer(), // Pushes the notification icon to the end
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Handle notification tap
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Bottom section: Balance, Commission, Interest
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoColumn('₹ 3.35', 'Balance', 'Recharge', buttonBlue,
                  profileController.recharge),
              _buildInfoColumn('₹ 0', 'Commission', 'See', buttonBlue,
                  profileController.view_commission),
              _buildInfoColumn('₹ 0', 'Interest', 'See', buttonBlue,
                  profileController.view_interest),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build each column (Balance, Commission, etc.)
  Widget _buildInfoColumn(
    String amount,
    String label,
    String buttonText,
    Color buttonColor,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 30,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Text(buttonText),
          ),
        ),
      ],
    );
  }
}

// --- The Menu List ---
class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    // const tealColor = Color(0xFF00897B);

    return ListView(
      padding: EdgeInsets.zero, // Remove default padding
      children: [
        MenuListItem(
          icon: Icons.event_available_outlined,
          title: "Sign In",
          onTap: () => Get.to(() => SignInScreen()),
        ),
        // MenuListItem(
        //   icon: Icons.list_alt_outlined,
        //   title: "Orders",
        //   onTap: () => Get.to(() => const PlaceholderScreen(title: "Orders")),
        // ),
        // MenuListItem(
        //   icon: Icons.card_giftcard_outlined,
        //   title: "Promotion",
        //   onTap: () =>
        //       Get.to(() => const PlaceholderScreen(title: "Promotion")),
        // ),
        // MenuListItem(
        //   icon: Icons.monetization_on_outlined,
        //   title: "Red Envelope",
        //   iconColor: tealColor,
        //   onTap: () =>
        //       Get.to(() => const PlaceholderScreen(title: "Red Envelope")),
        // ),
        // MenuListItem(
        //   icon: Icons.monetization_on_outlined,
        //   title: "Luck Draw",
        //   iconColor: tealColor,
        //   onTap: () =>
        //       Get.to(() => const PlaceholderScreen(title: "Luck Draw")),
        // ),
        // MenuListItem(
        //   icon: Icons.account_balance_wallet_outlined,
        //   title: "Wallet",
        //   onTap: () => Get.to(() => const PlaceholderScreen(title: "Wallet")),
        // ),
        MenuListItem(
          icon: Icons.credit_card_outlined,
          title: "Bank Card",
          onTap: () => Get.to(() => BankCardScreen()),
        ),
        MenuListItem(
          icon: Icons.location_city_outlined,
          title: "Address",
          onTap: () => Get.to(() => AddressScreen()),
        ),
        // MenuListItem(
        //   icon: Icons.shield_outlined,
        //   title: "Account Security",
        //   onTap: () =>
        //       Get.to(() => const PlaceholderScreen(title: "Account Security")),
        // ),
        MenuListItem(
          icon: Icons.download_outlined,
          title: "App Download",
          onTap: () => print("App Download tapped"),
        ),
        // MenuListItem(
        //   icon: Icons.chat_bubble_outline,
        //   title: "Complaints & Suggestions",
        //   onTap: () => Get.to(() => {}),
        //   // Add the trailing down arrow icon here
        //   trailing: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
        // ),
        MenuListItem(
          icon: Icons.logout,
          title: "Log out",
          onTap: () => Get.offAll(() => SignInScreen()),
          // Add the trailing down arrow icon here
          trailing: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

// --- Reusable Menu Item Widget (Updated with trailing icon) ---
class MenuListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Widget? trailing; // Optional trailing widget

  const MenuListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.trailing, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.grey[600]),
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[700], fontSize: 16),
      ),
      onTap: onTap,
      trailing: Icon(Icons.keyboard_arrow_down), // Use the trailing widget here
    );
  }
}
