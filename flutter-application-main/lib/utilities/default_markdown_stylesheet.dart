import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

final defaultMarkdownStylesheet = MarkdownStyleSheet(
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
  code: TextStyle(
    fontSize: 18,
    backgroundColor: Colors.grey.shade100,
    color: Colors.black45,
    fontFamily: 'Courier New',
    fontWeight: FontWeight.bold,
  ),
);
