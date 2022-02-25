import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,newsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(controller: searchController,
                    inputType: TextInputType.text,
                    validator: (String v){
                      if(v.isEmpty){
                        return 'filed empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    icon: Icons.search,
                    onChange: (value){
                     NewsCubit.get(context).searchData(value);
                    }),
              ),
            state is! NewsSearchErrorState?
             Expanded(
               child: ListView.separated(
                    physics:const BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                    return buildArticleItem(NewsCubit.get(context).search[index],context);
                   }, separatorBuilder: (c,i)=>const Divider(), itemCount:NewsCubit.get(context).search.length ),
             )
                 :const Center(child: CircularProgressIndicator())

            ],
          ),
        );
      },

    );
  }
}
