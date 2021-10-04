import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class TrashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).trash;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Trash',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          body:taskListBuilder(tasks: tasks, inTrash: true)
        );
      },
    );
  }
}
