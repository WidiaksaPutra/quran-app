import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

final getItInstance = GetIt.instance;
DateFormat formatDate = DateFormat('E, d MMM yyyy HH:mm:ss');
DateFormat formatDateShort = DateFormat('dd MMM yyyy');
DateFormat formatDateArabShort = DateFormat('dd MMM yyyy', 'ar');
DateFormat formatDay = DateFormat('EEEE');
DateFormat formatDayArab = DateFormat('EEEE', 'ar');
DateFormat formatMinute = DateFormat('HH:mm:ss');