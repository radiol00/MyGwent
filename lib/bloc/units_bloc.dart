import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_api_test/model/units.dart';
import 'package:equatable/equatable.dart';
import 'package:card_api_test/model/units.dart';

part 'units_event.dart';
part 'units_state.dart';

class UnitsBloc extends Bloc<UnitsEvent, UnitsState> {
  UnitsBloc() : super(UnitsInitial());

  final Units units = Units();

  @override
  Stream<UnitsState> mapEventToState(
    UnitsEvent event,
  ) async* {
    if (event is UnitsAdd) {
      units.warriors.add(event.unit);
      yield UnitsPlayed(units);
    }
  }
}
