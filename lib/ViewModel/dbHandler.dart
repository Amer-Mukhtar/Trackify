import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/expense.dart';

class myDb{
  Database? _database;

  Future<Database> database()
  async{
    var directory = await getDatabasesPath();
    String path=join(directory,'mydatabase.db');
    _database=await openDatabase(path,version: 1,onCreate: (db, version) {
      db.execute(
        'CREATE Table expenses(id TEXT PRIMARY KEY ,title TEXT,amount INTEGER,date TEXT,category TEXT)'
      );
    },);

  return _database!;
  }

  Future insertRecord(Expense expense)
  async{

    final db=await database();
    await db.insert('expenses',
        {
          'id':expense.id,
      'title':expense.title,
      'amount':expense.amount,
      'date':expense.date.toIso8601String(),
      'category':expense.category
    });
    print('Inserted');
  }

  Future<List<Expense>> getExpenses() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('expenses', orderBy: 'date DESC');
    print('get to db');
    return maps.map((map) => Expense(
      id: map['id'],
      title: map['title'],
        amount: map['amount'] is int
            ? (map['amount'] as int).toDouble()
            : map['amount'] as double,
      date: DateTime.parse(map['date']),
      category: map['category'],
    )).toList();
  }
  Future<void> clearAllExpenses() async {
    var directory = await getDatabasesPath();
    String path=join(directory,'mydatabase.db');
    await deleteDatabase(path);
  }
  Future<void> deleteRecord(String id) async {
    final db = await database();
    int count = await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
    assert(count == 1);
  }
  Future editRecord(Expense expense)
  async{

    final db=await database();
    await db.update('expenses',
        {
          'id':expense.id,
          'title':expense.title,
          'amount':expense.amount,
          'date':expense.date.toIso8601String(),
          'category':expense.category
        },
    where: 'id=?',whereArgs: [expense.id]);
    print('Inserted');
  }



}