enum PatientBillStatementType {
  patientStatements('patient-statements'),
  providerManagePatient('manage-patient'),
  billingHistoryDetails('billing-history-details'),
  other('other'),
  patientBillPayDetails('patient-bill-pay-details');
  final String type;
  const PatientBillStatementType(this.type);


  static PatientBillStatementType fromType(String? type) {
    for (var value in PatientBillStatementType.values) {
      if (value.type == type) {
        return value;
      }
    }
    return PatientBillStatementType.other;
  }


}
