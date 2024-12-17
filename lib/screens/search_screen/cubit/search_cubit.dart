import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:quran/data_layer/data_layer.dart';
import 'package:quran/models/search_model.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/setup/setup.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
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

  Future<void> loadWordMatches() async {
    try {
      if (searchQuery == null || searchQuery!.isEmpty) {
        emit(ErrorState(msg: "Search query is empty"));
        return;
      }
      matchWords = await getIt.get<DataLayer>().getWordMatches(searchQuery!);

      if (selectedValue != null) {
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

  void updateSearchQuery(String query) {
    searchQuery = query;
  }

  Future<void> loadSurahDetails() async {
    try {
      allSurah = await getIt.get<DataLayer>().getSurahDetails();
      surah = allSurah;
      emit(SurahDetailsState(surah: surah));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  void updateSelectedValue(int? value) {
    if (selectedValue == null) {
      loadWordMatches();
    }
    selectedValue = value;

    emit(SurahDetailsState(surah: surah));
    loadWordMatches();
  }
}
