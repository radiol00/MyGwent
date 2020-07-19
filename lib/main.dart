import 'package:card_api_test/bloc/deck_bloc.dart';
import 'package:card_api_test/repository/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      title: 'Elo',
      home: BlocProvider(
        create: (context) => _bloc,
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<DeckBloc, DeckState>(
            builder: (context, state) {
              if (state is InitialDeckState) {
                return Text('initial state');
              } else if (state is LoadingDeckState) {
                return Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading state')
                  ],
                );
              } else if (state is LoadedDeckState) {
                return Text(state.deck.id);
              } else if (state is ErrorDeckState) {
                return Column(
                  children: <Widget>[
                    Text(state.message),
                    RaisedButton(
                      child: Text('Ponów'),
                      onPressed: () {
                        _bloc.add(GetNewDeck(1));
                      },
                    )
                  ],
                );
              }
              return Text('error');
            },
          ),
        ),
      ),
    );
  }
}
