import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/components/custom_elevated_button.dart';
import 'package:quran/components/custom_error_msg.dart';
import 'package:quran/data_layer/data_layer.dart';
import 'package:quran/screens/auth_screens/auth_screen.dart';
import 'package:quran/screens/search_screen/cubit/search_cubit.dart';
import 'package:quran/setup/setup.dart';

/* search screen UI */
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<SearchCubit>();
        return BlocListener<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Lottie.asset(
                          'assets/json/loading_animation.json',
                          width: 100)));
            }
            if (state is ErrorState) {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomErrorDialog(msg: (state.msg));
                  });
            }
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffEEDCDF),
                Color(0xffDFDFE1),
                Color(0xffE9DFE1),
                Color(0xffD4DBDD),
                Color(0xffD8D9DB)
              ], begin: Alignment.topLeft),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                toolbarHeight: 80,
                leading: Image.asset(
                  'assets/png/Quran_logo.png',
                ),
                leadingWidth: 150,
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustomElevatedButton(
                      onPressed: () {
                        getIt.get<DataLayer>().logout();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const AuthScreen()),
                            ModalRoute.withName('/'));
                      },
                      text: "Log out",
                      fixedSize: const Size.fromHeight(35),
                    ),
                  ),
                ],
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                  child: Column(
                    children: [
                      const Text(
                        'Quran Search',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: cubit.searchController,
                        onChanged: (value) {
                          cubit.updateSearchQuery(value);
                        },
                        onFieldSubmitted: (value) => cubit.loadWordMatches(),
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search_rounded),
                            prefixIconColor: const Color(0xff796181),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  cubit.loadSurahDetails();
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      useSafeArea: true,
                                      constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.8),
                                      backgroundColor: const Color(0xffDFDFE1),
                                      builder: (context) {
                                        return BlocProvider.value(
                                          value: cubit,
                                          child: BlocBuilder<SearchCubit,
                                              SearchState>(
                                            builder: (context, state) {
                                              if (state is SurahDetailsState) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        "Select a Surah from the List",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 16.0),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            cubit
                                                                .updateSelectedValue(
                                                                    null);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            'reset selection',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff796181)),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: ListView.builder(
                                                          itemCount: state
                                                              .surah.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final surah = state
                                                                .surah[index];
                                                            return ListTile(
                                                              title: Text(
                                                                  "${surah.number}- ${surah.englishName}"),
                                                              leading: Radio(
                                                                value: surah
                                                                    .number,
                                                                groupValue: cubit
                                                                    .selectedValue,
                                                                onChanged: (int?
                                                                    value) {
                                                                  cubit.updateSelectedValue(
                                                                      value!);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                activeColor:
                                                                    const Color(
                                                                        0xff796181),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                              return const SizedBox();
                                            },
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.filter_alt_outlined)),
                            suffixIconColor: const Color(0xff796181),
                            hintText: 'Search',
                            hintStyle:
                                const TextStyle(color: Color(0xff808080)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: const Color(0xffDFDFE1)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          if (state is SearchWordState) {
                            Navigator.pop(context);
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.matchWord.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemBuilder: (context, index) {
                                final word = state.matchWord[index];
                                return ListTile(
                                  title: Text(
                                    word.surah.englishName,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(word.text),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Color(0xff796181)),
                                      borderRadius: BorderRadius.circular(20)),
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xffD2B7A4),
                                    child: Text('${word.numberInSurah}'),
                                  ),
                                );
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              )),
            ),
          ),
        );
      }),
    );
  }
}
