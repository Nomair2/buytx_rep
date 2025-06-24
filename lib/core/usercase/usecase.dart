import 'package:buytx/core/utils/typedefs.dart';

abstract class UseCase<Type, Params> {
  const UseCase();
  ResultFuture<Type> call(Params params);
}

abstract class UseCaseNoParams<Type, Params> {
  UseCaseNoParams();
  ResultFuture<Type> call();
}
