import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_bloc.dart';
import 'package:buytx/src/home/domain/products/bloc/products_bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buytx/core/configs/theme/app_theme.dart';
import 'package:buytx/core/configs/theme/theme_cubit.dart';
import 'package:buytx/core/services/injection_container.dart';
import 'package:buytx/core/services/route/router.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:buytx/src/auth/presentation/bloc/auth/auth_event.dart';

List<CameraDescription> cameras = <CameraDescription>[];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthCheckStatusEvent()),
        ),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<messagesBloc>(create: (context) => messagesBloc()),
        BlocProvider<ProductsBloc>(create: (context) => ProductsBloc()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'BUYTX',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
