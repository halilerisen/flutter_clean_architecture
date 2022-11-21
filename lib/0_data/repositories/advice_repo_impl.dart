import 'package:clean_architecture/0_data/datasources/advice_remote_datasource.dart';
import 'package:clean_architecture/0_data/exceptions/exceptions.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failures/failures.dart';
import 'package:clean_architecture/1_domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceRepoImpl implements AdviceRepo {
  final AdviceRemoteDataSourceImpl _adviceRemoteDataSourceImpl;

  AdviceRepoImpl({
    required AdviceRemoteDataSourceImpl adviceRemoteDataSourceImpl,
  }) : _adviceRemoteDataSourceImpl = adviceRemoteDataSourceImpl;
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      var result = await _adviceRemoteDataSourceImpl.getRandomAdviceFromAPI();

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}
