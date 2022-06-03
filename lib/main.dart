import 'package:flutter/material.dart';
import 'package:note_app/notes/provider/note_provider.dart';
import 'package:note_app/notes/services/sqlite.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLite.init();
  runApp(
    MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => NoteProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: HomeScreen.id, routes: {
      HomeScreen.id: (context) => HomeScreen(),
    });
  }
}
