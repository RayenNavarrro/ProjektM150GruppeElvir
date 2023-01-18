import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gibz_mobileapp/models/students_manual/students_manual.dart';
import 'package:gibz_mobileapp/pages/new_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/repositories/students_manual/article_repository.dart';

class KnowledgeBaseDetail extends StatelessWidget {
  final String id;
  final String title;

  const KnowledgeBaseDetail({required this.id, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      pageTitle: title,
      child: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Article>(
              future: context.read<ArticleRepository>().getArticle(id),
              builder: (BuildContext context, AsyncSnapshot<Article> snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MarkdownBody(
                    data: snapshot.data?.content ?? '',
                    onTapLink: (text, url, title) {
                      if (url != null && url.isNotEmpty) launch(url);
                    },
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(
                        // color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'CorporateS',
                      ),
                      a: const TextStyle(
                        color: Color.fromARGB(255, 0, 89, 170),
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                      h1: const TextStyle(
                        fontFamily: 'CorporateS',
                        color: Color.fromARGB(255, 0, 89, 170),
                        fontSize: 28,
                      ),
                      listIndent: 12,
                      listBullet: const TextStyle(color: Colors.black54),
                      code: const TextStyle(
                        fontSize: 18,
                        backgroundColor: Colors.transparent,
                        color: Colors.black87,
                        fontFamily: 'Courier New',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            // if (entry.videoAttachments.isNotEmpty)
            //   VideoAttachmentList(knowledgeBaseEntry: entry)
          ],
        ),
      ),
    );
  }
}
