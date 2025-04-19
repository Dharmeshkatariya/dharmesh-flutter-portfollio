
class SystemSettingModel {
  final bool? status;
  final SystemSettingData? data;

  SystemSettingModel({
    this.status,
    this.data,
  });

  factory SystemSettingModel.fromJson(Map<String, dynamic> json) {
    return SystemSettingModel(
      status: json['status'],
      data: json['data'] != null ? SystemSettingData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class SystemSettingData {
  final String? id;
  final LogoDetails? logoDetails;
  final FaviconDetails? faviconDetails;
  final String? createdOn;
  final String? updatedOn;
  final int? version;
  final String? address;
  final String? address1;
  final String? city;
  final String? state;
  final String? zipcode;
  final String? country;
  final String? contactPrefix;
  final String? contactFirstName;
  final String? contactMiddleName;
  final String? contactLastName;
  final String? contactSuffix;
  final String? name;
  final String? brandColor;
  final String? slogan;
  final String? description;
  final int? appConfType;
  final bool? allowExtProviders;
  final String? url;
  final int? maxSecurityQuestion;
  final int? code;
  final String? website;
  final String? workCountryCode;
  final String? workPhone;
  final String? phoneCountryCode;
  final String? phone;
  final String? faxCountryCode;
  final String? fax;
  final String? email;
  final String? preferredCommunicationMode;
  final String? status;
  final String? groupNpi;
  final int? maxAgeOfMinor;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;

  SystemSettingData({
    this.id,
    this.logoDetails,
    this.faviconDetails,
    this.createdOn,
    this.updatedOn,
    this.version,
    this.address,
    this.address1,
    this.city,
    this.state,
    this.zipcode,
    this.country,
    this.contactPrefix,
    this.contactFirstName,
    this.contactMiddleName,
    this.contactLastName,
    this.contactSuffix,
    this.name,
    this.brandColor,
    this.slogan,
    this.description,
    this.appConfType,
    this.allowExtProviders,
    this.url,
    this.maxSecurityQuestion,
    this.code,
    this.website,
    this.workCountryCode,
    this.workPhone,
    this.phoneCountryCode,
    this.phone,
    this.faxCountryCode,
    this.fax,
    this.email,
    this.preferredCommunicationMode,
    this.status,
    this.groupNpi,
    this.maxAgeOfMinor,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory SystemSettingData.fromJson(Map<String, dynamic> json) {
    return SystemSettingData(
      id: json['id'],
      logoDetails: json['logo_details'] != null ? LogoDetails.fromJson(json['logo_details']) : null,
      faviconDetails: json['favicon_details'] != null ? FaviconDetails.fromJson(json['favicon_details']) : null,
      createdOn: json['created_on'],
      updatedOn: json['updated_on'],
      version: json['version'],
      address: json['address'],
      address1: json['address_1'],
      city: json['city'],
      state: json['state'],
      zipcode: json['zipcode'],
      country: json['country'],
      contactPrefix: json['contact_prefix'],
      contactFirstName: json['contact_first_name'],
      contactMiddleName: json['contact_middle_name'],
      contactLastName: json['contact_last_name'],
      contactSuffix: json['contact_suffix'],
      name: json['name'],
      brandColor: json['brand_color'] ?? "",
      slogan: json['slogan'],
      description: json['description'],
      appConfType: json['app_conf_type'],
      allowExtProviders: json['allow_ext_providers'],
      url: json['url'],
      maxSecurityQuestion: json['max_security_question'],
      code: json['code'],
      website: json['website'],
      workCountryCode: json['work_country_code'],
      workPhone: json['work_phone'],
      phoneCountryCode: json['phone_country_code'],
      phone: json['phone'],
      faxCountryCode: json['fax_country_code'],
      fax: json['fax'],
      email: json['email'],
      preferredCommunicationMode: json['preferred_communication_mode'],
      status: json['status'],
      groupNpi: json['group_npi'],
      maxAgeOfMinor: json['max_age_of_minor'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_details': logoDetails?.toJson(),
      'favicon_details': faviconDetails?.toJson(),
      'created_on': createdOn,
      'updated_on': updatedOn,
      'version': version,
      'address': address,
      'address_1': address1,
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'country': country,
      'contact_prefix': contactPrefix,
      'contact_first_name': contactFirstName,
      'contact_middle_name': contactMiddleName,
      'contact_last_name': contactLastName,
      'contact_suffix': contactSuffix,
      'name': name,
      'brand_color': brandColor,
      'slogan': slogan,
      'description': description,
      'app_conf_type': appConfType,
      'allow_ext_providers': allowExtProviders,
      'url': url,
      'max_security_question': maxSecurityQuestion,
      'code': code,
      'website': website,
      'work_country_code': workCountryCode,
      'work_phone': workPhone,
      'phone_country_code': phoneCountryCode,
      'phone': phone,
      'fax_country_code': faxCountryCode,
      'fax': fax,
      'email': email,
      'preferred_communication_mode': preferredCommunicationMode,
      'status': status,
      'group_npi': groupNpi,
      'max_age_of_minor': maxAgeOfMinor,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
    };
  }
}

class LogoDetails {
  final String? id;
  final String? type;
  final String? file;
  final String? filename;
  final String? createdOn;

  LogoDetails({
    this.id,
    this.type,
    this.file,
    this.filename,
    this.createdOn,
  });

  factory LogoDetails.fromJson(Map<String, dynamic> json) {
    return LogoDetails(
      id: json['id'] ?? "",
      type: json['type'] ?? "",
      file: json['file'] ?? "",
      filename: json['filename'] ?? "",
      createdOn: json['created_on'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'file': file,
      'filename': filename,
      'created_on': createdOn,
    };
  }
}

class FaviconDetails {
  final String? id;
  final String? type;
  final String? file;
  final String? filename;
  final String? createdOn;

  FaviconDetails({
    this.id,
    this.type,
    this.file,
    this.filename,
    this.createdOn,
  });

  factory FaviconDetails.fromJson(Map<String, dynamic> json) {
    return FaviconDetails(
      id: json['id'] ?? "",
      type: json['type'] ?? "",
      file: json['file'] ?? "",
      filename: json['filename'] ?? "",
      createdOn: json['created_on'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'file': file,
      'filename': filename,
      'created_on': createdOn,
    };
  }
}
