import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:quran/data_layer/data_layer.dart';
import 'package:quran/models/search_model.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/setup/setup.dart';
part 'search_state.dart';

/* Cubit to manage business logic separately from the UI*/
class SearchCubit extends Cubit<SearchState> {
  // variables
  TextEditingController searchController = TextEditingController();
  String? searchQuery;
  List<Matches> matchWord = [];
  List<Matches> matchWords = [];
  List<Matches> filterMatchWord = [];
  List<Matches> filterMatchWords = [];
  List<SurahModel> surah = [];
  List<SurahModel> allSurah = [];
  int? selectedValue;

  SearchCubit() : super(SearchInitial());

  // fetch all ayahs that contain the match word
  Future<void> loadWordMatches() async {
    emit(LoadingState());
    try {
      // await Future.delayed(const Duration(seconds: 5));

      if (searchQuery == null || searchQuery!.isEmpty) {
        emit(ErrorState(msg: "Search query is empty"));
        return;
      }
      // fetch all ayahs that contain the match word in all the quran
      matchWords = await getIt.get<DataLayer>().getWordMatches(searchQuery!);

      if (selectedValue != null) {
        // fetch all ayahs that contain the match word in a specific surah
        filterMatchWords = await getIt
            .get<DataLayer>()
            .getFilterWordMatches(searchQuery!, selectedValue!);
        filterMatchWord = filterMatchWords
            .where((e) =>
                e.text
                    .toString()
                    .trim()
                    .toLowerCase()
                    .contains(searchQuery!.trim().toLowerCase()) &&
                e.surah.number == selectedValue)
            .toList();
        emit(SearchWordState(matchWord: filterMatchWord));
      } else {
        matchWord = matchWords
            .where((e) => e.text
                .toString()
                .trim()
                .toLowerCase()
                .contains(searchQuery!.trim().toLowerCase()))
            .toList();
        emit(SearchWordState(matchWord: matchWord));
      }
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  // update search query
  void updateSearchQuery(String query) {
    searchQuery = query;
  }

  // fetch the surah's details
  Future<void> loadSurahDetails() async {
    try {
      allSurah = await getIt.get<DataLayer>().getSurahDetails();
      surah = allSurah;
      emit(SurahDetailsState(surah: surah));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  // update selected value for surah
  void updateSelectedValue(int? value) {
    selectedValue = value;
    emit(SurahDetailsState(surah: surah));
    loadWordMatches();
  }
}
