import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/shared/cubit/cubit.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            LottieBuilder.asset(
              'assets/images/avatar-man.json',
              width: 250,
            ),
            SizedBox(height: 20,),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8,),
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark
                      ? Colors.grey[800]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 5,
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(.1)
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      'Change Theme Color',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Spacer(),
                    Icon(
                      AppCubit.get(context).isDark
                          ? Icons.brightness_2
                          : Icons.wb_sunny,
                      color: AppCubit.get(context).isDark
                          ? Colors.blueGrey
                          : Colors.yellow.shade600,
                    ),
                  ],
                ),
              ),
              onTap: (){
                AppCubit.get(context).changeMode();
              },
            ),

            SizedBox(height: 10,),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8,),
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark
                      ? Colors.grey[800]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 5,
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(.1)
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      'Contact Us',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Spacer(),
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              onTap: (){
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
            ),

            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8,),
              decoration: BoxDecoration(
                color: AppCubit.get(context).isDark
                    ? Colors.grey[800]
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(.1)
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Application Version',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Spacer(),
                  Text(
                    'v1.0.0',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10,),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8,),
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark
                      ? Colors.grey[800]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 5,
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(.1)
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      'Exit',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Spacer(),
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              onTap: (){
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
                          'Exit',
                          style: TextStyle(
                            color: Colors.red,
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
            ),
          ],
        ),
      ),
    );
  }
}
