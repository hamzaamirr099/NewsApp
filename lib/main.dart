import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/util/bloc/states.dart';
import 'package:news_app/core/util/network/local/cache_helper.dart';
import 'package:news_app/core/util/network/remote/dio_helper.dart';
import 'package:news_app/features/presentations/layout/news_layout_screen.dart';
import 'core/util/bloc/cubit.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //used when the main function is async, which ensures that all the await methods finished before calling runApp
  await CacheHelper.init();

  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit()
            ..changeBrightnessMode()
            ..getNewsData('business'),
        ),
      ],
      child: BlocConsumer<AppCubit, CubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.green,
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  elevation: 10.0,
                ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.green,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
              brightness: Brightness.dark,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.green,
                elevation: 10.0,
              ),
            ),
            themeMode: AppCubit.get(context).currentBrightnessMode
                ? ThemeMode.light
                : ThemeMode.dark,
            home: const NewsLayoutScreen(),
          );
        },
      ),
    );
  }
}
