import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF7B1FA2); // Deep Purple

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7B1FA2), Color(0xFF9C27B0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Spacer(),
                    const Icon(Icons.account_balance_wallet,
                        color: Colors.white),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "PKR389.00",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Total balance",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),

                // Wallet Progress Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _walletProgress(
                        percent: 1.0,
                        amount: "PKR389.00",
                        label: "Main wallet",
                        color: Colors.white),
                    const SizedBox(width: 40),
                    _walletProgress(
                        percent: 0.0,
                        amount: "PKR0.00",
                        label: "3rd party wallet",
                        color: Colors.white70),
                  ],
                ),

                const SizedBox(height: 20),

                // Main wallet transfer button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Main wallet transfer",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Action Buttons
          SizedBox(
            height: 100,
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _actionButton(Icons.add_circle_outline, "Deposit", purple),
                _actionButton(Icons.remove_circle_outline, "Withdraw", purple),
                _actionButton(Icons.history, "Deposit history", purple),
                _actionButton(Icons.receipt_long, "Withdrawal history", purple),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Game Balances Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(12),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _gameTile("389.00", "Lottery", purple, isActive: true),
                _gameTile("0.00", "TB_Chess", purple),
                _gameTile("0.00", "Wickets9", purple),
                _gameTile("0.00", "CQ9", purple),
                _gameTile("0.00", "MG", purple),
                _gameTile("0.00", "JDB", purple),
                _gameTile("0.00", "DG", purple),
                _gameTile("0.00", "CMD", purple),
                _gameTile("0.00", "SaBa", purple),
                _gameTile("0.00", "EVO_Video", purple),
                _gameTile("0.00", "JILI", purple),
                _gameTile("0.00", "Card365", purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Wallet Progress Widget
  static Widget _walletProgress({
    required double percent,
    required String amount,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: percent,
                strokeWidth: 6,
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
            Text(
              "${(percent * 100).toStringAsFixed(0)}%",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(amount,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  // Action Button Widget
  static Widget _actionButton(IconData icon, String label, Color purple) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: purple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 28, color: purple),
        ),
        const SizedBox(height: 6),
        Text(label,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // Game Tile Widget
  static Widget _gameTile(String amount, String title, Color purple,
      {bool isActive = false}) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? purple : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            amount,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
