import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_api_test/model/hand.dart';
import 'package:equatable/equatable.dart';

part 'hand_event.dart';
part 'hand_state.dart';

class HandBloc extends Bloc<HandEvent, HandState> {
  HandBloc() : super(HandInitial());

  final Hand hand = Hand.empty();

  @override
  Stream<HandState> mapEventToState(
    HandEvent event,
  ) async* {
    print(event);
    yield HandLoading();
    if (event is HandAddCard) {
      hand.cardList.add(event.card);
      yield HandLoaded(hand);
    } else if (event is HandRemoveCard) {
      yield HandLoaded(hand);
    } else if (event is HandError) {
      yield HandError('Failed to operate on hand');
    }
  }
}
