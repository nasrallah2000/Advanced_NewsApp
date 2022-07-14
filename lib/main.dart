import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/layout/News_App/News_Layout.dart';
import 'package:newsapp/shard/Cubit/cubit.dart';
import 'package:newsapp/shard/Cubit/states.dart';
import 'package:newsapp/shard/network/local/chach_helper.dart';
import 'package:newsapp/shard/network/remote/dio_helper.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
DioHelper.init();
await CachHelper.init();
bool? isDark = CachHelper.getBoolean(key: 'isDark');
if(isDark!) {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          systemNavigationBarColor: HexColor('333739'),
          systemNavigationBarIconBrightness: Brightness.light)
  );
}
else{
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light)
  );
}
runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NewsCubit()..getBusinessData()..getSportsData()..getScincesData()..changeAppMode(fromShared: isDark)),
        ],
        child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state){} ,
        builder: (context, state){
          return   MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme:  AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark

                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                centerTitle: true,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,

                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor('333739'),
                primarySwatch: Colors.deepOrange,
                appBarTheme:  AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    systemNavigationBarColor: HexColor('333739'),
                    systemNavigationBarIconBrightness: Brightness.light,
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,

                  ),
                  backgroundColor:HexColor('333739'),
                  elevation: 0.0,
                  centerTitle: true,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,

                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                ),
                floatingActionButtonTheme:  FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                dividerColor: Colors.grey


            ),
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: SplashScreenView(
              navigateRoute: NewsLayout(),
              duration: 4000,
              imageSize: 170,
              imageSrc: "assets/images/splashNews.jpg",
                text: "News App",
              textType: TextType.TyperAnimatedText,
              textStyle: TextStyle(
                height: 2,
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
              backgroundColor:  Colors.white,
            ),
          );
        },
        ),
    );

  }
}
