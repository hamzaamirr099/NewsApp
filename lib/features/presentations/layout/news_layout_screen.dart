import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/util/bloc/cubit.dart';
import 'package:news_app/core/util/bloc/states.dart';
import 'package:news_app/features/presentations/modules/articles/articles_screen.dart';
import 'package:news_app/features/presentations/modules/search/search_screen.dart';

class NewsLayoutScreen extends StatelessWidget {
  const NewsLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, CubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: cubit.screenIndex == 0
                ? const Text("Business News")
                : cubit.screenIndex == 1
                    ? const Text("Sports News")
                    : const Text("Science News"),
            titleSpacing: 20.0,
            actions: [
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
              }, 
                  icon: const Icon(Icons.search),
              ),
              IconButton(
                  onPressed: () {
                    cubit.changeBrightnessMode(fromClick: true);
                  },
                  icon: cubit.currentBrightnessMode
                      ? const Icon(Icons.brightness_2_outlined)
                      : const Icon(Icons.wb_sunny_outlined)),
            ],
          ),
          body: cubit.screenIndex == 0
              ? ArticlesScreen(articlesType: cubit.businessData)
              : cubit.screenIndex == 1
                  ? ArticlesScreen(articlesType: cubit.sportsData)
                  : ArticlesScreen(articlesType: cubit.scienceData),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), label: "Business"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports), label: "Sports"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science_outlined), label: "Science"),
            ],
            onTap: (index) {
              cubit.changeNavigationBar(index);
              if (index == 0 && cubit.businessData.isEmpty) {
                cubit.getNewsData("business");
              } else if (index == 1 && cubit.sportsData.isEmpty) {
                cubit.getNewsData("sports");
              } else if (index == 2 && cubit.scienceData.isEmpty) {
                cubit.getNewsData("science");
              }
              debugPrint(index.toString());
            },
            currentIndex: cubit.screenIndex,
          ),
        );
      },
    );
  }
}
