class Withdrawal {
  final String transactionId;
  final double amount;
  final String date;
  final String status;
  final String paymentMethod;

  Withdrawal({
    required this.transactionId,
    required this.amount,
    required this.date,
    required this.status,
    required this.paymentMethod,
  });
}