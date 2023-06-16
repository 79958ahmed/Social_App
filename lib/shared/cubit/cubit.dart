import 'package:abdulla_mansour/modules/todo_app/ARCHIVED/ARCHIVED.dart';
import 'package:abdulla_mansour/modules/todo_app/DONE_TASKS/DONE_SCREEN.dart';
import 'package:abdulla_mansour/modules/todo_app/TASKS/TASK_SCREEN.dart';
import 'package:abdulla_mansour/shared/cubit/states.dart';
import 'package:abdulla_mansour/shared/network/local/cashe_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';


class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget>screens = [
    TASK_SCREEN(),
    DONE_SCREEN(),
    ARCHIVED_SCREEN(),
  ];
  List<String> titles =
  [
    'tasks',
    'done tasks',
    'archived',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database database;
  List<Map>newTasks = [];
  List<Map>doneTasks = [];
  List<Map>archivedTasks = [];

  void createDatabase() {
    // var databasesPath = await getDatabasesPath();
    // String path = join(databasesPath, 'todo.db');
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT,status TEXT ) ')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

   insertToDatabase({
    @required String title,
    @required String time,
    @required String date,

  }) async
  {
    await database.transaction((txn) {
      txn.rawInsert(
        'INSERT INTO tasks(title,time , date, status) VALUES("$title","$time","$date","new")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDataBase(database);
      }).catchError((error) {
        print('Error when Inserting New Record ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDataBase(database)
  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    emit( AppGeteDatabaseLoadingState());
     database.rawQuery('SELECT * FROM tasks').then((value) {

       value.forEach((element) {
       if(element['status']=='new')
         newTasks.add(element);
       else if(element['status']=='done')
         doneTasks.add(element);
       else
         archivedTasks.add(element);

       });
       emit(AppGeteDatabaseState());
     });;
  }

void updateData({
  @required String status,
   @required int id,

})async
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id],
    ).then((value)
    {
      getDataFromDataBase(database);
      emit(AppUpdateDatabaseState());

    });
  }

  void deleteData({
    @required String status,
    @required int id,

  })async
  {
    database.rawUpdate(
        'DELETE FROM tasks WHERE id = ?', [id]
    ).then((value)
    {
      getDataFromDataBase(database);
      emit(AppDeleteDatabaseState());

    });
  }

  bool isButtomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isButtomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

bool isDark =false;


  void changeAppMode({bool fromShared})
  {
    if(fromShared != null) {
      isDark = fromShared;
    emit(AppChangeModeState());
    }
    else {
      isDark = !isDark;
      CasheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
}
}