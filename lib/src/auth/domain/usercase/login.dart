import 'package:equatable/equatable.dart';
import 'package:buytx/core/usercase/usecase.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/auth/domain/entity/user_data_enetity.dart';
import 'package:buytx/src/auth/domain/repository/auth_repository.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepository _repo;

  LoginUseCase(this._repo);

  @override
  ResultFuture<UserEntity> call(LoginParams params) {
    print("in Login code 1 ");
    return _repo.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  const LoginParams.empty() : email = 'Test Email', password = 'Test Password';

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
