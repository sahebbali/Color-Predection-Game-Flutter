import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';

class NumberButtonsGrid extends StatelessWidget {
  const NumberButtonsGrid({super.key});

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
    final List<Color> colors = _getColorsForNumber(number);

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor:
            Colors.transparent, // Make sure button background is transparent
        shadowColor: Colors.transparent, // Optional: remove shadow if gradient
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: colors.length == 1 ? colors.first : null,
          gradient: colors.length > 1
              ? LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.5, 0.5],
                )
              : null,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
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
