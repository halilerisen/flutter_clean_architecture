// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/usecases/advice_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdviceUseCases _adviceUseCases;
  AdvicerBloc({
    required AdviceUseCases adviceUseCases,
  })  : _adviceUseCases = adviceUseCases,
        super(AdvicerInitial()) {
    on<AdvicerEvent>((AdvicerEvent event, Emitter<AdvicerState> emit) async {
      emit(AdvicerLoading());

      final AdviceEntity advice = await _adviceUseCases.getAdvice();

      emit(AdvicerLoaded(advice: advice.advice));
    });
  }
}
