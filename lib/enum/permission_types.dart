enum PermissionType{
  view('has_view_perm'),
  create('has_create_perm'),
  update('has_update_perm'),
  delete('has_delete_perm');

  final String param;

  const PermissionType(this.param);

}