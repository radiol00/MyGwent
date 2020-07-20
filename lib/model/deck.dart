import 'dart:convert';

import 'package:card_api_test/model/hand.dart';
import 'package:http/http.dart' as http;

class Deck {
  String id;
  bool shuffled;
  int remaining;

  Deck({this.id, this.shuffled, this.remaining});

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
        id: json['deck_id'],
        shuffled: json['shuffled'],
        remaining: json['remaining']);
  }

  Future<Hand> drawCards(int amount) async {
    final response = await http
        .get('https://deckofcardsapi.com/api/deck/$id/draw/?count=$amount');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      remaining = json['remaining'];
      return Hand(json['cards']);
    } else {
      throw ('Failed to get cards');
    }
  }
}
