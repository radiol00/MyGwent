class Deck {
  String id;
  bool shuffled;
  int remaining;
  List<dynamic> cards;

  Deck({this.id, this.shuffled, this.remaining}) {
    cards = [];
  }

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
        id: json['deck_id'],
        shuffled: json['shuffled'],
        remaining: json['remaining']);
  }
}
