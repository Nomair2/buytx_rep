import 'package:dartz/dartz.dart';
import 'package:buytx/core/error/exceptions.dart';
import 'package:buytx/core/error/failure.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/auth/data/model/user_data_model.dart';
import 'package:buytx/src/auth/data/source/auth_remote_data_source.dart';
import 'package:buytx/src/auth/domain/entity/userRequest.dart';
import 'package:buytx/src/auth/domain/entity/user_data_enetity.dart';
import 'package:buytx/src/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  AuthRepositoryImp(this._authRemoteDataSource);
  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  ResultFuture<UserEntity> login(String email, String password) async {
    print("in bloc repository data 1 ");
    try {
      UserModel userReturn = await _authRemoteDataSource.login(email, password);
      print("in bloc repository data 2 ");
      UserEntity user = formUserModel(userReturn);
      return Right(user);
    } on ServerExceptions catch (e) {
      print("in bloc repository data 3 ");
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> signup(UserRequestEnity user) async {
    try {
      await _authRemoteDataSource.signup(user);
      return const Right(null);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> verifyAccount(String email) async {
    try {
      await _authRemoteDataSource.verifyAccount(email);
      return const Right(null);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> verifyOtp(String email, String otp) async {
    print("in bloc repository data 1 ");
    try {
      print("in bloc repository data 2 ");
      await _authRemoteDataSource.verifyOtp(email, otp);
      return const Right(null);
    } on ServerExceptions catch (e) {
      print("in bloc repository data 3 ");
      return Left(ServerFailure.fromException(e));
    }
  }
}
