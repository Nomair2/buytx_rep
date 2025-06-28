part of 'router.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: '/auth/phone',
      name: 'phone',
      builder: (context, state) {
        UserRequestEnity user = state.extra as UserRequestEnity;

        return PhonePage(user);
      },
    ),
    //----
    GoRoute(
      path: '/auth/login',
      name: 'login',
      builder: (context, state) => LoginPage(),
    ),
    //----
    GoRoute(
      path: '/auth/signup',
      name: 'register',
      builder: (context, state) => SignupPage(),
    ),
    //-----
    GoRoute(
      path: '/auth/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => ForgetPasswordPage(),
    ),
    //-----
    GoRoute(
      path: '/auth/verify-otp',
      name: 'verify-otp',
      builder:
          (context, state) => VerificationCodePage(
            parameter: state.extra as VerifyOtpParameter,
          ),
    ),
    //----
    GoRoute(
      path: '/home',
      name: HomePage.name,
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: '/detail/productOwnerPage',
      name: ProductOwnerPage.name,
      builder: (context, state) {
        return ProductOwnerPage();
      },
    ),
    GoRoute(
      path: '/detail',
      name: DetailProductPage.name,
      builder: (context, state) {
        return DetailProductPage();
      },
    ),
    GoRoute(
      path: '/auth/new-password',
      name: 'new-password',
      builder: (context, state) {
        return NewPasswordPage();
      },
    ),
    GoRoute(
      path: '/chatsScreen',
      name: AllChatPage.name,
      builder:
          (context, state) => BlocProvider.value(
            value: state.extra as messagesBloc,
            child: AllChatPage(),
          ),
    ),
    GoRoute(
      path: '/messges',
      name: MessagesScreen.name,
      builder: (context, state) {
        final extra = state.extra as MessagesParameterPage;
        return BlocProvider.value(
          value: extra.bloc,
          child: MessagesScreen(userChatEntity: extra.user),
        );
      },
    ),
    GoRoute(
      path: '/cameraPage',
      name: CameraPage.name,
      builder: (context, state) => CameraPage(),
    ),

    GoRoute(
      path: '/caption',
      name: CaptionPage.name,
      builder: (context, state) {
        CaptionParameter captionParameter = state.extra as CaptionParameter;
        return CaptionPage(
          path: captionParameter.imagePath,
          isVideo: captionParameter.isVideo,
          // partnerId: captionParameter.partnerId,
          // partnerName: captionParameter.partnerName,
          // partnerPhoto: captionParameter.partnerPhoto,
        );
      },
    ),

    GoRoute(
      path: '/verificationReqPage',
      name: VerificationReqPage.name,
      builder: (context, state) {
        return VerificationReqPage();
      },
    ),

    //----
    // GoRoute(
    //   path: '/profile',
    //   name: "profile",
    //   builder: (context, state) => const ProfileView(),
    // ),
    //-----
    // GoRoute(
    //   path: '/user_info_tab',
    //   name: "user_info_tab",
    //   builder: (context, state) => const UserInfoTab(),
    // ),
    GoRoute(
      path: '/create_window',
      name: CreateWindow.name,
      builder: (context, state) {
        // final token = state.pathParameters['token']!;
        // return ResetPasswordPage(token: token);
        return const CreateWindow();
      },
    ),
    //---
    GoRoute(
      path: '/edit_password',
      name: 'edit_password',
      builder: (context, state) {
        return const EditPasswordScreen();
      },
    ),
    //---
    GoRoute(
      path: '/follwer_page',
      name: 'follwer_page',
      builder: (context, state) {
        return FollowersPage(index: state.extra as int);
      },
    ),
    GoRoute(
      path: '/profilePage',
      name: ProfilePage.name,
      builder: (context, state) {
        return const ProfilePage();
      },
    ),
    //---
  ],
);

class VerifyOtpParameter {
  String email;
  bool isForgetPassword;
  VerifyOtpParameter(this.email, this.isForgetPassword);
}

class MessagesParameterPage {
  UserChatEntity user;
  messagesBloc bloc;
  MessagesParameterPage({required this.bloc, required this.user});
}

class CaptionParameter {
  String type;
  messagesBloc bloc;
  String? imagePath;
  String? partnerId;
  String? partnerName;
  bool? isVideo;
  String? partnerPhoto;
  CaptionParameter({
    this.imagePath,

    this.partnerId,
    this.isVideo,
    this.partnerName,
    this.partnerPhoto,
    required this.type,
    required this.bloc,
  });
}
