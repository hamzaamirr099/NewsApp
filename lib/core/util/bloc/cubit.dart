import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/util/bloc/states.dart';
import 'package:news_app/core/util/network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';

class AppCubit extends Cubit<CubitStates> {
  AppCubit() : super(InitState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool currentBrightnessMode = true;

  //To store the last bright mode before closing the app to open on the same mode
  bool? brightModeFromShared;

  int screenIndex = 0;

  List<dynamic> businessData = [];
  List<dynamic> sportsData = [];
  List<dynamic> scienceData = [];
  List<dynamic> searchData = [];

  void changeBrightnessMode({bool fromClick = false}) {
    brightModeFromShared = CacheHelper.getData(key: 'isDark');

    if (fromClick) {
      currentBrightnessMode = !currentBrightnessMode;
      CacheHelper.putData(key: 'isDark', value: currentBrightnessMode)
          .then((value) {
        emit(BrightnessModeChanged());
      });
    } else if(brightModeFromShared != null){
      currentBrightnessMode = brightModeFromShared!;
      emit(BrightnessModeChanged());
    }
  }

  void changeNavigationBar(int index) {
    screenIndex = index;
    emit(NavigationBarState());
  }


  void getNewsData(String newsType) {
    emit(LoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': newsType,
      'apiKey': 'a8a121d82bab4cd6954c1cfcf70ad8c4',
    }).then((value) {
      if (newsType == 'business') {
        businessData = value.data['articles'];
      } else if (newsType == 'sports') {
        sportsData = value.data['articles'];
      } else if (newsType == 'science') {
        scienceData = value.data['articles'];
      }

      // print(value.data.runtimeType);
      emit(NewsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(NewsErrorState());
    });
  }


  //https://newsapi.org/v2/everything?q=tesla&apiKey=a8a121d82bab4cd6954c1cfcf70ad8c4
  void getSearchData(String searchQuery) {
    searchData = [];
    emit(LoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
      'q': searchQuery,
      'apiKey': 'a8a121d82bab4cd6954c1cfcf70ad8c4',
    }).then((value) {
      searchData = value.data['articles'];

      emit(SearchSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SearchErrorState());
    });
  }
}
