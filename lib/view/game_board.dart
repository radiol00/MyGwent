import 'dart:async';

import 'package:card_api_test/bloc/deck_bloc.dart';
import 'package:card_api_test/bloc/hand_bloc.dart';
import 'package:card_api_test/bloc/units_bloc.dart';
import 'package:card_api_test/model/deck.dart';
import 'package:card_api_test/model/hand.dart';
import 'package:card_api_test/model/units.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBoard extends StatefulWidget {
  final Deck deck;
  GameBoard({@required this.deck});

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  UnitsBloc _unitsBloc;
  HandBloc _handBloc;

  void getStartingHand() async {
    Hand draw = await widget.deck.drawCards(6);
    draw.cardList.forEach((card) {
      _handBloc.add(HandAddCard(card));
    });
  }

  @override
  void initState() {
    _unitsBloc = UnitsBloc();
    _handBloc = HandBloc();
    getStartingHand();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _handBloc,
      child: BlocProvider(
        create: (context) => _unitsBloc,
        child: Container(
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
                  children: <Widget>[
                    BlocBuilder<UnitsBloc, UnitsState>(
                      builder: (context, state) {
                        return Expanded(
                          child: DragTarget(
                            onAccept: (data) {
                              _unitsBloc.add(UnitsAdd(data));
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ...(state is UnitsInitial
                                        ? []
                                        : state is UnitsPlayed
                                            ? [
                                                ...(state.units.warriors
                                                    .map((element) => Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 5,
                                                                  vertical: 2),
                                                          child: Image.network(
                                                              element['image']),
                                                        )))
                                              ]
                                            : [Text('ERROR DISPLAYING ROW')])
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  ],
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
                  child: BlocBuilder<HandBloc, HandState>(
                    builder: (context, state) {
                      if (state is HandInitial) {
                        return Row();
                      } else if (state is HandLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is HandError) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(state.msg)]);
                      } else if (state is HandLoaded) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: state.hand.cardList
                              .map((e) => Draggable(
                                  data: e,
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
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
