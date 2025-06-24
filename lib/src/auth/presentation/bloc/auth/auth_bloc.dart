import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buytx/core/common/singletons/cache.dart';
import 'package:buytx/core/common/singletons/cache_helper.dart';
import 'package:buytx/core/error/failure.dart';
import 'package:buytx/core/services/injection_container.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/auth/domain/entity/userRequest.dart';
import 'package:buytx/src/auth/domain/entity/user_data_enetity.dart';
import 'package:buytx/src/auth/domain/usercase/login.dart';
import 'package:buytx/src/auth/domain/usercase/signup.dart';
import 'package:buytx/src/auth/domain/usercase/verify_account.dart';
import 'package:buytx/src/auth/domain/usercase/verify_otp.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>(_onAuthLoginEvent);
    on<AuthCheckStatusEvent>(_authCheckStatusEvent);
    on<AuthVerifyOtpEvent>(_authVerifyOtpEvent);
    on<AuthSignupEvent>(_onAuthSignupEvent);
    on<AuthInitEvent>(_onAuthInit);
    on<AuthVerifyAccountEvent>(_authVerifyAccountEvent);
    on<AuthReVerifyAccountEvent>(_onAuthReVerifyAccountEvent);
  }

  _onAuthReVerifyAccountEvent(AuthEvent event, Emitter emit) async {
    //
    //this method only for signup page , when the user get his account is not activated yet ,
    //so call this method without change state .
    //

    print("in bloc code 1 ");
    // emit(AuthLoading());
    if (event is AuthReVerifyAccountEvent) {
      print("in bloc code 2 ");
      Either<Failure, void> dataReturn = await sl<VerifyAccountUseCase>().call(
        event.email,
      );
      dataReturn.fold(
        (Failure failuer) {
          print("in bloc code 3 ");
        },
        (_) {
          print("in bloc code 4 ");
        },
      );
    }
    print("in bloc code is not current event ");
  }

  _authVerifyAccountEvent(AuthVerifyAccountEvent event, Emitter emit) async {
    print("in bloc code 1 ");
    emit(AuthLoading());

    print("in bloc code 2 ");

    Either<Failure, void> dataReturn = await sl<VerifyAccountUseCase>().call(
      event.email,
    );
    dataReturn.fold(
      (Failure failuer) {
        print("in bloc code 3 ");
        print("the error is ${failuer.errorMessage}");
        emit(AuthError(failuer.errorMessage));
      },
      (_) {
        print("in bloc code 4 ");
        emit(AuthSuccess());
      },
    );

    // print("in bloc code 1 ");
    // emit(AuthLoading());
    // print("in bloc code 2 ");
    // Either<Failure, void> dataReturn =
    //     await sl<VerifyAccountUseCase>().call(event.email);
    // dataReturn.fold((Failure failuer) {
    //   print("in bloc code 3 ");
    //   emit(AuthError(failuer.errorMessage));
    // }, (_) {
    //   print("in bloc code 4 ");
    //   emit(AuthSuccess());
    // });
    // print("in bloc code is not current event ");
  }

  _onAuthInit(AuthInitEvent event, Emitter emit) {
    emit(AuthInitial());
  }

  _authVerifyOtpEvent(AuthVerifyOtpEvent event, Emitter emit) async {
    print("in bloc code 1 ");
    emit(AuthLoading());
    print("in bloc code 2 ");
    Either<Failure, void> dataReturn = await sl<VerifyOtpUseCase>().call(
      verifyOtpParams(email: event.email, otp: event.otp),
    );
    dataReturn.fold(
      (Failure failuer) {
        print("in bloc code 3 ");
        emit(AuthError(failuer.errorMessage));
      },
      (_) {
        print("in bloc code 4 ");
        emit(AuthSuccess());
      },
    );
    print("in bloc code is not current event ");
  }

  _authCheckStatusEvent(AuthEvent event, Emitter emit) async {
    await Future.delayed(Duration(seconds: 3), () {
      if (event is AuthCheckStatusEvent) {
        print(sl<CacheHelper>().isFirstTime());
        print("the runtime in bloc code for state is ${state.runtimeType}");
        print(emit.runtimeType);
        if (sl<CacheHelper>().isFirstTime()) {
          emit(AuthAuthenticated(''));
          print("the runtime si  ${state.runtimeType}");
        } else {
          emit(AuthUnauthenticated());
          print("the runtime  is ${state.runtimeType}");
        }
      }
    });
  }

  _onAuthLoginEvent(AuthLoginEvent AuthLoginEvent, Emitter emit) async {
    print("in bloc code 1 ");
    emit(AuthLoading());

    print("in bloc code 2 ");
    Either<Failure, UserEntity> dataReturn = await sl<LoginUseCase>().call(
      LoginParams(
        email: AuthLoginEvent.username,
        password: AuthLoginEvent.password,
      ),
    );
    dataReturn.fold(
      (Failure failuer) {
        print("in bloc code 3 ");
        emit(AuthError(failuer.errorMessage));
      },
      (r) {
        print("the id is ${r.userData!.id!}");
        sl<CacheHelper>().cacheSessionToken(r.token!);
        sl<CacheHelper>().cacheUserId(r.userData!.id!);
        print("in bloc code 4 ");
        // print(result);
        // print(sl<CacheHelper>().getSessionToken());
        emit(AuthSuccess());
        print('good');
      },
    );
  }

  _onAuthSignupEvent(AuthSignupEvent authSignupEvent, Emitter emit) async {
    print("in bloc code 1 ");
    emit(AuthLoading());

    print("in bloc code 2 ");
    Either<Failure, void> dataReturn = await sl<SignupUseCase>().call(
      UserRequestEnity(
        email: authSignupEvent.email,
        password: authSignupEvent.password,
        authProvider: authSignupEvent.authprovider,
        fullName: authSignupEvent.fullname,
        phone: authSignupEvent.phone,
        username: authSignupEvent.username,
      ),
    );
    dataReturn.fold(
      (Failure failuer) {
        print("in bloc code 3 ");
        print("the error is ${failuer.errorMessage}");
        emit(AuthError(failuer.errorMessage));
      },
      (_) {
        print("in bloc code 4 ");
        emit(AuthSuccess());
      },
    );
  }

  // @override
  // Stream<AuthState> mapEventToState(AuthEvent event) async* {
  //   if (event is AuthLoginEvent) {
  //     yield AuthLoading();

  //     // Simulate login API call
  //     await Future.delayed(Duration(seconds: 2));

  //     if (event.username == 'user' && event.password == 'password') {
  //       yield AuthAuthenticated('user-id-123');
  //     } else {
  //       yield AuthError('Invalid username or password');
  //     }
  //   }

  //   if (event is AuthSignupEvent) {
  //     yield AuthLoading();

  //     // Simulate signup API call
  //     await Future.delayed(Duration(seconds: 2));

  //     // Simulate sending OTP
  //     yield AuthOtpSent('1234567890');
  //   }

  //   if (event is AuthForgotPasswordEvent) {
  //     yield AuthLoading();

  //     // Simulate password reset process
  //     await Future.delayed(Duration(seconds: 2));

  //     yield AuthPasswordResetSuccess(); // Reset success message
  //   }

  //   if (event is AuthVerifyOtpEvent) {
  //     yield AuthLoading();

  //     // Simulate OTP verification
  //     await Future.delayed(Duration(seconds: 2));

  //     if (event.otp == '123456') {
  //       yield AuthOtpVerified('user-id-123');
  //     } else {
  //       yield AuthError('Invalid OTP');
  //     }
  //   }

  //   if (event is AuthSignupWithGoogleEvent) {
  //     yield AuthLoading();

  //     // Simulate Google signup
  //     await Future.delayed(Duration(seconds: 2));

  //     yield AuthGoogleSignupSuccess('google-user-id-456');
  //   }

  //   if (event is AuthLogoutEvent) {
  //     yield AuthLoading();
  //     await Future.delayed(Duration(seconds: 1));
  //     yield AuthUnauthenticated(); // User logged out
  //   }

  //   if (event is AuthCheckStatusEvent) {
  //     // Check current authentication status
  //     yield AuthUnauthenticated(); // By default, not authenticated
  //   }
  // }
}
