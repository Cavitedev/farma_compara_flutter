import 'package:intl/intl.dart';

extension DateTimex on DateTime{

  toDateAndMinutesTimeString(){

    final locale = Intl.getCurrentLocale();

    String formattedDateTime = DateFormat.yMMMMd(locale).add_Hm().format(this);

    return formattedDateTime;
  }

}