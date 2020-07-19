part of 'deck_bloc.dart';

abstract class DeckState extends Equatable {
  const DeckState();
}

class InitialDeckState extends DeckState {
  const InitialDeckState();
  @override
  List<Object> get props => [];
}

class LoadingDeckState extends DeckState {
  const LoadingDeckState();
  @override
  List<Object> get props => [];
}

class LoadedDeckState extends DeckState {
  final Deck deck;
  const LoadedDeckState(this.deck);
  @override
  List<Object> get props => [deck];
}

class ErrorDeckState extends DeckState {
  final String message;
  const ErrorDeckState(this.message);
  @override
  List<Object> get props => [message];
}
