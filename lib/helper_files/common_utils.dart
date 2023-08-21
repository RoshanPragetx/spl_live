import 'package:intl/intl.dart';

class CommonUtils {
  String formatDateTimeToDDMMYYYY(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  String formatStringDateToDDMMYYYY(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(inputDate);
    return formattedDate;
  }

  String formatStringDateToHHMMADDMMYYYY(String date) {
    DateTime dateTime = DateTime.parse(date);

    String formattedDateTimeString =
        DateFormat('hh:mm a dd-MM-yyyy').format(dateTime);
    return formattedDateTimeString;
  }

  String formatStringToDDMMMYYYYHHMMSSA(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDateTimeString =
        DateFormat('dd MMMM, yyyy, hh:mm:ss a').format(dateTime);
    return formattedDateTimeString;
  }

  String formatStringToDDMMYYYYHHMMA(String date) {
    DateTime dateTime = DateTime.parse(date);

    String formattedDateTimeString =
        DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
    return formattedDateTimeString;
  }

  int getDifferenceBetweenGivenTimeFromNow(String time) {
    var timeFormat = DateFormat('hh:mm a');
    var inputDate = timeFormat.parse(time);

    var tempTime = timeFormat.format(DateTime.now());
    var formattedTime = timeFormat.parse(tempTime);

    int difference = inputDate.difference(formattedTime).inMinutes;
    return difference;
  }

  String formatDateToYYYYMMDD(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  String formatStringToHHMMA(String time) {
    final parsedTime = DateFormat("HH:mm:ss").parse(time);
    final formattedTime = DateFormat("hh:mm a").format(parsedTime);
    return formattedTime;
  }

  String formatStringToHHMM(String time) {
    final parsedTime = DateFormat("HH:mm:ss").parse(time);
    final formattedTime = DateFormat("hh:mm").format(parsedTime);
    return formattedTime;
  }

  String formatDateStringToDDMMMMYYYY(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat('dd MMMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  String formatDateStringToHHMMDDMMMMYYYY(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat('hh:mm a dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  String formatDateStringToHHMMA(String date) {
    DateTime utcTime = DateTime.parse(date);
    String formattedTime = DateFormat('dd-MM-yyyy').format(utcTime.toLocal());
    return formattedTime;
  }

  String formatDateStringToEEEEMMMMddyyyy(String date) {
    DateTime utcTime = DateTime.parse(date);
    String formattedTime =
        DateFormat('EEEE, MMMM dd, yyyy').format(utcTime.toLocal());
    return formattedTime;
  }

  String formatDateStringToMMMYYYY(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat('MMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  String formatDateStringToDDMMMMMYYYY(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat('dd MMMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  String convertUtcToIst(String utcTimestamp) {
    DateTime utcDateTime = DateTime.parse(utcTimestamp);
    DateTime istDateTime =
        utcDateTime.add(const Duration(hours: 5, minutes: 30));
    String formattedDate = DateFormat('MMM dd, yyyy').format(istDateTime);
    String formattedTime = DateFormat('hh:mm a').format(istDateTime);
    return '$formattedDate $formattedTime';
  }
}



// "2023-08-16T05:46:21.828Z"   27 
// "2023-08-16T05:33:14.741Z"   20
// 15:10:00  27