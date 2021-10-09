import 'package:kodman_for_gbk_functional/model/person.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PersonDatabase {
  static final PersonDatabase instance = PersonDatabase._init();

  static Database? _database;

  PersonDatabase._init();

  Future<Database> get database async {
  //  print("--------database start");
    if (_database != null) return _database!;
//print("--------database");
    _database = await _initDB('person.db');
   // print("--------database1");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
   // print("--------initDatabse");
    final dbPath = await getDatabasesPath();
   // print("--------initDatabse1");
    final path = join(dbPath, filePath);
   // print("--------initDatabse2");
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
   // print("--------createDatabse");
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
   // print("--------createDatabse1");
   var res= await db.execute('''
CREATE TABLE $tablePersons ( 
 
  ${PersonFields.uuid} $textType,
  ${PersonFields.name} $textType,
  ${PersonFields.lastname} $textType,
  ${PersonFields.email} $textType,
  ${PersonFields.foto} $textType,
  ${PersonFields.largefoto} $textType
  )
''');
   // print("--------createDatabse2 ");
  }

  Future<Person> create(Person person) async {
    //print("--------create person ");
    final db = await instance.database;
   // print("--------create person 1");
     final json = person.toJson();
   // print("--------create person 2");
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tablePersons, person.toJson());
   // print("--------create $person "+id.toString());
    return person;//.copy(id: id);
  }

  // Future<Person> readNote(int id) async {
  //   final db = await instance.database;
  //
  //   final maps = await db.query(
  //     tableNotes,
  //     columns: NoteFields.values,
  //     where: '${NoteFields.id} = ?',
  //     whereArgs: [id],
  //   );
  //
  //   if (maps.isNotEmpty) {
  //     return Note.fromJson(maps.first);
  //   } else {
  //     throw Exception('ID $id not found');
  //   }
  // }

  Future<List<Person>> readAllPersons() async {
    print("--------read ALL From BASE");
    final db = await instance.database;

    //  final orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tablePersons);
   // print('============fromBAse ' + result.length.toString());
    List<Person> list = result.map((map) => Person.fromDB(map)).toList();
    // list.forEach((element) {
    // // print('============fromBAse ' + element.toString());
    // });

    return list;
  }

  Future<int> update(Person person) async {
    final db = await instance.database;

    return db.update(
      tablePersons,
      person.toJson(),
      where: '${PersonFields.uuid} = ?',
      whereArgs: [person.uuid],
    );
  }

  Future<int> delete(String uuid) async {
    final db = await instance.database;

    return await db.delete(
      tablePersons,
      where: '${PersonFields.uuid} = ?',
      whereArgs: [uuid],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
