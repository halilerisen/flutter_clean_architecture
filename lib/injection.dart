import 'package:clean_architecture/2_application/pages/advice/bloc/advicer_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '0_data/datasources/advice_remote_datasource.dart';
import '0_data/repositories/advice_repo_impl.dart';
import '1_domain/repositories/advice_repo.dart';
import '1_domain/usecases/advice_usecases.dart';

final GetIt sl = GetIt.I; // sl = Service AdvicerCubitLocator

Future<void> init() async {
  //! application layer
  // Factory = every time a new/fresh instance of that class.
  sl.registerFactory<AdvicerBloc>(() => AdvicerBloc(adviceUseCases: sl()));

// ! domain Layer
  sl.registerFactory<AdviceUseCases>(() => AdviceUseCases(adviceRepoImpl: sl()));

// ! data Layer
  sl.registerFactory<AdviceRepo>(() => AdviceRepoImpl(adviceRemoteDataSourceImpl: sl()));
  sl.registerFactory<AdviceRemoteDataSource>(() => AdviceRemoteDataSourceImpl(client: sl()));

// ! externs
  sl.registerFactory(() => http.Client());
}
