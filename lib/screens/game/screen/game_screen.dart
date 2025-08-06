import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../widgets/countdown_panel.dart';
import '../widgets/history_table.dart';
import '../widgets/number_buttons_grid.dart';
import '../widgets/top_header.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: const TopHeader(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TabBar(
                labelColor: AppColors.primaryRed,
                unselectedLabelColor: Colors.black54,
                indicatorColor: AppColors.primaryRed,
                tabs: [
                  Tab(text: 'Bcone'),
                  Tab(text: 'Parity'),
                ],
              ),
              SizedBox(
                // Define a height for the TabBarView content
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [
                    // Bcone Tab Content
                    _buildGamePage(),
                    // Parity Tab Content (can be another widget)
                    const Center(child: Text('Parity Page Content')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGamePage() {
    return const Column(
      children: [
        CountdownPanel(),
        Divider(),
        NumberButtonsGrid(),
        SizedBox(height: 20),
        HistoryTable(),
      ],
    );
  }
}
