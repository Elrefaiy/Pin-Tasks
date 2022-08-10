import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var cubit = AppCubit.get(context);
    var formKey = GlobalKey<FormState>();
    var titleController = TextEditingController();
    var bodyController = TextEditingController();
    var timeController = TextEditingController();
    var dateController = TextEditingController();

    Widget colorSelectBuilder(String color, int index, context)=> InkWell(
      onTap: (){
        AppCubit.get(context).selectColor(index);
      },
      highlightColor: null,
      child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              color: HexColor(color),
              width: 60,
              height: 60,
            ),
            if(index == AppCubit.get(context).selectedColor)
              Icon(Icons.done, size: 30,)
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
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: TextFormField(
                        cursorColor: Colors.amber[700],
                        style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                        controller: titleController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Title ..',
                          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 22),
                        ),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        cursorColor: Colors.amber[700],
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
                        controller: bodyController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Write Your Task ..',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),

                    defaultInputField(
                        context: context,
                        title: 'Time',
                        preIcon: Icons.timer_outlined,
                        controller: timeController,
                        type: TextInputType.number,
                        readOnly: true,
                        onTap: () {
                          showTimePicker(
                            context: context,
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  timePickerTheme: TimePickerThemeData(backgroundColor: Colors.white),
                                  primaryColor: Colors.amber[700],
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary
                                  ),
                                  colorScheme: ColorScheme.light(primary:Colors.amber[700]).copyWith(secondary: Colors.amber[700]),
                                ),
                                child: child,
                              );
                            },
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            timeController.text = TimeOfDay(hour: value.hour, minute: value.minute)
                                .format(context);
                          });
                        }),
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
                                    primary: Colors.amber[700],
                                    onPrimary: Colors.white,
                                    surface: Colors.amber[700],
                                    onSurface: Colors.black,
                                  ),
                                  dialogBackgroundColor:Colors.white,
                                ),
                                child: child,
                              );
                            },
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2025-01-01'),
                          ).then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value);
                          });
                        }),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.done,
              size: 37,
              color: Colors.amber[700],
            ),
            onPressed: () {
                cubit.insertToDatabase(
                    title: titleController.text == '' ? 'ToDo!' : titleController.text,
                    body: bodyController.text == '' ? 'Task ..' : bodyController.text,
                    date: dateController.text == '' ? DateFormat.yMMMd().format(DateTime.now()) : dateController.text,
                    time: timeController.text == '' ? '00:00' : timeController.text,
                    color: cubit.taskColor ,
                );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            alignment: AlignmentDirectional.topCenter,
            padding: EdgeInsets.all(20),
            height: 140,
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
