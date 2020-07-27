part of 'hand_bloc.dart';

abstract class HandState extends Equatable {
  const HandState();
}

class HandInitial extends HandState {
  @override
  List<Object> get props => [];
}

class HandLoading extends HandState {
  @override
  List<Object> get props => [];
}

class HandLoaded extends HandState {
  final Hand hand;
  HandLoaded(this.hand);
  @override
  List<Object> get props => [hand];
}

class HandError extends HandState {
  final String msg;
  HandError(this.msg);
  @override
  List<Object> get props => [msg];
}
