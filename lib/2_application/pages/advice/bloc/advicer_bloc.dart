// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitial()) {
    on<AdvicerEvent>((AdvicerEvent event, Emitter<AdvicerState> emit) async {
      emit(AdvicerLoading());

      // add business logic
      await Future.delayed(const Duration(seconds: 1));

      emit(AdvicerLoaded(advice: 'advice'));
    });
  }
}
