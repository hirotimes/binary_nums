import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/binary_nums.dart';

void main() {
  runApp(
      const ProviderScope(
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
      ),
      // initialRoute: '/',
      routes: {
        '/': (context) => const BinaryNums(),
        // '/page1': (context) => AlignTestPage(),
        // '/page2': (context) => InputTest(),
      },
    );
  }
}
