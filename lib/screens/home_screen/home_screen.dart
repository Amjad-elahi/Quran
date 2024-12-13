import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController? searchController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xffFEFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.abc_outlined),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 40),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  prefixIconColor: const Color(0xff808080),
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
                  suffixIconColor: const Color(0xff808080),
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Color(0xff808080)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Color(0xff88B2A8))),
                  filled: true,
                  fillColor: const Color(0xffF7F7F7)),
            ),
          ],
        ),
      )),
    );
  }
}
