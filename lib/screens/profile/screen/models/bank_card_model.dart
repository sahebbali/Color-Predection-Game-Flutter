class BankDetails {
  final String accountType;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String branchName;

  BankDetails({
    required this.accountType,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.branchName,
  });

  // Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'accountType': accountType,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
      'branchName': branchName,
    };
  }

  // Create object from Firebase Map
  factory BankDetails.fromMap(Map<String, dynamic> map) {
    return BankDetails(
      accountType: map['accountType'] ?? '',
      bankName: map['bankName'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
      ifscCode: map['ifscCode'] ?? '',
      branchName: map['branchName'] ?? '',
    );
  }
}
