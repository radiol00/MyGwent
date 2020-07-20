import 'dart:async';

import 'package:card_api_test/bloc/deck_bloc.dart';
import 'package:card_api_test/model/deck.dart';
import 'package:card_api_test/model/hand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBoard extends StatefulWidget {
  final Deck deck;
  GameBoard({@required this.deck});

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  StreamController<Hand> streamController;
  Hand playerHand;

  void getStartingHand() async {
    try {
      Hand draw = await widget.deck.drawCards(6);
      playerHand.cardList.addAll(draw.cardList);
      streamController.add(playerHand);
    } catch (e) {
      streamController.addError('Failed to draw cards');
    }
  }

  @override
  void initState() {
    playerHand = Hand([]);
    streamController = StreamController<Hand>();
    getStartingHand();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100.0,
            color: Colors.green[400],
            child: Row(
              children: <Widget>[Text('Ręka przeciwnika')],
            ),
          ),
          Container(
            height: 80.0,
            color: Colors.green[600],
            child: Row(
              children: <Widget>[Text('Łucznicy przeciwnika')],
            ),
          ),
          Container(
            height: 80.0,
            color: Colors.green[600],
            child: Row(
              children: <Widget>[Text('Miecznicy przeciwnika')],
            ),
          ),
          Divider(
            thickness: 2.0,
            color: Colors.green,
          ),
          Container(
            height: 80.0,
            color: Colors.green[600],
            child: Row(
              children: <Widget>[Text('Twoi Miecznicy')],
            ),
          ),
          Container(
            height: 80.0,
            color: Colors.green[600],
            child: Row(
              children: <Widget>[Text('Twoi łucznicy')],
            ),
          ),
          Container(
            height: 100.0,
            color: Colors.green[400],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<Hand>(
                stream: streamController.stream,
                initialData: null,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: snapshot.data.cardList
                          .map((e) => Draggable(
                              childWhenDragging: SizedBox(width: 63),
                              feedback: SizedBox(
                                height: 100,
                                child: Card(
                                  child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/cardback.png',
                                      image: e['image']),
                                ),
                              ),
                              child: Card(
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/cardback.png',
                                    image: e['image']),
                              )))
                          .toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(snapshot.error)]);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
