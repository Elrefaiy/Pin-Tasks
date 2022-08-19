import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/calendar/calendar.dart';
import 'package:todo/modules/dashboard/dashboard.dart';
import 'package:todo/modules/home/home.dart';
import 'package:todo/modules/settings/settings.dart';
import 'package:todo/shared/cubit/states.dart';
import 'package:todo/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  Database database;

  List<Map> newTasks = [];
  List<Map> archivedTasks = [];
  List<Map> trash = [];

  List<String> myTitle = [
    'Home',
    'Calendar',
    'Dashboard',
    'Settings',
  ];

  List<Widget> screen = [
    HomeScreen(),
    CalendarScreen(),
    DashboardScreen(),
    SettingsScreen(),
  ];

  List<String> colors = [
    '#faa466',
    '#D8E79D',
    '#6183cf',
    '#eb9696',
    '#9696eb',
    '#96ebe7',
    '#ffff78',
    '#eb96e4',
    '#ADD8D0',
    '#dbdbdb',
    '#83a88a',
  ];

  bool isDark = true;
  void changeMode({bool mode}) {
    if (mode != null) {
      isDark = mode;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then(
            (value) {
          emit(ChangeModeState());
        },
      );
    }
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(BottomNavBarChangeState());
  }

  int selectedColor = 0;
  String taskColor = '#faa466';

  void selectColor(int index){
    selectedColor = index;
    taskColor = colors[selectedColor];
    emit(SelectColorState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, body TEXT,date TEXT, time TEXT, color TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getData(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  insertToDatabase(
      { @required String title,
        @required String body,
        @required String date,
        @required String time,
        @required String color,
        String status}) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, body, date, time, color, status) VALUES ("$title","$body", "$date", "$time", "$color", "new")')
          .then((value) {
        print('$value Inserted Successfully');
        emit(InsertToDatabaseState());
        getData(database);
      }).catchError((error) =>
              print('Error when inserting new row ${error.toString()}'));
      return null;
    });
  }

  void getData(database) async {
    newTasks = [];
    archivedTasks = [];
    trash = [];
    emit(DatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        }else if (element['status'] == 'archived'){
          archivedTasks.add(element);
      }else{
          trash.add(element);
        }

        print(element);
      });

      emit(GetDataState());
    });
  }

  void updateData({
    @required String status,
    @required int id
  }) async {
    await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getData(database);
      emit(UpdateDataState());
    });
  }

  // void updateTaskStatus({
  //   @required String status,
  //   @required int id
  // }) async {
  //   await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
  //       ['$status', id]).then((value) {
  //     getData(database);
  //     emit(UpdateDataState());
  //   });
  // }
  //
  // void updateTask({
  //   @required String status,
  //   @required int id
  // }) async {
  //   await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
  //       ['$status', id]).then((value) {
  //     getData(database);
  //     emit(UpdateDataState());
  //   });
  // }

  void deleteData({@required int id}) async {
    await database
        .rawUpdate('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getData(database);

      emit(DeleteDataState());
    });
  }

}
