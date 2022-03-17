import 'dart:math';

import 'package:flutter/material.dart';

class CarboardScreen extends StatefulWidget {
  @override
  State<CarboardScreen> createState() => _CarboardScreenState();
}

class _CarboardScreenState extends State<CarboardScreen> {
  List<int> receivedArticles = [];
  late int nextArticle;
  List<List<int>> waitingBoxes = [];
  List<List<int>> sentBoxes = [];

  @override
  void initState() {
    generateNextArticle();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Received articles : $receivedArticles"),
          Text("Waiting boxes : $waitingBoxes"),
          Text("Sent boxes : $sentBoxes"),
          const SizedBox(height: 20),
          Text("Next article : $nextArticle"),
          ElevatedButton(
              onPressed: () {
                handleArticle();
              },
              child: Text("Handle article")),
        ],
      ),
    );
  }

  void handleArticle() {
    receivedArticles.add(nextArticle);
    articleIsIncoming(nextArticle);
    generateNextArticle();

    setState(() {});
  }

  void articleIsIncoming(int article) {
    for (int i = 0; i < waitingBoxes.length; i++) {
      if (addArticleInTheBox(i, article)) {
        return;
      }
    }
    waitingBoxes.add([article]);
  }

  // Function returns true if article is put in box
  bool addArticleInTheBox(int indexBox, int article) {
    int totalWithArticle =
        waitingBoxes[indexBox].reduce((a, b) => a + b) + article;

    // Article fits in box
    if (totalWithArticle <= 10) {
      waitingBoxes[indexBox].add(article);
      if (totalWithArticle == 10) {
        //Send box
        sentBoxes.add(waitingBoxes[indexBox]);
        waitingBoxes.removeAt(indexBox);
      }
      return true;
    }

    // Article does not fit in box
    else {
      return false;
    }
  }

  void generateNextArticle() {
    nextArticle = Random().nextInt(9) + 1;
  }
}

extension BoxActions on List<int> {}
