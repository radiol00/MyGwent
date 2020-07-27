part of 'hand_bloc.dart';

abstract class HandEvent extends Equatable {
  const HandEvent();
}

class HandAddCard extends HandEvent {
  final Map card;
  const HandAddCard(this.card);

  @override
  List<Object> get props => [card];
}

class HandRemoveCard extends HandEvent {
  final Map card;
  const HandRemoveCard(this.card);

  @override
  List<Object> get props => [card];
}
