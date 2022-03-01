// ignore_for_file: avoid_print, empty_catches, avoid_returning_null_for_void, unrelated_type_equality_checks


import 'package:abdallah_flutter_funds/archived_tasks/new_tasks_screen.dart';
import 'package:abdallah_flutter_funds/done_tasks/new_tasks_screen.dart';
import 'package:abdallah_flutter_funds/new_tasks/new_tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  int selectedIndex = 0;
  late Database database;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneScreen(),
    const ArchiveScreen(),
  ];

  Icon fabIcon = const Icon(Icons.add);
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: screens[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          print('s');
          if(fabIcon.icon == Icons.add) {
            setState(() {
              fabIcon = const Icon(Icons.edit);
            });
            scaffoldKey.currentState?.showBottomSheet((context) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value.toString().isEmpty){
                          return 'must not be empty';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              );
            }).closed.then((value){
              setState(() {
                fabIcon = const Icon(Icons.add);
              });
            });
          }
          else{
            if(titleController.text.isNotEmpty){
              insertToDatabase(titleController.text).then((value){
                Navigator.pop(context);
                setState(() {
                  fabIcon = const Icon(Icons.add);
                });
              });
            }
          }
        },
        child: fabIcon,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            selectedIndex = index;

          });
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.done_outlined), label: 'Done'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
        ],
      ),
    );
  }

  void createDatabase() async{
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version){
        print('database is created');
        database.execute('CREATE TABLE tasks ('
            'id INTEGER PRIMARY KEY,'
            'title TEXT,'
            'date TEXT,'
            'time TEXT,'
            'status TEXT'
            ')').then((value){
          print('table is created');
        }).catchError((onError){

        });
      },
      onOpen: (database){
        getDataFromDatabase(database).then((value){
          print(value);
        });
        print('database opened');
    }
    );
  }
  Future<String> getName() async{
    return 'Mousa';
  }
  Future insertToDatabase(String name) async{
   return await database.transaction((txn) async{
      txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES ("$name", "${DateTime.now().toString()}", "${TimeOfDay.now().toString()}", "new")')
          .then((value){
            print('$value inserted successfully');
      }).catchError((onError){
        print(onError.toString() + "kk");
      });
      return null;
    }
    );
  }
  Future<List<Map>> getDataFromDatabase(Database database) async{
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
