import 'package:equatable/equatable.dart';
import 'package:buytx/core/usercase/usecase.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/auth/domain/entity/userRequest.dart';
import 'package:buytx/src/auth/domain/repository/auth_repository.dart';

class SignupUseCase extends UseCase<void, UserRequestEnity> {
  final AuthRepository _repo;

  SignupUseCase(this._repo);

  @override
  ResultFuture<void> call(UserRequestEnity params) => _repo.signup(params);
}
