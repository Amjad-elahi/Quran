import 'package:dio/dio.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/network/constant_network.dart';

mixin SurahMethod on ConstantNetwork {
  // Retrieve the surah's details response from the API
  Future getSurahDetails() async {
    try {
      final response = await dio.get('$baseUrl$surahEndPoint');
      List<dynamic> surahDetails = response.data['data'];
      List<SurahModel> result =
          surahDetails.map((e) => SurahModel.fromJson(e)).toList();

      return result;
    } on DioException catch (e) {
      throw FormatException(e.response?.data['data']);
    } catch (e) {
      throw FormatException(e.toString());
    }
  }
}
