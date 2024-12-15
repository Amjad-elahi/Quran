import 'package:quran/network/constant_network.dart';
import 'package:quran/network/mixin/search_method.dart';
import 'package:quran/network/mixin/surah_method.dart';

class ApiNetwork extends ConstantNetwork with SurahMethod, SearchMethod {}
