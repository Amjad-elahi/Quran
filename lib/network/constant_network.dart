import 'package:dio/dio.dart';

// class for storing urls
abstract class ConstantNetwork {
  final dio = Dio();
  final String baseUrl = 'http://api.alquran.cloud/v1';
  final String surahEndPoint = '/surah';
  final String searchEndPoint = '/search';

}