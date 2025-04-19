enum RcmDetailsViewType {
  denials('denials'),
  claims('claims'),
  insuranceVerification('insurance-verification'),
  other('Other');
  final String type;
  const RcmDetailsViewType(this.type);

  static RcmDetailsViewType fromType(String type) {
    for (var value in RcmDetailsViewType.values) {
      if (value.type == type) {
        return value;
      }
    }
    return RcmDetailsViewType.other;
  }

}