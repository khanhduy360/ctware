// ignore_for_file: use_build_context_synchronously
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/home.dart';
import 'package:ctware/screens/login.dart';
import 'package:ctware/services/auth_service.dart';
import 'package:ctware/services/cache_manage.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoadApp extends StatelessWidget {
  const LoadApp({super.key});

  loadingData(BuildContext context) async {
    await CacheManage.loadToken();
    final authService = AuthService(context: context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await authService.getUserApi().then((value) {
      if (value != null) {
        userProvider.setUser(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/LoginScreen.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SplashScreen(
          mainLogo: SizedBox(
              width: 300,
              height: 300,
              child: Image.asset('assets/images/logo.png')),
          nextScreen: const LoadPage(),
          function: () {
            loadingData(context);
          },
        ));
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen(
      {super.key,
      required this.mainLogo,
      required this.nextScreen,
      required this.function});

  final Widget mainLogo;
  final Widget nextScreen;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: mainLogo,
      splashIconSize: 1000,
      function: function(),
      nextScreen: nextScreen,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}

class LoadPage extends StatelessWidget {
  const LoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CacheManage.tokenOnCache == null ? const Login() : const Home();
  }
}
