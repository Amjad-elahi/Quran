part of 'search_cubit.dart';

// managing state
@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class LoadingState extends SearchState {}

final class SuccessState extends SearchState {}

final class ErrorState extends SearchState {
  final String msg;
  ErrorState({required this.msg});
}

final class SearchWordState extends SearchState {
  final List<Matches> matchWord;
  SearchWordState({required this.matchWord});
}

final class SurahDetailsState extends SearchState {
  final List<SurahModel> surah;
  SurahDetailsState({required this.surah});
}
