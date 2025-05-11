import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);
    final favorites = provider.favorites;

    return favorites.isEmpty
        ? Center(child: Text('No favorites yet.'))
        : ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final article = favorites[index];
              return ArticleCard(
                article: article,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(article: article),
                    ),
                  );
                },
              );
            },
          );
  }
}
