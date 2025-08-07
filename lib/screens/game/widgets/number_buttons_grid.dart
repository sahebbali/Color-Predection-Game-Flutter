import 'package:color_predection_game/screens/game/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';

class NumberButtonsGrid extends StatelessWidget {
  const NumberButtonsGrid({super.key});
  // final GameController gameController = Get.find<GameController>();
  // print("gameController: ${gameController.formattedTime}");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Color selection buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildColorButton('Join Green', AppColors.primaryGreen),
              _buildColorButton('Join Violet', AppColors.primaryViolet),
              _buildColorButton('Join Red', AppColors.primaryRed),
            ],
          ),
          const SizedBox(height: 20),
          // Number buttons
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildNumberButton(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    final GameController gameController = Get.find<GameController>();
    final List<Color> colors = _getColorsForNumber(number);

    final Color color1 = colors.length > 1 ? colors[0] : colors[0];
    final Color color2 = colors.length > 1 ? colors[1] : colors[0];

    return Obx(
      () => ElevatedButton(
        onPressed: gameController.disableGame.value
            ? (){print('Game is disabled')}
            : () {
                // Button logic when enabled
                print('Button $number pressed');
              },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 50,
            width: 80,
            child: Stack(
              children: [
                ClipPath(
                  clipper: DiagonalClipper(),
                  child: Container(color: color1),
                ),
                ClipPath(
                  clipper: DiagonalClipper(reverse: true),
                  child: Container(color: color2),
                ),
                Center(
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getColorsForNumber(int number) {
    switch (number) {
      case 0:
        return [AppColors.primaryViolet, AppColors.primaryRed];
      case 5:
        return [AppColors.primaryViolet, AppColors.primaryGreen];
      case 1:
        return [AppColors.primaryGreen];
      case 3:
        return [AppColors.primaryGreen];
      case 7:
        return [AppColors.primaryGreen];
      case 9:
        return [AppColors.primaryGreen];
      case 2:
        return [AppColors.primaryRed];
      case 4:
        return [AppColors.primaryRed];
      case 6:
        return [AppColors.primaryRed];
      case 8:
        return [AppColors.primaryRed];
      default:
        return [Colors.grey];
    }
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  final bool reverse;

  DiagonalClipper({this.reverse = false});

  @override
  Path getClip(Size size) {
    Path path = Path();

    if (reverse) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(0, size.height);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
