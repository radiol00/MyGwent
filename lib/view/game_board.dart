import 'package:card_api_test/model/deck.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {
  final Deck deck;
  GameBoard({@required this.deck});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(deck.id),
    );
  }
}
