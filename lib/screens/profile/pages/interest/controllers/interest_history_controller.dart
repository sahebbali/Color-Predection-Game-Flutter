import 'package:get/get.dart';
import '../models/interest_history_item.dart';

class InterestHistoryController extends GetxController {
  // Observable list of interest history items
  final RxList<InterestHistoryItem> interestHistory = <InterestHistoryItem>[
    InterestHistoryItem(
        amount: '+\$25.50', date: '2024-07-21', status: 'Credited'),
    InterestHistoryItem(
        amount: '+\$15.20', date: '2024-06-21', status: 'Credited'),
    InterestHistoryItem(
        amount: '+\$5.00', date: '2024-05-21', status: 'Pending'),
    InterestHistoryItem(
        amount: '+\$30.10', date: '2024-04-21', status: 'Credited'),
    InterestHistoryItem(
        amount: '+\$18.75', date: '2024-03-21', status: 'Pending'),
  ].obs;

  // Observable for the selected filter
  final RxString selectedFilter = 'All'.obs;

  // Method to change the current filter
  void changeFilter(String newFilter) {
    selectedFilter.value = newFilter;
    // In a real app, you would filter the interestHistory list based on the newFilter
  }
}
