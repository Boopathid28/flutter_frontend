class DateHelper {
  
  static convertDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return [dateTime.day,dateTime.month,dateTime.year].join("-");
    } catch (e) {
      return "-";
    }
  }

  static convertDateYearMonthDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return [dateTime.year,dateTime.month,dateTime.day].join("-");
    } catch (e) {
      return "-";
    }
  }

  static convertTime(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return [dateTime.hour,dateTime.minute,dateTime.second].join(":");
    } catch (e) {
      return "-";
    }
  }
 
}