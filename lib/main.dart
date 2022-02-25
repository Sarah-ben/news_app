import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/shared/block_observer.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helpers.dart';
import 'layout/newslayout.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  dynamic isDark=CacheHelper.getDAta(key: 'isDark');

  BlocOverrides.runZoned(
        () => runApp( MyApp(isDark)),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final  isDark;
   MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
       BlocProvider(create: (BuildContext context)=>NewsCubit()..getBusiness()..getSports()..getScience()..changeAppMode(Dark: isDark),
      child: BlocConsumer<NewsCubit,newsStates>(
        builder: (context,state){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  floatingActionButtonTheme:const FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange
                  ),
                  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.orange,
                      elevation: 20.0
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme:const AppBarTheme(
                    titleSpacing: 20.0,
                      iconTheme: IconThemeData(
                          color: Colors.black
                      ),
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarBrightness: Brightness.dark,
                      ),
                      color: Colors.white,
                      elevation: 0.0
                  )
              ),
              themeMode: NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
              darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor('333739'),
                  primarySwatch: Colors.deepOrange,
                  floatingActionButtonTheme:const FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange,

                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor:HexColor('333739') ,
                      type: BottomNavigationBarType.fixed,
                      unselectedItemColor: Colors.grey,
                      selectedItemColor: Colors.orange,
                      elevation: 20.0

                  ),
                  appBarTheme: AppBarTheme(
                      iconTheme:const IconThemeData(
                          color: Colors.white
                      ),
                      titleTextStyle:const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarBrightness: Brightness.light,
                      ),

                      //didn't work
                      textTheme: TextTheme(
                        bodyText1: TextStyle(
                          color: Colors.white
                        )
                      ),

                      /* textTheme:  TextTheme(
                          bodyText1: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          )
                      ) ,*/
                      backgroundColor: HexColor('333739'),
                      elevation: 0.0
                  )
              ),
              home:Home()
              //we can add directionality to change direction of all app if u re using arabic

          ) ;
        },
        listener: (context,state){},
      ),);

  }
}


