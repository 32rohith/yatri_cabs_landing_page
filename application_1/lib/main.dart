import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        final scale = mediaQuery.size.width / 375; 

        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(scale),
          ),
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.green,
              scaffoldBackgroundColor: Colors.black,
              fontFamily: 'Poppins',
              textTheme: TextTheme(
                bodyLarge: TextStyle(fontSize: 16 * scale),
                bodyMedium: TextStyle(fontSize: 14 * scale),
                titleLarge: TextStyle(fontSize: 22 * scale),
              ),
              iconTheme: IconThemeData(
                size: 24 * scale,
              ),
            ),
            child: child!,
          ),
        );
      },
      home: const HomePage(),
    );
  }
}