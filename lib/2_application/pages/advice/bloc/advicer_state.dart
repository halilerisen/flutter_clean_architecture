part of 'advicer_bloc.dart';

@immutable
abstract class AdvicerState extends Equatable {
  const AdvicerState();
  @override
  List<Object?> get props => [];
}

class AdvicerInitial extends AdvicerState {
  const AdvicerInitial();
}

class AdvicerLoading extends AdvicerState {}

class AdvicerLoaded extends AdvicerState {
  final String advice;

  const AdvicerLoaded({
    required this.advice,
  });

  @override
  List<Object?> get props => [advice];
}

class AdvicerError extends AdvicerState {
  final String message;

  const AdvicerError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
