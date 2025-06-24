import 'package:equatable/equatable.dart';
import 'package:buytx/core/usercase/usecase.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/auth/data/model/user_request_model.dart';
import 'package:buytx/src/auth/domain/repository/auth_repository.dart';

class VerifyAccountUseCase extends UseCase<void, String> {
  final AuthRepository _repo;

  VerifyAccountUseCase(this._repo);

  @override
  ResultFuture<void> call(String params) => _repo.verifyAccount(params);
}
