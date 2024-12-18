import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data_layer/data_layer.dart';
import 'package:quran/setup/setup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_state.dart';

/* Cubit to manage business logic separately from the UI*/
class AuthCubit extends Cubit<AuthState> {
  // variables
  final formKey = GlobalKey<FormState>();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPassController = TextEditingController();
  final supabase = getIt.get<DataLayer>().supabase;
  List<Map<String, dynamic>> response = [];
  bool isVisible = false;

  AuthCubit() : super(AuthInitial());

  // sign up function
  signUp() async {
    emit(LoadingState());
    try {
      print('Sign-up1 start: ${DateTime.now()}');
      // checking if email already registered
      response = await supabase
          .from("users")
          .select('email')
          .eq("email", signUpEmailController.text);
      print('Query1 completed: ${DateTime.now()}');
      if (response.isNotEmpty) {
        emit(ErrorState(msg: "Account Already registered"));
      } else {
        print('Sign-up2 start: ${DateTime.now()}');
        // sign up user and store the data in supabase
        await supabase.auth.signUp(
          email: signUpEmailController.text,
          password: signUpPassController.text,
          data: {
            'name': nameController.text,
            'email': signUpEmailController.text
          },
        );
        print('Query2 completed: ${DateTime.now()}');
        // store user id
        getIt
            .get<DataLayer>()
            .box
            .write('userId', supabase.auth.currentUser!.id);
        emit(SuccessState());
      }
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } on TimeoutException catch (e) {
      emit(ErrorState(msg: e.toString()));
    } on SocketException catch (e) {
      emit(ErrorState(msg: e.message));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  signIn() async {
    emit(LoadingState());
    try {
      // checking if email is found or not
      response = await supabase
          .from("users")
          .select()
          .eq("email", signInEmailController.text);

      if (response.isEmpty) {
        emit(ErrorState(msg: "Account not found."));
      } else {
        // sign in user
        await supabase.auth.signInWithPassword(
          email: signInEmailController.text,
          password: signInPassController.text,
        );
        // store user id
        getIt
            .get<DataLayer>()
            .box
            .write('userId', supabase.auth.currentUser!.id);
        emit(SuccessState());
      }
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } on TimeoutException catch (e) {
      emit(ErrorState(msg: e.toString()));
    } on SocketException catch (e) {
      emit(ErrorState(msg: e.message));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  passwordVisibility() {
    isVisible = !isVisible;
    emit(PassVisibilityState(isVisible: isVisible));
  }
}
