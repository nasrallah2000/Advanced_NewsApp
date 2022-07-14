import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shard/Cubit/cubit.dart';
import 'package:newsapp/shard/Cubit/states.dart';
import 'package:newsapp/shard/components/component.dart';

class Search_Screen extends StatelessWidget {

  var searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaulteFormFelid(
                  onTap: (){},
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (String? val){
                    if(val!.isEmpty){
                      return 'Search must not empty';
                    }
                  },
                  context: context,
                  onChange: (val){
                     NewsCubit.get(context).getSearchData(val);
                  },
                  lable:'search',
                  preIcon: Icons.search,
                ),
              ),
              Expanded(
                  child: articalBulider(list, context,isSearch: true)
              ),
            ],
          ),
        );
      },

    );
  }
}
