import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/drawer.dart';
import 'package:todo/modules/addtask/add_task.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is InsertToDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              cubit.myTitle[cubit.currentIndex],
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          drawer: AppDrawer(),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: (){
                      AppCubit.get(context).changeIndex(0);
                    },
                    icon: Icon(
                      Icons.grid_view,
                      color: AppCubit.get(context).currentIndex == 0
                          ? Colors.blue
                          : Colors.grey.withOpacity(.5),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeIndex(1);
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: AppCubit.get(context).currentIndex == 1
                          ? Colors.blue
                          : Colors.grey.withOpacity(.5),
                    ),
                  ),
                ),
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder:
                              (context)=> AddTask(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeIndex(2);
                    },
                    icon: Icon(
                      Icons.data_usage_sharp,
                      color: AppCubit.get(context).currentIndex == 2
                          ? Colors.blue
                          : Colors.grey.withOpacity(.5),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeIndex(3);
                    },
                    icon: Icon(
                      Icons.settings_outlined,
                      color: AppCubit.get(context).currentIndex == 3
                          ? Colors.blue
                          : Colors.grey.withOpacity(.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
