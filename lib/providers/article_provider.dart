import 'package:flutter/material.dart';
import '../models/article.dart';
import 'package:articles/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  Set<int> _favoriteIds = {};
  bool _isLoading = true;
  String _error = '';

  List<Article> get articles => _filteredArticles;
  bool get isLoading => _isLoading;
  String get error => _error;
  List<Article> get favorites =>
      _articles.where((a) => _favoriteIds.contains(a.id)).toList();

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();
    try {
      final fetched = await ApiService.fetchArticles();
      _articles = fetched;
      _filteredArticles = fetched;
      await _loadFavorites();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchArticles(String query) {
    if (query.isEmpty) {
      _filteredArticles = _articles;
    } else {
      _filteredArticles = _articles.where((article) =>
          article.title.toLowerCase().contains(query.toLowerCase()) ||
          article.body.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

  void toggleFavorite(int articleId) {
    if (_favoriteIds.contains(articleId)) {
      _favoriteIds.remove(articleId);
    } else {
      _favoriteIds.add(articleId);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(int articleId) => _favoriteIds.contains(articleId);

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites',
        _favoriteIds.map((id) => id.toString()).toList());
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favStrings = prefs.getStringList('favorites') ?? [];
    _favoriteIds = favStrings.map(int.parse).toSet();
  }
}
