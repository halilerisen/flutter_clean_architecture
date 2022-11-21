import 'package:dartz/dartz.dart';

import '../entities/advice_entity.dart';
import '../failures/failures.dart';
import '../repositories/advice_repo.dart';

class AdviceUseCases {
  final AdviceRepo adviceRepoImpl;

  AdviceUseCases({
    required this.adviceRepoImpl,
  });

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepoImpl.getAdviceFromDataSource();
  }
}
