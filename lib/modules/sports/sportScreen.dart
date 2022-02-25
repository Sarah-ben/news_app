import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,newsStates>(builder: (context,state){
      return state is! NewsGetSportsLoadingState?
      ListView.separated(itemBuilder: (context,index){
        return buildArticleItem(NewsCubit.get(context).sports[index],context);
      },
          separatorBuilder: (context,index)=>const Divider(color: Colors.blueGrey,endIndent: 20.0,indent: 20.0,),
          itemCount:NewsCubit.get(context).sports.length )
          : const Center(child: CircularProgressIndicator(),);
    }, listener: (context,state){

    });
  }
}
