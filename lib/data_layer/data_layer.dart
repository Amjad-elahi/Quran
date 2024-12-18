import 'package:get_storage/get_storage.dart';
import 'package:quran/models/search_model.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/network/api_network.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/* data layer used for managing data */
class DataLayer {
  DataLayer() {
    loadData();
  }

  // instance variables for later uses 
  final supabase = Supabase.instance.client;
  final box = GetStorage();
  ApiNetwork api = ApiNetwork();


  List<Matches> wordMatches = [];
  List<Matches> filteredWordMatches = [];
  List<SurahModel> surah = [];
  String? userId;

  // fetch all ayahs that contain the match word in all the quran 
  Future<List<Matches>> getWordMatches(String keyword) async {
    wordMatches = await api.generalSearch(keyword);
    return wordMatches;
  }

  // fetch all ayahs that contain the match word in a specific surah
  Future<List<Matches>> getFilterWordMatches(
      String keyword, int numOfSurah) async {
    filteredWordMatches = await api.filteredSearch(keyword, numOfSurah);
    return filteredWordMatches;
  }

  // fetch the surah's details
  Future<List<SurahModel>> getSurahDetails() async {
    surah = await api.getSurahDetails();
    return surah;
  }

  // store user id 
  loadData() {
    if (box.hasData("userId")) {
      userId = box.read('userId');
    }
  }

  // log out function
  logout() {
    box.erase();
    supabase.auth.signOut();
  }
}
