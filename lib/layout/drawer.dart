import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/modules/addtask/add_task.dart';
import 'package:todo/modules/archivedtasks/archivedtasks.dart';
import 'package:todo/modules/todotasks/todotasks.dart';
import 'package:todo/modules/trash/trash.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: AppCubit.get(context).isDark
              ? Colors.grey[900]
              : Colors.grey[100],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 5,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.push_pin_outlined,
                        color: Colors.blue,
                        size: 40,
                      ),
                      Text(
                        'Pin Tasks',
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontSize: 24, letterSpacing: 1.5),
                      )
                    ],
                  ),
                ),
                drawerMainItem(
                  context: context,
                  onTap: () {
                    Navigator.pop(context);
                    AppCubit.get(context).changeIndex(0);
                  },
                  icon: Icons.grid_view,
                  label: 'Home',
                  isSelected: AppCubit.get(context).currentIndex == 0 ,
                ),

                drawerMainItem(
                  context: context,
                  onTap: () {
                    Navigator.pop(context);
                    AppCubit.get(context).changeIndex(1);
                  },
                  icon: Icons.calendar_today_outlined,
                  label: 'Calendar',
                  isSelected: AppCubit.get(context).currentIndex == 1 ,
                ),

                drawerMainItem(
                  context: context,
                  onTap: () {
                    Navigator.pop(context);
                    AppCubit.get(context).changeIndex(2);
                  },
                  icon: Icons.data_usage_sharp,
                  label: 'Dashboard',
                  isSelected: AppCubit.get(context).currentIndex == 2 ,
                ),

                drawerItem(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTask()),
                    );
                  },
                  context: context,
                  icon: Icons.add_rounded,
                  label: 'Add Task',
                ),
                Row(
                  children: [
                    drawerItem(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodoTasks(),
                          ),
                        );
                      },
                      context: context,
                      icon: Icons.list,
                      label: 'Todo Tasks',
                    ),
                    Spacer(),
                    Text(
                      AppCubit.get(context).newTasks.length.toString(),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16)
                    ),
                    SizedBox(width: 40,),
                  ],
                ),
                Row(
                  children: [
                    drawerItem(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrashScreen(),
                          ),
                        );
                      },
                      context: context,
                      icon: Icons.done_all_rounded,
                      label: 'Done Tasks',
                    ),
                    Spacer(),
                    Text(
                      AppCubit.get(context).trash.length.toString(),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
                    ),
                    SizedBox(width: 40,),
                  ],
                ),
                Row(
                  children: [
                    drawerItem(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArchivedTasks(),
                          ),
                        );
                      },
                      context: context,
                      icon: Icons.archive_outlined,
                      label: 'Archived Tasks',
                    ),
                    Spacer(),
                    Text(
                      AppCubit.get(context).archivedTasks.length.toString(),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
                    ),
                    SizedBox(width: 40,),
                  ],
                ),
                myDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        size: 22,
                        color: Colors.blue,
                      ),
                      Text(
                        ' Settings',
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    drawerItem(
                      onTap: () {},
                      context: context,
                      icon: Icons.brightness_4_outlined,
                      label: 'Change Theme Mode',
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        AppCubit.get(context).changeMode();
                      },
                      child: Stack(
                        alignment: AppCubit.get(context).isDark
                            ? AlignmentDirectional.centerEnd
                            : AlignmentDirectional.centerStart,
                        children: [
                          Container(
                            width: 40,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              AppCubit.get(context).isDark ?
                              Icons.brightness_2 :
                              Icons.wb_sunny_sharp,
                              size: 16,
                              color: AppCubit.get(context).isDark
                                  ? Colors.blueGrey[700]
                                  : Colors.yellow.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 25,),
                  ],
                ),
                drawerItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppCubit.get(context).isDark
                            ? Colors.grey[800]
                            : Colors.white,
                        title: Text(
                          'Are you sure ?',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        content: Text(
                          'you want to exit Pin Tasks application',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 14,
                              ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              exit(0);
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontFamily: 'Glory',
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontFamily: 'Glory',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  context: context,
                  icon: Icons.exit_to_app_rounded,
                  label: 'EXIT',
                ),
                SizedBox(height: 140,),
                drawerItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AboutDialog(
                        applicationIcon: Icon(Icons.access_time_rounded),
                        applicationName: 'PIN TASKS',
                        applicationVersion: 'V1.0.0',
                        applicationLegalese: 'we are happy to know your feedback about us ..',
                        children: [
                          LottieBuilder.asset(
                            'assets/images/contact-us.json',
                          ),
                          Text(
                            'Contact Me Through :',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Gmail - Elrefaiy77@gmail.com',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 16,
                                color: Colors.blue
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                  context: context,
                  icon: Icons.info_outline_rounded,
                  label: 'Ask for help',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
