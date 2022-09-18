import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todo/shared/cubit/cubit.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SfCalendar(
            view: CalendarView.day,
            headerStyle: CalendarHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.bodyText1,
              backgroundColor: Colors.grey.withOpacity(.05),
            ),
            viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
              dateTextStyle:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
            ),
            cellBorderColor: Colors.grey.withOpacity(.7),
            timeSlotViewSettings: TimeSlotViewSettings(
              timeTextStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 14,
                  ),
            ),
            onTap: (calendar) {
              print(calendar.date);
            },
            onLongPress: (calendar) {
              print(calendar.appointments[0]);
            },
            appointmentTextStyle:
                Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: 16,
                    ),
            dataSource: TasksDataSource(getAppointments(context)),
          ),
        ),
      ],
    );
  }
}

List<Appointment> getAppointments(context) {
  List<Appointment> tasks = <Appointment>[];
  AppCubit.get(context).newTasks.forEach((element) {
    tasks.add(
      Appointment(
        startTime: DateTime.parse('${element['date']}${element['startTime']}'),
        endTime: DateTime.parse('${element['date']}${element['deadline']}'),
        subject: element['body'],
        color: HexColor(element['color']),
      ),
    );
  });
  return tasks;
}

class TasksDataSource extends CalendarDataSource {
  TasksDataSource(List<Appointment> source) {
    appointments = source;
  }
}
