import 'dart:async';

import 'package:get/get.dart';
import '../models/history_record.dart';
import '../../../utils/app_colors.dart';

class GameController extends GetxController {
  // GAME STATE
  final RxString currentPeriod = "20250806362".obs;
  final RxInt countdownSeconds = 170.obs; // 2 minutes 50 seconds
  Timer? _timer;

  // USER DATA
  final RxDouble balance = 3.35.obs;

  // HISTORY DATA
  final RxList<HistoryRecord> historyRecords = <HistoryRecord>[
    HistoryRecord(
      period: "20250806361",
      price: 44904,
      number: 7,
      resultColor: AppColors.primaryGreen,
    ),
    HistoryRecord(
      period: "20250806360",
      price: 44919,
      number: 9,
      resultColor: AppColors.primaryGreen,
    ),
    HistoryRecord(
      period: "20250806359",
      price: 44949,
      number: 9,
      resultColor: AppColors.primaryGreen,
    ),
    HistoryRecord(
      period: "20250806358",
      price: 44921,
      number: 2,
      resultColor: AppColors.primaryRed,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (countdownSeconds.value > 0) {
        countdownSeconds.value--;
      } else {
        // Reset timer and fetch new period data
        countdownSeconds.value = 180;
      }
    });
  }

  String get formattedTime {
    int minutes = countdownSeconds.value ~/ 60;
    int seconds = countdownSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
