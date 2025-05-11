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
        theme: ThemeData(primarySwatch: Colors.blue),
        home:  ArticleApp(),
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
