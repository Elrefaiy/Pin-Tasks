import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SfCalendar(
            monthViewSettings: MonthViewSettings(
              monthCellStyle: MonthCellStyle(
                textStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 16,
                ),
                backgroundColor: Colors.grey.withOpacity(.1,),
              ),
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
            view: CalendarView.month,
            headerStyle: CalendarHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: Theme.of(context).textTheme.bodyText1,
                backgroundColor: Colors.blue.withOpacity(.1)
            ),
            viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
            ),
            onTap: (calendar){
              print(calendar.date);
            },
            firstDayOfWeek: 6,
            dataSource: TasksDataSource(getAppointments()),
          ),
        ),
      ],
    );
  }
}

List<Appointment> getAppointments(){
  List<Appointment> tasks = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(Duration(hours: 4));
  tasks.add(
    Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Hello Neighbour',
      color: Colors.grey,
    ),
  );
  tasks.add(
    Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Hello Neighbour',
      color: Colors.redAccent,
    ),
  );
  tasks.add(
    Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Hello Neighbour',
      color: Colors.redAccent,
    ),
  );
  tasks.add(
    Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Hello Neighbour',
      color: Colors.yellow,
    ),
  );
  return tasks;
}

class TasksDataSource extends CalendarDataSource{
  TasksDataSource(List<Appointment> source){
    appointments = source ;
  }

}
