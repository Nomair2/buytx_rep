import 'package:equatable/equatable.dart';
import 'package:buytx/core/usercase/usecase.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/auth/data/model/user_request_model.dart';
import 'package:buytx/src/auth/domain/repository/auth_repository.dart';

class VerifyOtpUseCase extends UseCase<void, verifyOtpParams> {
  final AuthRepository _repo;

  VerifyOtpUseCase(this._repo);

  @override
  ResultFuture<void> call(verifyOtpParams params) =>
      _repo.verifyOtp(params.email, params.otp);
}

class verifyOtpParams extends Equatable {
  final String email;
  final String otp;

  const verifyOtpParams({required this.email, required this.otp});

  const verifyOtpParams.empty() : email = 'Test Email', otp = 'Test otp';

  @override
  // TODO: implement props
  List<Object?> get props => [email, otp];
}
