import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shard/Cubit/cubit.dart';
import 'package:newsapp/shard/Cubit/states.dart';
import '../../shard/components/component.dart';

class Science_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).scince;

          return articalBulider(list,context);
        }


    );
  }
}
