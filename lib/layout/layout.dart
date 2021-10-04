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
            title: Text(cubit.myTitle[cubit.currentIndex], style: Theme.of(context).textTheme.headline1,),
          ),
          drawer: AppDrawer(),
          body: cubit.screen[cubit.currentIndex],

          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_rounded, size: 37, color: Colors.amber[700],),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTask()));
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(

            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Todo Tasks',
                activeIcon: Icon(Icons.menu_rounded)
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: 'Archived Tasks',
                activeIcon: Icon(Icons.archive)
              ),
            ],
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
