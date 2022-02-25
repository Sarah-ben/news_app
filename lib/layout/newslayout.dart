import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/search/search_screen.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsCubit cubit=NewsCubit.get(context);
    return BlocConsumer<NewsCubit,newsStates>(builder: (context,states){
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed:(){
              navigateTo(context, SearchScreen());
            }, icon:const Icon(Icons.search))
            ,
            IconButton(onPressed: (){
              NewsCubit.get(context).changeAppMode();
            }, icon:const Icon(Icons.brightness_4_outlined))
          ],
          title:const Text('News App'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.index,
          items:cubit.bottomItems,
          onTap:(index){
            cubit.changeBottomNAvBar(index);
          },
        ),
        body:cubit.screens[cubit.index] ,
      );
    }, listener: (context,states){});
  }
}
