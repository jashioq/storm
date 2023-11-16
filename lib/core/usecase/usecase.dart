import 'package:storm/core/utils/typedef.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithoutPrams<Type> {
  const UseCaseWithoutPrams();

  ResultFuture<Type> call();
}