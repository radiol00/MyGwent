part of 'units_bloc.dart';

abstract class UnitsEvent extends Equatable {
  const UnitsEvent();
}

class UnitsAdd extends UnitsEvent {
  final Map unit;
  const UnitsAdd(this.unit);
  @override
  List<Object> get props => [unit];
}

class UnitsRemove extends UnitsEvent {
  final Map unit;
  const UnitsRemove(this.unit);
  @override
  List<Object> get props => [unit];
}
