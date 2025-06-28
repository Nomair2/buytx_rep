import 'dart:io';

import 'package:buytx/src/chat/presentaion/bloc/videotime/video_time_cubiet.dart';
import 'package:buytx/src/chat/presentaion/pages/camera_page.dart';
import 'package:buytx/src/chat/presentaion/pages/caption_page.dart';
import 'package:buytx/src/eveluatoin/presentation/pages/add_eveluation.dart';
import 'package:buytx/src/eveluatoin/presentation/pages/eveluation_page.dart';
import 'package:buytx/src/notification/presentation/pages/notification_page.dart';
import 'package:buytx/src/report/presentation/pages/report_page.dart';
import 'package:buytx/src/verification/presentation/pages/verification_req_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:buytx/core/common/singletons/cache.dart';
import 'package:buytx/core/common/singletons/cache_helper.dart';
import 'package:buytx/core/services/injection_container.dart';
import 'package:buytx/src/auth/domain/entity/userRequest.dart';
import 'package:buytx/src/auth/presentation/pages/forget_password_page.dart';
import 'package:buytx/src/auth/presentation/pages/login_page.dart';
import 'package:buytx/src/auth/presentation/pages/new_password_page.dart';
import 'package:buytx/src/auth/presentation/pages/phone_page.dart';
import 'package:buytx/src/auth/presentation/pages/signup_page.dart';
import 'package:buytx/src/auth/presentation/pages/splash_page.dart';
import 'package:buytx/src/auth/presentation/pages/verification_code_page.dart';
import 'package:buytx/src/chat/domain/entity/user_chat_entity.dart';
import 'package:buytx/src/chat/presentaion/bloc/chatsocket/socket_bloc.dart';
import 'package:buytx/src/chat/presentaion/bloc/chatsocket/socket_event.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_bloc.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messsages_events.dart';
import 'package:buytx/src/chat/presentaion/pages/all_chat_page.dart';
import 'package:buytx/src/chat/presentaion/pages/messages_page.dart';
import 'package:buytx/src/home/pages/home_page.dart';
import 'package:buytx/src/profile/presentation/pages/dealer_info_tab.dart';

import '../../../src/home/pages/detail_product_page.dart';
import '../../../src/profile/presentation/pages/create_window.dart';
import '../../../src/profile/presentation/pages/edit_password_Screen.dart';
import '../../../src/profile/presentation/pages/followers_page.dart';
import '../../../src/profile/presentation/pages/profile_page.dart';
import '../../../src/home/pages/product_owner_page.dart';

import '../../../src/profile/presentation/pages/create_window.dart';
import '../../../src/profile/presentation/pages/profile_page.dart';
import '../../../src/profile/presentation/pages/edit_password_Screen.dart';
import '../../../src/profile/presentation/pages/followers_page.dart';
import '../../../src/home/pages/product_owner_page.dart';

part 'route.main.dart';
