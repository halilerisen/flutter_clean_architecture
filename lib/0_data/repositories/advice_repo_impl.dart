import 'package:dartz/dartz.dart';

import '../../1_domain/1_domain.dart';
import '../0_data.dart';

class AdviceRepoImpl implements AdviceRepo {
  final AdviceRemoteDataSource adviceRemoteDataSourceImpl;
  AdviceRepoImpl({
    required this.adviceRemoteDataSourceImpl,
  });

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      var result = await adviceRemoteDataSourceImpl.getRandomAdviceFromAPI();

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}
