import 'package:get_storage/get_storage.dart';
import 'package:quran/models/search_model.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/network/api_network.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;
  final box = GetStorage();
  ApiNetwork api = ApiNetwork();

  List<Matches> wordMatches = [];
  List<Matches> filteredWordMatches = [];
  List<SurahModel> surah = [];

  Future<List<Matches>> getWordMatches(String keyword) async {
    wordMatches = await api.generalSearch(keyword);
    return wordMatches;
  }

  Future<List<Matches>> getFilterWordMatches(String keyword, int numOfSurah) async {
    filteredWordMatches = await api.filteredSearch(keyword, numOfSurah);
    return filteredWordMatches;
  }

  Future<List<SurahModel>> getSurahDetails() async {
    surah = await api.getSurahDetails();
    return surah;
  }

}