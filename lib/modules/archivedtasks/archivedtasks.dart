import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class ArchivedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedTasks;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Archived Tasks',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          body: ConditionalBuilder(
            condition: tasks.length > 0,
            builder: (context)=> taskListBuilder(
              tasks: tasks,
              inTrash: true,
            ),
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    'assets/images/walking-ball.json',
                    width: 200,
                  ),
                  Text(
                    'archive is empty, try to add some ...',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
