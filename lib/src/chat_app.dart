import 'package:chat_app/src/core/app_provider.dart';
import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:chat_app/src/providers/auth_provider.dart';
import 'package:chat_app/src/providers/chat_provider.dart';
import 'package:chat_app/src/services/supa_auth_service.dart';
import 'package:chat_app/src/services/supa_database_service.dart';
import 'package:chat_app/src/services/supa_storage_service.dart';
import 'package:chat_app/src/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth provider
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider(
            SupaAuthService(),
            SupaDataBaseService(),
            SupaStorageService(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => AppProvider(),
        ),

        // chat provider
        ChangeNotifierProvider(
          create: (_) => ChatProvider(
            SupaAuthService(),
            SupaDataBaseService(),
            SupaStorageService(),
          ),
        ),
      ],
      builder: (context, _) => _buildAppWidget(),
    );
  }

  Widget _buildAppWidget() {
    return ScreenUtilInit(
      designSize: const Size(392, 791),
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.lPrimary),
            useMaterial3: true,
          ),
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
