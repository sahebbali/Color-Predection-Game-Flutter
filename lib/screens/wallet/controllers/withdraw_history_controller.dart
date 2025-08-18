import 'package:get/get.dart';
import '../models/withdrawal_model.dart';

class WithdrawHistoryController extends GetxController {
  // A reactive list that will automatically update the UI when its contents change.
  final RxList<Withdrawal> withdrawalHistory = <Withdrawal>[].obs;

  // A reactive boolean to show a loading indicator.
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWithdrawalHistory(); // Load data when the controller is ready.
  }

  // This method simulates fetching data from a server.
  void fetchWithdrawalHistory() async {
    isLoading.value = true;
    // Simulate a network delay of 1.5 seconds.
    await Future.delayed(const Duration(milliseconds: 1500));

    // This is your dummy data.
    var dummyData = [
      Withdrawal(
        transactionId: "WID-84321",
        amount: 150.00,
        date: "15 Aug, 2025",
        status: "Completed",
        paymentMethod: "Bank Transfer",
      ),
      Withdrawal(
        transactionId: "WID-84199",
        amount: 75.50,
        date: "12 Aug, 2025",
        status: "Pending",
        paymentMethod: "PayPal",
      ),
      Withdrawal(
        transactionId: "WID-83987",
        amount: 220.00,
        date: "10 Aug, 2025",
        status: "Failed",
        paymentMethod: "Bank Transfer",
      ),
      Withdrawal(
        transactionId: "WID-83912",
        amount: 50.25,
        date: "08 Aug, 2025",
        status: "Completed",
        paymentMethod: "Stripe",
      ),
      Withdrawal(
        transactionId: "WID-83850",
        amount: 300.00,
        date: "05 Aug, 2025",
        status: "Completed",
        paymentMethod: "Bank Transfer",
      ),
    ];

    // Update the list with the fetched data.
    withdrawalHistory.assignAll(dummyData);
    isLoading.value = false;
  }
}