import 'package:clean_architecture/0_data/repositories/advice_repo_impl.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdviceUseCases {
  final AdviceRepoImpl _adviceRepoImpl;

  AdviceUseCases({
    required AdviceRepoImpl adviceRepoImpl,
  }) : _adviceRepoImpl = adviceRepoImpl;

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return _adviceRepoImpl.getAdviceFromDataSource();
  }
}
