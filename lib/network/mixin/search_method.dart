import 'dart:async';

import 'package:dio/dio.dart';
import 'package:quran/models/search_model.dart';
import 'package:quran/network/constant_network.dart';

mixin SearchMethod on ConstantNetwork {
  Future generalSearch(String keyword) async {
    try {
      final response =
          await dio.get('$baseUrl$searchEndPoint/$keyword/all/en.asad');
      print(response.statusCode);
      List<dynamic> matches = response.data['data']['matches'];
      print(matches);
      List<Matches> result = matches.map((e) => Matches.fromJson(e)).toList();

      print('result $result');

      return result;
    } on DioException catch (e) {
      throw FormatException(e.response!.data['data']);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  Future filteredSearch(String keyword, int numOfSurah) async {
    try {
      final response =
          await dio.get('$baseUrl$searchEndPoint/$keyword/$numOfSurah/en.asad');
      print(response.statusCode);
      List<dynamic> matches = response.data['data']['matches'];
      print(matches);
      List<Matches> result = matches.map((e) => Matches.fromJson(e)).toList();

      print('result $result');

      return result;
    } on DioException catch (e) {
      throw FormatException(e.response?.data['data']);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }
}
