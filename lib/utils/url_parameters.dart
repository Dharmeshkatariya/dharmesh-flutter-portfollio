import '../api/request_and_response_params.dart';

class UrlParams{
  static Map<String, String> dashboardParams = {
    // ConstantsFile.subPage:Routes().dashboard
  };
  static Map<String, String> appointmentParams = {
    // ConstantsFile.subPage:Routes().manageAppointments
  };
  static Map<String, String> referralsParam = {
    RequestAndResponseParams.pageNumber:'1',
    RequestAndResponseParams.pageSize:'10',
    RequestAndResponseParams.search:'',
    RequestAndResponseParams.patientFFirstName:'',
    RequestAndResponseParams.patientPatientId:'',
    RequestAndResponseParams.referredFromProviderFirstName:'',
    RequestAndResponseParams.referredToProviderFirstName:'',
    RequestAndResponseParams.ordering:'',
  };
  static Map<String, String> scheduling = {
    // ConstantsFile.subPage:Routes().manageSchedules
  };
  static Map<String, String> healthCEnterParams = {
    RequestAndResponseParams.search:'',
    RequestAndResponseParams.pageNumber:'1',
    RequestAndResponseParams.pageSize:'10',
  };
  static Map<String, String> practicesParams = {
    // ConstantsFile.subPage:Routes().managePractices,
    RequestAndResponseParams.type:'',
    RequestAndResponseParams.pageNumber:'1',
    RequestAndResponseParams.pageSize:'10',
    RequestAndResponseParams.ordering:RequestAndResponseParams.name,
    RequestAndResponseParams.name:'',
    RequestAndResponseParams.city:'',
    RequestAndResponseParams.state:'',
    RequestAndResponseParams.zipCode:'',
    RequestAndResponseParams.search:'',
    RequestAndResponseParams.specialities:'',
  };
  static Map<String, String> practiceStaffParams = {
    // ConstantsFile.subPage:Routes().managePracticeStaff,
    RequestAndResponseParams.isAdmin: RequestAndResponseParams.zero,
    // RequestAndResponseParams.type:'',
    // RequestAndResponseParams.pageNumber:'1',
    // RequestAndResponseParams.pageSize:'10',
    // RequestAndResponseParams.npi:'',
    // RequestAndResponseParams.userFirstName:'',
    // RequestAndResponseParams.userLastName:'',
    // RequestAndResponseParams.userCity:'',
    // RequestAndResponseParams.userState:'',
    // RequestAndResponseParams.userZipCode:'',
    // RequestAndResponseParams.specialities:'',
    // RequestAndResponseParams.search:'',
  };
  static Map<String, String> insurancesParams = {
    // ConstantsFile.subPage:Routes().managePatients
  };
  static Map<String, String> patientsParams = {
    // ConstantsFile.subPage:Routes().managePatients
  };
  static Map<String, String> patientsChartParams = {
    // ConstantsFile.subPage:Routes().managePatients
  };
  static Map<String, String> reviewParams = {
    // ConstantsFile.subPage:Routes().manageReviews
  };
  static Map<String, String> taskParams = {
    // ConstantsFile.subPage:Routes().manageTasks
  };
  static Map<String, String> userManagementParams = {
    RequestAndResponseParams.isAdmin: RequestAndResponseParams.one,
  };
  static Map<String, String> rolesManagementParams = {
    // ConstantsFile.subPage:Routes().roleManagement
  };
  static Map<String, String> accessManagementParams = {
    // ConstantsFile.subPage:Routes().accessManagement
  };
  static Map<String, String> dataManagement = {
    // ConstantsFile.subPage:Routes().dataManagement
  };
  static Map<String, String> notificationParams = {
    // ConstantsFile.subPage:Routes().notificationsView
  };
  static Map<String, String> providerInsuranceParams = {};
  static Map<String, String> settingsParams = {
    // ConstantsFile.subPage:Routes().accountSettings
  };
  static Map<String, String> visitTypes = {
    // ConstantsFile.subPage:Routes().visitType
  };
  static Map<String, String> referralPreferences = {
    // ConstantsFile.subPage:Routes().referralPreferencesView
  };
  static Map<String, String> doctorListingPageParameters = {
    RequestAndResponseParams.pageNumber: '',
    RequestAndResponseParams.latitude: '',
    RequestAndResponseParams.longitude: '',
    RequestAndResponseParams.disease: '',
    RequestAndResponseParams.provider: '',
    RequestAndResponseParams.condition: '',
    RequestAndResponseParams.procedures: '',
    RequestAndResponseParams.symptoms: '',
    RequestAndResponseParams.speciality: '',
    RequestAndResponseParams.ageCode:'',
    RequestAndResponseParams.providesTelehealth:'false',
    RequestAndResponseParams.acceptsNewPatient:'false',
    RequestAndResponseParams.boundaryRange:'',
    RequestAndResponseParams.search:'',
  };

  static Map<String, String> healthCenterCustomer = {
    // ConstantsFile.subPage:Routes().manageSchedules
  };
  static Map<String, String> invoice = {
    // ConstantsFile.subPage:Routes().manageSchedules
  };
}