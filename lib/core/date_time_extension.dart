import 'package:intl/intl.dart';

extension DateTimex on DateTime{

  toDateAndMinutesTimeString(){
    String formattedDateTime = DateFormat.yMMMMd('es_ES').add_Hm().format(this);

    return formattedDateTime;
  }

}