import 'dart:convert';

import 'package:card_api_test/model/deck.dart';
import 'package:http/http.dart' as http;

class DeckRepository {
  Future<Deck> fetchDeck(int amount) async {
    final response = await http.get(
        'https://deckofcardsapi.com/api/deck/new/shufle/?deck_count=${amount}');

    if (response.statusCode == 200) {
      return Deck.fromJson(jsonDecode(response.body));
    } else {
      throw ("Failed to GET deck");
    }
  }
}
