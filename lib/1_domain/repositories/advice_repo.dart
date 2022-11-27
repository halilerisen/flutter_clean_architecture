import 'package:dartz/dartz.dart';

import '../1_domain.dart';


abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource();
}
