import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran/data_layer/data_layer.dart';

// get it used for accessing an object from anywhere in an web/app
final getIt = GetIt.instance;

Future<void> setup() async{
  await GetStorage.init();
  getIt.registerSingleton<DataLayer>(DataLayer());

}