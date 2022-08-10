import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo/modules/addtask/add_task.dart';
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
          color: AppCubit.get(context).isDark ? Colors.grey[900] : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Row(
                  children: [
                  RotatedBox(
                      quarterTurns: 3,
                      child: Icon(Icons.push_pin_outlined, color: Colors.amber[700], size: 40,),
                  ),
                  Text(' Pin Tasks', style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 24, letterSpacing: 1.5),)
                ],),
              ),
              drawerItem(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> AddTask()),);
                  },
                  context: context,
                  icon: Icons.add_rounded,
                  label: 'Add Task'),
              drawerItem(
                  onTap: (){
                    Navigator.pop(context);
                    AppCubit.get(context).changeIndex(0);
                  },
                  context: context,
                  icon: Icons.list,
                  label: 'Todo Tasks'),
              drawerItem(
                  onTap: (){
                    Navigator.pop(context);
                    AppCubit.get(context).changeIndex(1);
                  },
                  context: context,
                  icon: Icons.archive_outlined,
                  label: 'Archived Tasks'),
              drawerItem(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> TrashScreen()),);
                  },
                  context: context,
                  icon: Icons.delete_outline,
                  label: 'Trash'),
              myDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined, size: 22, color: Colors.amber[700],),
                    Text(' Settings', style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 24),),
                  ],
                ),
              ),
              Row(
                children: [
                  drawerItem(
                      onTap: (){
                        AppCubit.get(context).changeMode();
                      },
                      context: context,
                      icon: Icons.brightness_4_outlined,
                      label: 'Theme Mode'),
                  SizedBox(width: 60,),
                  Text(
                    AppCubit.get(context).isDark? 'Dark Mode' : 'Light Mode',
                    style: TextStyle(color: Colors.grey[600], fontSize: 15),
                  ),
                ],
              ),
              Row(
                children: [
                  drawerItem(
                      onTap: (){
                      },
                      context: context,
                      icon: Icons.language,
                      label: 'Language'),
                  SizedBox(width: 80,),
                  Text(
                    'English (US)',
                    style: TextStyle(color: Colors.grey[600], fontSize: 15),
                  ),
                ],
              ),
              drawerItem(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context)=> AlertDialog(
                        backgroundColor: AppCubit.get(context).isDark? Colors.grey[800] : Colors.white,
                        title: Text('Are you sure ?', style: Theme.of(context).textTheme.headline1.copyWith(fontWeight: FontWeight.w700),),
                        content: Text('you want to exit Pin Tasks application', style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),),
                        actions: [
                          TextButton(
                            onPressed: (){
                              exit(0);
                            },
                            child: Text('Yes', style: TextStyle(color: Colors.amber[700], fontSize: 16, fontFamily: 'Glory'),),
                          ),
                          TextButton(
                            onPressed: (){Navigator.pop(context);},
                            child: Text('No', style: TextStyle(color: Colors.grey, fontSize: 16, fontFamily: 'Glory'),),
                          ),
                        ],
                      ),
                    );
                  },
                  context: context,
                  icon: Icons.exit_to_app_rounded,
                  label: 'EXIT'),
              Spacer(),
              drawerItem(
                  onTap: (){
                  },
                  context: context,
                  icon: Icons.info_outline_rounded,
                  label: 'Ask for help'),
            ],
          ),
        ),
      ),
    );
  }
}
