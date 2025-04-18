import 'package:ecommercepro/provider/section_provider.dart';
import 'package:ecommercepro/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 👈 this is crucial!
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SectionProvider())],
      child: MaterialApp(
        title: 'Test',
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
