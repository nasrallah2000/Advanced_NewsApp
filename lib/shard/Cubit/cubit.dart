import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/business/business_Screen.dart';
import 'package:newsapp/modules/science/science_Screen.dart';
import 'package:newsapp/modules/sports/Sports_Screen.dart';
import 'package:newsapp/shard/Cubit/states.dart';
import 'package:newsapp/shard/network/local/chach_helper.dart';
import 'package:newsapp/shard/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;
  List<BottomNavigationBarItem> NavItem=[
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: "Business",
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_soccer,
        ),
        label: "Sports",
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science_outlined,
        ),
        label: "Scince",
    ),
  ];

  List<Widget> screens = [
    Business_Screen(),
    Sports_Screen(),
    Science_Screen(),
  ];

  void changeCurrentIndex(value){
    currentIndex =value;
    // if(value==1)
    //   getSportsData();
    // if(value==2)
    //   getScincesData();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusinessData (){
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'0b5639e7e64b43ca9516187db7ca7057'
        }
    ).then((value){
    //  print(value?.data['articles'][0]['title']);
      business = value?.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error));
    });
  }


  List<dynamic> sports = [];
  void getSportsData (){
    emit(NewsGetSportsLoadingState());

    if(sports.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'0b5639e7e64b43ca9516187db7ca7057'
          }
      ).then((value){
        //  print(value?.data['articles'][0]['title']);
        sports = value?.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }
      ).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error));
      });
    }
    else{
      emit(NewsGetScinceSuccessState());
    }


  }


  List<dynamic> scince = [];
  void getScincesData (){
    emit(NewsGetScinceLoadingState());

    if(scince.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'0b5639e7e64b43ca9516187db7ca7057'
          }
      ).then((value){
        //  print(value?.data['articles'][0]['title']);
        scince  = value?.data['articles'];
        print(scince[0]['title']);
        emit(NewsGetScinceSuccessState());
      }
      ).catchError((error){
        print(error.toString());
        emit(NewsGetScinceErrorState(error));
      });
    }
    else{
      emit(NewsGetScinceSuccessState());
    }


  }

  List<dynamic> search = [];
  void getSearchData (String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'0b5639e7e64b43ca9516187db7ca7057'
        }
    ).then((value){
      //  print(value?.data['articles'][0]['title']);
      search  = value!.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error));
    });

  }

  bool isDark = false ;
  void changeAppMode({ bool? fromShared}){

    if(fromShared!=null){
      isDark =fromShared;
      emit(NewsChangeAppThemeState());
    }
    else{
      isDark = !isDark;
      CachHelper.putBoolean(key:'isDark', value: isDark).then((value){
        emit(NewsChangeAppThemeState());
      });
    }

  }


}
