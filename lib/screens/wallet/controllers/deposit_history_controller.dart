import 'package:get/get.dart';

class DepositHistoryController extends GetxController {
  var deposits = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    deposits.value = [
      {
        "transactionId": "TXN123456",
        "amount": 500,
        "date": "2025-08-18",
        "status": "Pending",
        "proof": "https://via.placeholder.com/150"
      },
      {
        "transactionId": "TXN654321",
        "amount": 1000,
        "date": "2025-08-15",
        "status": "Approved",
        "proof": "https://via.placeholder.com/150"
      },
      {
        "transactionId": "TXN987654",
        "amount": 750,
        "date": "2025-08-10",
        "status": "Rejected",
        "proof": "https://via.placeholder.com/150"
      },
    ];
  }
}
