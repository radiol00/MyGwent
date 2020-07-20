import 'package:card_api_test/bloc/deck_bloc.dart';
import 'package:card_api_test/repository/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_api_test/view/game_board.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DeckBloc _bloc;

  @override
  void initState() {
    _bloc = DeckBloc(DeckRepository());
    _bloc.add(GetNewDeck(1));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => _bloc,
        child: Scaffold(
          backgroundColor: Colors.green[200],
          body: SafeArea(
            child: BlocListener<DeckBloc, DeckState>(
              listener: (context, state) {
                if (state is ErrorDeckState) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: BlocBuilder<DeckBloc, DeckState>(
                builder: (context, state) {
                  if (state is InitialDeckState) {
                    return Container();
                  } else if (state is LoadingDeckState) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SpinKitRotatingPlain(
                            color: Color.fromRGBO(255, 215, 0, 1),
                          )
                        ],
                      ),
                    );
                  } else if (state is LoadedDeckState) {
                    return GameBoard(
                      deck: state.deck,
                    );
                  } else if (state is ErrorDeckState) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(state.message),
                          RaisedButton(
                            child: Text('Ponów'),
                            onPressed: () {
                              _bloc.add(GetNewDeck(1));
                            },
                          )
                        ],
                      ),
                    );
                  }
                  return Text('Error');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
