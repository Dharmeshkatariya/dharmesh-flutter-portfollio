enum BillPayAccountType {
  personalChecking('1','Personal Checking'),
  personalSaving('2','Personal Savings'),
  businessChecking('3','Business Checking'),
  businessSaving('4','Business Savings');

  final String type;
  final String label;

  const BillPayAccountType(this.type,this.label);
}

enum PaymentPlanType {
  other('other'),
  fullPayment('Full Payment'),
  threeMonthPayment('3 Month Payment'),
  sixMonthPayment('6 Month Payment');

  final String? type;

  const PaymentPlanType(this.type);
}

enum PatientBillPayViewType {
  other('other'),
  view('View'),
  mail('Mail');

  final String? type;

  const PatientBillPayViewType(this.type);
}
