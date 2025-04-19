enum DisplayDateType {
  date('Date') ,
  time('Time') ,
  dateAndTime('Date And Time');


  final String dateTime;
  const DisplayDateType(this.dateTime);
}