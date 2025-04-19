enum PolicyManagementTypes {
  active('Active'),
  inActive('Inactive'),
  drafts('Drafts'),
  auditLogs('Audit Logs');

  final String param;

  const PolicyManagementTypes(this.param);
}

enum AddNewPolicyTypes {
  manual('Manual'),
  upload('Upload');

  final String param;

  const AddNewPolicyTypes(this.param);
}