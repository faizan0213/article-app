import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/article_provider.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);
    final isFav = provider.isFavorite(article.id);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(article.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(article.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600])),
        ),
        trailing: IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () => provider.toggleFavorite(article.id),
        ),
        onTap: onTap,
      ),
    );
  }
}
