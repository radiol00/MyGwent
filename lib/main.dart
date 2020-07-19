import 'package:card_api_test/bloc/deck/deck_bloc.dart';
import 'package:card_api_test/bloc/deck/deck_event.dart';
import 'package:card_api_test/model/deck.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _bloc = DeckBloc();

  @override
  void initState() {
    _bloc.deckEventSink.add(GettingDeckEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(),
          body: StreamBuilder(
            stream: _bloc.deck,
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot<Deck> snapshot) {
              if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Wystąpił błąd z połączeniem'),
                        Text(snapshot.error.toString()),
                        RaisedButton(
                            child: Text('Ponów'),
                            onPressed: () {
                              _bloc.deckEventSink.add(GettingDeckEvent());
                            })
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                return Container(
                  child: Text('${snapshot.data.id}'),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}
