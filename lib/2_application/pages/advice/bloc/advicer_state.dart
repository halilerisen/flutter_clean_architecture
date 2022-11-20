part of 'advicer_bloc.dart';

@immutable
abstract class AdvicerState {}

class AdvicerInitial extends AdvicerState {}

class AdvicerLoading extends AdvicerState {}

class AdvicerLoaded extends AdvicerState {
  final String advice;

  AdvicerLoaded({
    required this.advice,
  });
}

class AdvicerError extends AdvicerState {
  final String message;

  AdvicerError({
    required this.message,
  });
}
