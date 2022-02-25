import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/buisiness/buisinessScreen.dart';
import 'package:newsapp/modules/science/scienceScreen.dart';
import 'package:newsapp/modules/sports/sportScreen.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helpers.dart';
class NewsCubit extends Cubit<newsStates> {
  NewsCubit() : super(InitialNews());

  static NewsCubit get(context) => BlocProvider.of(context);
  int index = 0;
  List<Widget> screens = const [BuisinessScreen(), SportScreen(), ScienceScreen()];
  List<dynamic> business=[];
  List<dynamic> science=[];
  List<dynamic> sports=[];

  List<BottomNavigationBarItem> bottomItems =const [
    BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),
  ];
 void changeBottomNAvBar(int i){
    index=i;
   // if(index==1)getSports();
   // if(index==2)getScience();
    emit(changeBottomNAvBarState());
  }


  void getBusiness(){
   emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'sources':'bbc-news'
      ,'apiKey':'84ea11d3f9f94b929df1b79403e94f5c'
    }).then((value) {
      business=value.data['articles'];
      emit(NewsGetBusinessSuceessState());
    }).catchError((onError){
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }


  void getScience(){
   emit(NewsGetScienceLoadingState());
  //if(science.isEmpty){
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'sources':'techcrunch',
      'apiKey':'84ea11d3f9f94b929df1b79403e94f5c'
    }).then((value) {
      science=value.data['articles'];
      emit(NewsGetScienceSuceessState());
    }).catchError((onError){
      emit(NewsGetScienceErrorState(onError.toString()));
    });

    // }
    /*  else{
     emit(NewsGetSportsSuceessState());
   }*/
  }


  void getSports(){
   emit(NewsGetSportsLoadingState());
  // if(sports.isEmpty){
     DioHelper.getData(url: 'v2/top-headlines', query:  {
       'country':'us',
       ' category':'sports',
       'apiKey':'84ea11d3f9f94b929df1b79403e94f5c'
     }).then((value) {
       sports=value.data['articles'];
       emit(NewsGetSportsSuceessState());
     }).catchError((onError){
       emit(NewsGetSportsErrorState(onError.toString()));
     });
  // }
 /*  else{
     emit(NewsGetSportsSuceessState());
   }*/
  }

  bool isDark=false;
  ThemeMode appMode=ThemeMode.dark;

  void changeAppMode({ bool? Dark}){
    if(Dark !=null) {
      isDark=Dark;
      emit(NewsChangeAppTheme());

    } else {
      isDark= !isDark;
      CacheHelper.putData(key: 'isDark', val: isDark).then((value) {
        emit(NewsChangeAppTheme());

      });
    }

  }

  List<dynamic> search=[];

   searchData(String value){
    emit(NewsSearchLoadingState());

    DioHelper.getData(url: 'v2/everything', query:  {
    'q':'$value',
    'apiKey':'84ea11d3f9f94b929df1b79403e94f5c'}).
    then((value) {
     search=value.data['articles'];
     emit(NewsSearchState());
    }).catchError((onError){
    emit(NewsSearchErrorState());
    });
  }
}
