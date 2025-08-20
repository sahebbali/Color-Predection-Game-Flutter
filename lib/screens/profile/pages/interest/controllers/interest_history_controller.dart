import 'package:get/get.dart';
import '../models/interest_history_item.dart';

class InterestHistoryController extends GetxController {
  // The master list of all transactions. This remains unchanged.
  final List<InterestHistoryItem> _allHistory = [
    InterestHistoryItem(
        amount: '+\$25.50', date: '2024-07-21', status: 'Credited'),
    InterestHistoryItem(
        amount: '+\$15.20', date: '2024-06-21', status: 'Credited'),
    InterestHistoryItem(
        amount: '+\$12.00',
        date: '2024-06-15',
        status: 'Pending'), // Added for filtering
    InterestHistoryItem(
        amount: '+\$5.00', date: '2024-05-21', status: 'Credited'),
    InterestHistoryItem(
        amount: '+\$30.10', date: '2024-04-21', status: 'Credited'),
    InterestHistoryItem(
        amount: '+\$8.50',
        date: '2024-04-10',
        status: 'Pending'), // Added for filtering
    InterestHistoryItem(
        amount: '+\$18.75', date: '2024-03-21', status: 'Credited'),
  ];

  // The list that the UI will observe. It will be updated based on the filter.
  final RxList<InterestHistoryItem> filteredHistory =
      <InterestHistoryItem>[].obs;

  // The currently selected filter.
  final RxString selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    // When the controller is initialized, the filtered list shows all items.
    filteredHistory.assignAll(_allHistory);
  }

  // Method to apply the filter.
  void changeFilter(String newFilter) {
    selectedFilter.value = newFilter;
    if (newFilter == 'All') {
      // If 'All' is selected, show all items from the master list.
      filteredHistory.assignAll(_allHistory);
    } else {
      // Filter the master list based on the status and update the UI list.
      final List<InterestHistoryItem> tempList =
          _allHistory.where((item) => item.status == newFilter).toList();
      filteredHistory.assignAll(tempList);
    }
  }
}
