enum  PatientChartType{
  view('View'),
  print('Print'),
  download('Download'),
  other('Other'),
  transmit('Transmit');
  final String? type;
  const PatientChartType(this.type);
}


enum  PatientChartViewType{
  viewAsXml('View as XML'),
  viewAsOther('View as Other'),
  viewAsHtml('View as HTML'),
  viewAsPdf('View as PDF');
  final String? type;
  const PatientChartViewType(this.type);
}


enum  PatientChartDownloadType{
  downloadAsXml('Download as XML'),
  downloadAsOther('Download as Other'),
  downloadAsHtml('Download as HTML'),
  downloadAsPdf('Download as PDF');
  final String? type;
  const PatientChartDownloadType(this.type);
}


enum  PatientChartTransmitType{
  shareAsHtml('Share as HTML'),
  shareAsOther('Share as Other'),
  shareAsXml('Share as XML'),
  shareAsPdf('Share as PDF');
  final String? type;
  const PatientChartTransmitType(this.type);
}


enum  PatientChartTransmitEncryptedType{
  encrypted('Encrypted'),
  unencrypted('Unencrypted');
  final String? type;
  const PatientChartTransmitEncryptedType(this.type);
}


enum  PatientChartPrintType{
  printAsXml('Print as XML'),
  printAsHtml('Print as HTML'),
  printAsOther('Print as Other'),
  printAsPdf('Print as PDF');
  final String? type;
  const PatientChartPrintType(this.type);
}