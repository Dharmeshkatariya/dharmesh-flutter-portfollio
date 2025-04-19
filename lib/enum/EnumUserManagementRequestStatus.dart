enum EnumUserManagementRequestStatus {
  pending(1),
  approved(2),
  cancelled(3);
  final int status;
  const EnumUserManagementRequestStatus(this.status);
}
