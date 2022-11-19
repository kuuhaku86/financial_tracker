class AddTransaction {
  int transactionTypeId;
  int sourceId;
  String explanation;
  double amount;

  AddTransaction(
      {required this.transactionTypeId,
      required this.sourceId,
      required this.explanation,
      required this.amount});
}
