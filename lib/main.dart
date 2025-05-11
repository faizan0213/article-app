import 'package:articles/providers/article_provider.dart';
import 'package:articles/screens/favorites_screen.dart';
import 'package:articles/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleProvider()..fetchArticles(),
      child: MaterialApp(
        title: 'Flutter Article App',
        theme: ThemeData(
          primarySwatch: Colors.orange, // Primary color for the app
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.orange, // Custom AppBar color
            titleTextStyle: TextStyle(color: Colors.white), // AppBar text color
          ),
          scaffoldBackgroundColor:
              Colors.white, // Background color for the scaffold
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors
                .lightBlueAccent, // Bottom navigation bar background color
            selectedItemColor: Colors.black, // Color for selected item
            unselectedItemColor: Colors.grey, // Color for unselected item
          ),
        ),
        home: ArticleApp(), // Your main screen widget
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class ArticleApp extends StatefulWidget {
  @override
  State<ArticleApp> createState() => _ArticleAppState();
}

class _ArticleAppState extends State<ArticleApp> {
  int _selectedIndex = 0;

  final _screens = [
    HomeScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Articles'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
