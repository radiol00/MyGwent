import 'dart:async';
import 'dart:convert';
import 'package:card_api_test/bloc/deck/deck_event.dart';
import 'package:card_api_test/model/deck.dart';
import 'package:http/http.dart' as http;

class DeckBloc {
// Kontroler stanu
  final _deckStateController = StreamController<Deck>();

// Wejście stanu - prywatne
  StreamSink<Deck> get _inDeck => _deckStateController.sink;

// Wyjście stanu - publiczne
  Stream<Deck> get deck => _deckStateController.stream;

// Kontroler zdarzeń
  final _deckEventController = StreamController<DeckEvent>();

// Wejście zdarzeń - publiczne
  Sink<DeckEvent> get deckEventSink => _deckEventController.sink;

// W konstruktorze mapujemy wyjście kontrolera zdarzeń do kontrolera wejścia stanu
  DeckBloc() {
    _deckEventController.stream.listen(_mapEventToState);
  }

// Funkcja mapująca
  void _mapEventToState(DeckEvent event) async {
    if (event is GettingDeckEvent) {
      final response = await http
          .get('https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1');
      if (response.statusCode == 200) {
        _inDeck.add(Deck.fromJson(jsonDecode(response.body)));
      } else {
        _inDeck.addError('Failed GET: deck');
      }
    } else {
      throw Exception('No such event ${event.runtimeType}');
    }
  }

// Funkcja czyszcząca
  void dispose() {
    _deckEventController.close();
    _deckStateController.close();
  }
}
