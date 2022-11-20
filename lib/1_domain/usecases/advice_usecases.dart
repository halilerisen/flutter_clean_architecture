import 'package:clean_architecture/1_domain/entities/advice_entity.dart';

class AdviceUseCases {
  Future<AdviceEntity> getAdvice() async {
    await Future.delayed(const Duration(seconds: 3));

    return const AdviceEntity(advice: 'Advice to test', id: 1);
  }
}
