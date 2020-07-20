import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_api_test/repository/deck_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:card_api_test/model/deck.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  DeckBloc(this.repository) : super(InitialDeckState());

  final DeckRepository repository;

  @override
  Stream<DeckState> mapEventToState(
    DeckEvent event,
  ) async* {
    if (event is GetNewDeck) {
      yield LoadingDeckState();
      try {
        final deck = await repository.fetchDeck(event.amount);
        yield LoadedDeckState(deck);
      } catch (e) {
        yield ErrorDeckState(e.toString());
      }
    }
  }
}
