import 'package:flutter/material.dart';
import 'package:imagegenerator/Screens/home_page.dart';
import 'package:provider/provider.dart';

import 'Providers/image_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GeneratedImageProvider>(create: (context) => GeneratedImageProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(
          useMaterial3: true
        ),
        home: const HomePage(),
      ),
    );
  }
}

