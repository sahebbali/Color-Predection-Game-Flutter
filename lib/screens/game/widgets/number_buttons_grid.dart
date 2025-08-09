import 'package:color_predection_game/screens/game/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';

class NumberButtonsGrid extends StatelessWidget {
  const NumberButtonsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // It's better to find the controller inside the build method
    // if the widget might be rebuilt.
    final GameController gameController = Get.find<GameController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Color selection buttons
          // Wrap the Row with Obx to react to changes in disableGame
          Obx(() {
            final isGameDisabled = gameController.disableGame.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildColorButton(
                  'Join Green',
                  AppColors.primaryGreen,
                  isGameDisabled,
                  () {
                    // Add your logic for joining green
                    print('Join Green pressed');
                  },
                ),
                _buildColorButton(
                  'Join Violet',
                  AppColors.primaryViolet,
                  isGameDisabled,
                  () {
                    // Add your logic for joining violet
                    print('Join Violet pressed');
                  },
                ),
                _buildColorButton(
                  'Join Red',
                  AppColors.primaryRed,
                  isGameDisabled,
                  () {
                    // Add your logic for joining red
                    print('Join Red pressed');
                  },
                ),
              ],
            );
          }),
          const SizedBox(height: 20),
          // Number buttons
          // Wrap GridView.builder with Obx
          Obx(() {
            final isGameDisabled = gameController.disableGame.value;
            return GridView.builder(
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
                // Pass the disabled status to the button builder
                return _buildNumberButton(index, isGameDisabled, () {
                  // Add your logic for number button press
                  print('Button $index pressed');
                });
              },
            );
          }),
        ],
      ),
    );
  }

  // Updated to accept a disabled flag and an onPressed callback
  Widget _buildColorButton(
    String text,
    Color color,
    bool isDisabled,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          // Set onPressed to null if disabled
          onPressed: isDisabled ? null : onPressed,
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

  // Updated to accept a disabled flag and an onPressed callback
  Widget _buildNumberButton(
    int number,
    bool isDisabled,
    VoidCallback onPressed,
  ) {
    final List<Color> colors = _getColorsForNumber(number);
    final Color color1 = colors.isNotEmpty ? colors[0] : Colors.grey;
    final Color color2 = colors.length > 1 ? colors[1] : color1;

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
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
          child: isDisabled
              ? Container(
                  color: Colors.grey, // ✅ Gray background when disabled
                  child: Center(
                    child: Text(
                      '$number',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Stack(
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
    );
  }

  // No changes needed here
  List<Color> _getColorsForNumber(int number) {
    switch (number) {
      case 0:
        return [AppColors.primaryViolet, AppColors.primaryRed];
      case 5:
        return [AppColors.primaryViolet, AppColors.primaryGreen];
      case 1:
      case 3:
      case 7:
      case 9:
        return [AppColors.primaryGreen];
      case 2:
      case 4:
      case 6:
      case 8:
        return [AppColors.primaryRed];
      default:
        return [Colors.grey];
    }
  }
}

// No changes needed for the clipper
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
