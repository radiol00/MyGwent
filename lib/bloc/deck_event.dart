part of 'deck_bloc.dart';

abstract class DeckEvent extends Equatable {
  const DeckEvent();
}

class GetNewDeck extends DeckEvent {
  final int amount;
  const GetNewDeck(this.amount);

  @override
  List<Object> get props => [amount];
}
