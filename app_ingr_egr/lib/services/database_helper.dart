import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_ing_egr/models/transaction.dart' as my_transaction;



class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  Database? _database;

  factory DatabaseHelper(){
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database !=null){
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async{
    String path = join(await getDatabasesPath(), 'transactions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }


  Future<void>  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        category TEXT,
        amount REAL,
        type TEXT,
        date TEXT
      )
    ''');
  }

  Future<void> insertTransaction(my_transaction.Transaction transaction) async {
    final db = await database;
    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  

  Future<List<my_transaction.Transaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i){
      return my_transaction.Transaction(
        id: maps[i]['id'],
        category: maps[i]['category'],
        amount: maps[i]['amount'],
        type: maps[i]['type'] == 'income' ? my_transaction.TransactionType.income : my_transaction.TransactionType.expense,
        date: DateTime.parse(maps[i]['date']),
      );
    });

  }


  Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<void> updateTransaction(my_transaction.Transaction transaction) async {
    final db = await database;
    await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }


}
