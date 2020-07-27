part of 'units_bloc.dart';

abstract class UnitsState extends Equatable {
  const UnitsState();
}

class UnitsInitial extends UnitsState {
  @override
  List<Object> get props => [];
}

class UnitsPlayed extends UnitsState {
  final Units units;
  const UnitsPlayed(this.units);
  @override
  List<Object> get props => [units];
}
