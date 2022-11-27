// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failures/failures.dart';
import 'package:clean_architecture/1_domain/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

const String generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const String serverFailureMessage = 'Ups, API Error. Please try again!';
const String cacheFailureMessage = 'Ups, Cache Failed. Please try again!';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdviceUseCases _adviceUseCases;

  AdvicerBloc({
    required AdviceUseCases adviceUseCases,
  })  : _adviceUseCases = adviceUseCases,
        super(const AdvicerInitial()) {
    on<AdvicerEvent>((AdvicerEvent event, Emitter<AdvicerState> emit) async {
      emit(AdvicerLoading());

      final Either<Failure, AdviceEntity> adviceOrFailure = await _adviceUseCases.getAdvice();
      adviceOrFailure.fold(
        (Failure failure) => emit(AdvicerError(message: _mapFailureToMessage(failure))),
        (AdviceEntity advice) => emit(AdvicerLoaded(advice: advice.advice)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;

      default:
        return generalFailureMessage;
    }
  }
}
