import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

var titleController = TextEditingController();
var bodyController = TextEditingController();
var timeController = TextEditingController();
var deadlineController = TextEditingController();
var dateController = TextEditingController();

class AddTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var cubit = AppCubit.get(context);
    var formKey = GlobalKey<FormState>();

    Widget colorSelectBuilder(String color, int index, context)=> InkWell(
      onTap: (){
        AppCubit.get(context).selectColor(index);
      },
      highlightColor: null,
      child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: HexColor(color),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            if(index == AppCubit.get(context).selectedColor)
              Icon(Icons.done, size: 30, color: Colors.black.withOpacity(0.7),)
          ]),
    );


    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add New Task!',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 22)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      child: TextFormField(
                        cursorColor: Colors.blue,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: 24,
                        ),
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Title ..',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        cursorColor: Colors.blue,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
                        controller: bodyController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 15,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Write Your Task ..',
                          hintStyle: TextStyle(
                            color: Colors.grey
                            , fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: defaultInputField(
                              context: context,
                              title: 'Start Time',
                              preIcon: Icons.access_time_rounded,
                              controller: timeController,
                              type: TextInputType.number,
                              readOnly: true,
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  builder: (
                                      BuildContext context,
                                      Widget child,
                                      ) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        timePickerTheme: TimePickerThemeData(
                                          backgroundColor: AppCubit.get(context).isDark
                                              ? Colors.grey[700]
                                              : Colors.grey[100],
                                        ),
                                        primaryColor: Colors.blue,
                                        buttonTheme: ButtonThemeData(
                                          textTheme: ButtonTextTheme.primary,
                                        ),
                                        colorScheme: ColorScheme.light(
                                          primary:Colors.blue,
                                        ).copyWith(
                                          secondary: Colors.blue,
                                        ),
                                      ),
                                      child: child,
                                    );
                                  },
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text = TimeOfDay(
                                    hour: value.hour,
                                    minute: value.minute,
                                  ).format(context);
                                });
                              }),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: defaultInputField(
                              context: context,
                              title: 'Deadline',
                              preIcon: Icons.alarm,
                              controller: deadlineController,
                              type: TextInputType.number,
                              readOnly: true,
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  builder: (
                                      BuildContext context,
                                      Widget child,
                                      ) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        timePickerTheme: TimePickerThemeData(
                                          backgroundColor: AppCubit.get(context).isDark
                                              ? Colors.grey[700]
                                              : Colors.grey[100],
                                        ),
                                        primaryColor: Colors.blue,
                                        buttonTheme: ButtonThemeData(
                                          textTheme: ButtonTextTheme.primary,
                                        ),
                                        colorScheme: ColorScheme.light(
                                          primary:Colors.blue,
                                        ).copyWith(
                                          secondary: Colors.blue,
                                        ),
                                      ),
                                      child: child,
                                    );
                                  },
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  deadlineController.text = TimeOfDay(
                                    hour: value.hour,
                                    minute: value.minute,
                                  ).format(context);
                                });
                              }),
                        ),
                      ],
                    ),

                    defaultInputField(
                        context: context,
                        title: 'Date',
                        preIcon: Icons.date_range_outlined,
                        controller: dateController,
                        type: TextInputType.text,
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.blue,
                                    onPrimary: Colors.white,
                                    surface: Colors.blue,
                                    onSurface: Colors.black,
                                  ),
                                  dialogBackgroundColor:AppCubit.get(context).isDark
                                      ? Colors.grey[700]
                                      : Colors.grey[100],
                                ),
                                child: child,
                              );
                            },
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2040-01-01'),
                          ).then((value) {
                            dateController.text = value.toString().substring(0,11);
                          });
                        }),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            mini: true,
            child: Icon(
              Icons.done,
              size: 25,
            ),
            onPressed: () {
                cubit.insertToDatabase(
                  title: titleController.text == ''
                      ? 'ToDo!'
                      : titleController.text,
                  body: bodyController.text == ''
                      ? 'Task ..'
                      : bodyController.text,
                  date: dateController.text == ''
                      ? DateTime.now().toString().substring(0,11)
                      : dateController.text,
                  startTime: timeController.text == ''
                      ? '00:00'
                      : timeController.text,
                  deadline: deadlineController.text == ''
                      ? '23:59'
                      : deadlineController.text,
                  color: cubit.taskColor ,
                  creationTime: DateFormat.yMMMd().format(DateTime.now()).toString(),
                );

                titleController.text = '';
                bodyController.text = '';
                timeController.text = '';
                deadlineController.text = '';
                dateController.text = '';
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            alignment: AlignmentDirectional.topCenter,
            padding: EdgeInsets.all(20),
            height: 120,
            decoration: BoxDecoration(
              color:cubit.isDark? Colors.grey.withOpacity(.15) : Colors.white,
              boxShadow: [
                if(cubit.isDark == false)
                  BoxShadow(blurRadius:6, color: Colors.grey[200])
              ]
            ),
            child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      colorSelectBuilder(cubit.colors[index], index, context),
                  separatorBuilder: (context, index) => SizedBox(width: 12,),
                  itemCount: cubit.colors.length,
              ),
          ),
        );
      },
    );
  }
}
