import 'dart:async';

import 'package:dio/dio.dart';
import 'package:quran/models/search_model.dart';
import 'package:quran/network/constant_network.dart';

mixin SearchMethod on ConstantNetwork {
  // Retrieve a general search response from the API for the entire Quran
  Future generalSearch(String keyword) async {
    try {
      final response =
          await dio.get('$baseUrl$searchEndPoint/$keyword/all/en.asad');
      List<dynamic> matches = response.data['data']['matches'];
      List<Matches> result = matches.map((e) => Matches.fromJson(e)).toList();

      return result;
    } on DioException catch (e) {
      throw FormatException(e.response!.data['data']);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  // Retrieve a filtered search response from the API for specific surah
  Future filteredSearch(String keyword, int numOfSurah) async {
    try {
      final response =
          await dio.get('$baseUrl$searchEndPoint/$keyword/$numOfSurah/en.asad');
      List<dynamic> matches = response.data['data']['matches'];
      List<Matches> result = matches.map((e) => Matches.fromJson(e)).toList();
      return result;
    } on DioException catch (e) {
      throw FormatException(e.response?.data['data']);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }
}
