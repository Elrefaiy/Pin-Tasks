import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2039),
          onDateChanged: (date){
            print(date.toString());
          },
        ),
      ],
    );
  }
}
