import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/src/authentication/view/log_in_ui.dart';
import 'package:shop_app/app/src/controlle/view/controlle_ui.dart';
import 'package:shop_app/app/src/on_bording/view/on_bording_ui.dart';
import 'package:shop_app/app/src/start/cubit/start_app_cubit.dart';
import 'package:shop_app/app/src/authentication/logic/cubit/login_cubit.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  @override
  Widget build(BuildContext context) {
    //* To kepp Device orientation portraitUp
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return BlocBuilder<StartAppCubit, StartAppStates>(
      builder: (context, state) {
        if (state is UnAuthenticatedUser) {
          return BlocProvider<LogInCubit>(
            create: (context) => LogInCubit(),
            child: const LogInScreen(),
          );
        } else if (state is AuthenticatedUser) {
          return const ControlleScreen();
        }
        return const OnBordingScreen();
      },
    );
  }
}
