
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shard/Cubit/cubit.dart';
import 'package:newsapp/shard/Cubit/states.dart';
import 'package:newsapp/shard/components/component.dart';

class Business_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;

        return articalBulider(list,context);
      }


    );


  }
}
