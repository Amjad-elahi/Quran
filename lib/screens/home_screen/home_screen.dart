import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/components/custom_error_msg.dart';
import 'package:quran/screens/home_screen/cubit/search_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    print(state.msg);
                    return CustomErrorDialog(msg: (state.msg));
                  });
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFEFFFF),
            appBar: AppBar(
              title: Text('Quran Search'),
              backgroundColor: Colors.transparent,
              leading: const Icon(Icons.abc_outlined),
            ),
            body: SafeArea(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 150, vertical: 40),
              child: Column(
                children: [
                  TextFormField(
                    controller: cubit.searchController,
                    onChanged: (value) {
                      cubit.updateSearchQuery(value);
                    },
                    onFieldSubmitted: (value) => cubit.loadWordMatches(),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search_rounded),
                        prefixIconColor: const Color(0xff808080),
                        suffixIcon: IconButton(
                            onPressed: () {
                              cubit.loadSurahDetails();
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      maxWidth:
                                          MediaQuery.of(context).size.width /
                                              1.8),
                                  backgroundColor: const Color(0xffFEFFFF),
                                  builder: (context) {
                                    return BlocProvider.value(
                                      value: cubit,
                                      child:
                                          BlocBuilder<SearchCubit, SearchState>(
                                        builder: (context, state) {
                                          print(
                                              'Building BlocBuilder with state: $state');
                                          if (state is SurahDetailsState) {
                                            print(
                                                'Building BlocBuilder with state: $state');
                                            return Column(
                                              children: [
                                                const Text(
                                                  "Select a Surah from the List",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 16.0),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      cubit.updateSelectedValue(
                                                          null);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'reset selection',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff88B2A8)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount:
                                                        state.surah.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final surah =
                                                          state.surah[index];
                                                      print(
                                                          "Displaying Surah: ${surah.englishName}");
                                                      print(
                                                          "surah.surah.name ${surah.englishName}");
                                                      return ListTile(
                                                        title: Text(
                                                            "${surah.number}- ${surah.englishName}"),
                                                        leading: Radio(
                                                          value: surah.number,
                                                          groupValue: cubit
                                                              .selectedValue,
                                                          onChanged:
                                                              (int? value) {
                                                            cubit
                                                                .updateSelectedValue(
                                                                    value!);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          activeColor:
                                                              const Color(
                                                                  0xff88B2A8),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(Icons.filter_alt_outlined)),
                        suffixIconColor: const Color(0xff808080),
                        hintText: 'Search',
                        hintStyle: const TextStyle(color: Color(0xff808080)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xff88B2A8))),
                        filled: true,
                        fillColor: const Color(0xffF7F7F7)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if (state is SearchWordState) {
                          return ListView.separated(
                            itemCount: state.matchWord.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemBuilder: (context, index) {
                              final word = state.matchWord[index];
                              print(word.number);
                              return ListTile(
                                title: Text(word.surah.englishName),
                                subtitle: Text(word.text),
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Color(0xff88B2A8)),
                                    borderRadius: BorderRadius.circular(20)),
                                leading: CircleAvatar(
                                  backgroundColor: Color(0xffD2B7A4),
                                  child: Text('${word.numberInSurah}'),
                                ),
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            )),
          ),
        );
      }),
    );
  }
}
