class Hand {
  Hand(this.cardList);
  Hand.empty() {
    cardList = List<dynamic>();
  }
  List<dynamic> cardList;
}
