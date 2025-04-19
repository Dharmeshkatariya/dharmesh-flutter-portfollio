enum ReferralPreferenceDetailsViewType {
  referralPreference('referral-preference'),
  referralReason('referral-reason'),
  other('Other');
  final String type;
  const ReferralPreferenceDetailsViewType(this.type);

  static ReferralPreferenceDetailsViewType fromType(String type) {
    for (var value in ReferralPreferenceDetailsViewType.values) {
      if (value.type == type) {
        return value;
      }
    }
    return ReferralPreferenceDetailsViewType.other;
  }

}