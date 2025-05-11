import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);
    final articles = provider.articles;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: const [
                  Icon(Icons.article_outlined, size: 28, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Discover Articles',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: (query) =>
                    Provider.of<ArticleProvider>(context, listen: false)
                        .searchArticles(query),
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Expanded List
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.error.isNotEmpty
                      ? Center(child: Text(provider.error))
                      : RefreshIndicator(
                          onRefresh: () => Provider.of<ArticleProvider>(context,
                                  listen: false)
                              .fetchArticles(),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              final article = articles[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: ArticleCard(
                                  article: article,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            DetailScreen(article: article),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
