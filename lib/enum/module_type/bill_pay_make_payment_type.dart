enum BillPayMakePaymentType {
  patientMakePayment('patient-make-payment'),
  providerMakePayment('manage-patient-make-payment'),
  billingHistoryMakePayment('billing-history-make-payment'),
  other('other');

  final String type;

  const BillPayMakePaymentType(this.type);

  static BillPayMakePaymentType fromType(String? type) {
    for (var value in BillPayMakePaymentType.values) {
      if (value.type == type) {
        return value;
      }
    }
    return BillPayMakePaymentType.other;
  }
}
