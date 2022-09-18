import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo/modules/home/home.dart';
import 'package:todo/shared/cubit/cubit.dart';

class DashboardScreen extends StatelessWidget {

  Widget gridItem(context, String tasks, String label, Color color) => Container(
    padding: EdgeInsets.all(10),
    width: 150,
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tasks,
          style: TextStyle(
            fontSize: 60,
            color: AppCubit.get(context).isDark
                ? Colors.white
                : Colors.black,
          ),
        ),
        Container(
          width: 50,
          height: 6,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5)
          ),
        ),
        SizedBox(height: 10,),
        Text(
          'Tasks',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {

    List<Widget> gridItems = [
      gridItem(
        context,
        AppCubit.get(context).newTasks.length.toString(),
        'Scheduled',
        Colors.yellow[600],
      ),
      gridItem(
        context,
        AppCubit.get(context).archivedTasks.length.toString(),
        'Archived',
        Colors.blue,
      ),
      gridItem(
        context,
        AppCubit.get(context).trash.length.toString(),
        'Completed',
        Colors.lightGreen,
      ),
      gridItem(
        context,
        HomeScreen.missed.length.toString(),
        'Missed Deadline',
        Colors.red,
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(15),
            width: double.infinity,
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
            child:Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'You can watch your total results here.',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(width: 10,),
                    LottieBuilder.asset(
                      'assets/images/dashboard.json' ,
                      width: 150,
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.all(10),
                ),
                Text(
                  HomeScreen.todayTasks.length < 1
                      ? "No Tasks Due Today"
                      : "Today's Tasks - ${HomeScreen.todayTasks.length}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 36,
                          percent: HomeScreen.todayTasks.length < 1
                              ? 0
                              : HomeScreen.inProgress.length/HomeScreen.todayTasks.length,
                          restartAnimation: true,
                          backgroundColor: Colors.grey.withOpacity(.5),
                          progressColor: Colors.blue,
                          center: Text(
                              HomeScreen.todayTasks.length < 1
                                  ? '0.0%'
                                  : '${((HomeScreen.inProgress.length/HomeScreen.todayTasks.length)*100).round()}%',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'In Progress',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 36,
                          percent: HomeScreen.todayTasks.length < 1
                              ? 0
                              : HomeScreen.scheduled.length/HomeScreen.todayTasks.length,
                          restartAnimation: true,
                          backgroundColor: Colors.grey.withOpacity(.5),
                          progressColor: Colors.yellow.shade600,
                          center: Text(
                              HomeScreen.todayTasks.length < 1
                                  ? '0.0%'
                                  : '${((HomeScreen.scheduled.length/HomeScreen.todayTasks.length)*100).round()}%',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Scheduled',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 36,
                          percent: HomeScreen.todayTasks.length < 1
                              ? 0
                              : HomeScreen.missed.length/HomeScreen.todayTasks.length,
                          restartAnimation: true,
                          backgroundColor: Colors.grey.withOpacity(.5),
                          progressColor: Colors.redAccent,
                          center: Text(
                            HomeScreen.todayTasks.length < 1
                                ? '0.0%'
                                : '${((HomeScreen.missed.length/HomeScreen.todayTasks.length)*100).round()}%',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Missed',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          GridView.count(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: gridItems,
          )
        ],
      ),
    );
  }
}


