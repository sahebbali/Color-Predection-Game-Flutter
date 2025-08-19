import 'package:flutter/material.dart';

class CommissionScreen extends StatelessWidget {
  const CommissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'My Commissions',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                    'Total Earnings', '\$5,250.00', Icons.attach_money),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSummaryCard(
                    'Pending Payout', '\$1,200.00', Icons.pending),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Earnings Chart (Placeholder)
          const Text(
            'Earnings This Month',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Chart will be displayed here',
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Recent Commissions
          const Text(
            'Recent Commissions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildCommissionItem('John Doe', '2025-08-15', '\$50.00'),
          const Divider(),
          _buildCommissionItem('Jane Smith', '2025-08-14', '\$75.00'),
          const Divider(),
          _buildCommissionItem('Peter Jones', '2025-08-12', '\$30.00'),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Colors.purple),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommissionItem(String customer, String date, String amount) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.purple,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(customer),
      subtitle: Text(date),
      trailing: Text(
        amount,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
