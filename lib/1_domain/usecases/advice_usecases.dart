import 'package:dartz/dartz.dart';

import '../1_domain.dart';

class AdviceUseCases {
  final AdviceRepo adviceRepoImpl;

  AdviceUseCases({
    required this.adviceRepoImpl,
  });

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepoImpl.getAdviceFromDataSource();
  }
}
