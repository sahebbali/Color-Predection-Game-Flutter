import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../pages/poll_page.dart';
import '../pages/number_league_page.dart';
import '../pages/color_prediction_page.dart';
import '../pages/betting_game_page.dart';

class GameCategoryGrid extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'poll':
        return Icons.poll;
      case 'confirmation_num':
        return Icons.confirmation_num;
      case 'color_lens':
        return Icons.color_lens;
      case 'sports_soccer':
        return Icons.sports_soccer;
      default:
        return Icons.gamepad;
    }
  }

  void _navigateToPage(String gameName) {
    switch (gameName) {
      case 'Poll Game':
        Get.to(() => const PollPage());
        break;
      case 'Number League':
        Get.to(() => const NumberLeaguePage());
        break;
      case 'Color Prediction':
        Get.to(() => const ColorPredictionPage());
        break;
      case 'Betting Game':
        Get.to(() => const BettingGamePage());
        break;
      default:
        Get.snackbar("Error", "Page not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: controller.games.length,
      itemBuilder: (context, index) {
        final game = controller.games[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _navigateToPage(game['title']),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_getIcon(game['icon']), size: 40, color: Colors.purple),
                const SizedBox(height: 10),
                Text(
                  game['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
