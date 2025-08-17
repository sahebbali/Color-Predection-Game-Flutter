import 'package:get/get.dart';

class Bet {
  final int id;
  final RxDouble betAmount = 0.0.obs;
  final RxString selectedTeam = ''.obs;
  final RxString resultMessage = ''.obs;

  Bet({required this.id});
}