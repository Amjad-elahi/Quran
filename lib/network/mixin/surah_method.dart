import 'package:dio/dio.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/network/constant_network.dart';

mixin SurahMethod on ConstantNetwork {
  Future getSurahDetails() async {
    try {
      final response = await dio.get('$baseUrl$surahEndPoint');
      print(response.statusCode);
      print("surah ${response.data}");
      List<dynamic> surahDetails = response.data['data'];
      print(surahDetails);
      List<SurahModel> result =
          surahDetails.map((e) => SurahModel.fromJson(e)).toList();

      print('result $result');
      return result;
    } on DioException catch (e) {
      throw FormatException(e.response?.data['data']);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }
}
