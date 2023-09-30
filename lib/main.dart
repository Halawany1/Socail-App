import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/bloc/cubitAuthentication/authentication_cubit.dart';
import 'package:social_app/bloc/cubitLayout/layout_cubit.dart';
import 'package:social_app/bloc/observer_helper.dart';
import 'package:social_app/modules/layout/layout_screen.dart';
import 'package:social_app/shared/component/constants.dart';
import 'package:social_app/shared/component/shared_component.dart';

import 'modules/login_screen.dart';
import 'network/remote/cache_helper.dart';

 Future<void> BackgroundMessageHandler(RemoteMessage message)async {
   print(message.data.toString());
   ShowToast(message: 'on BackgroundMessage', state: ToastState.SUCCESS);
 }
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer=MyBlocObserver();
  // var token=await FirebaseMessaging.instance.getToken();
  // print(token);
  //
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  //   ShowToast(message: 'on Message', state: ToastState.SUCCESS);
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print(event.data.toString());
  //   ShowToast(message: 'on Message Opened App', state: ToastState.SUCCESS);
  // });
  //
  // FirebaseMessaging.onBackgroundMessage(BackgroundMessageHandler);
  await CacheHelper.Init();
  //CacheHelper.DeletAllData();
  Widget widget;
  uId=CacheHelper.GetData(key: 'uId');
  print(uId);
  if(uId!=null){
    widget=LayoutScreen();
  }else{
    widget=LoginScreen();
  }
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
        LayoutCubit()
          ..GetUserData()
          ..GetPosts(),),
        BlocProvider(create: (context) => AuthenticationCubit(),)
      ],
      child: BlocConsumer<LayoutCubit,LayoutState>(
        builder: (context, state) {
          var cubit=context.read<LayoutCubit>();
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            home:AnimatedSplashScreen(
              duration: 2,
              animationDuration: Duration(seconds: 2),
              splashTransition: SplashTransition.slideTransition,
              curve: Curves.fastOutSlowIn,
              splash: 'images/logo.png',
              nextScreen: startWidget,
              backgroundColor: Colors.white,

            ),
            theme: lightTheme,
            themeMode: cubit.mode?ThemeMode.dark:ThemeMode.light,
            darkTheme: darkTheme,

          );
        },
        listener: (context, state) {

        },

      ),
    );
  }
}
