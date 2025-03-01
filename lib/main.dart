import 'package:dvp_app/src/app.dart';
import 'package:dvp_app/src/data/appstate.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

//{}
//[]

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized;
  await initLocalStorage();
  runApp(
   ChangeNotifierProvider(
    create: (context)=>AppState(localStorage),
    child: DefaultApp(),)
  );
}
