part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _cacheInit();
  await _authInit();
  await _chatInit();
}

Future<void> _authInit() async {
  sl
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => SignupUseCase(sl()))
    ..registerLazySingleton(() => VerifyAccountUseCase(sl()))
    ..registerLazySingleton(() => VerifyOtpUseCase(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(sl()),
    )
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(sl()))
    ..registerLazySingleton(http.Client.new);
}

Future<void> _chatInit() async {
  sl
    ..registerLazySingleton(() => GetChatsUseCase(sl()))
    ..registerLazySingleton(() => GetMessagesUseCase(sl()))
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImp(sl()),
    )
    ..registerLazySingleton<ChatRepository>(() => ChatRepositoryImp(sl()));
  // ..registerLazySingleton(http.Client.new);
}

Future<void> _cacheInit() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton(() => CacheHelper(prefs))
    ..registerLazySingleton(() => prefs);
}
