import 'package:sqflite/sqflite.dart' as sql; // Le ponemos el apodo 'sql'
import 'package:path/path.dart';
import '../models/transaction.dart'; // Tu clase queda limpia, sin apodo
class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  sql.Database? _database;

  factory DatabaseHelper(){
    return _instance;
  }

  DatabaseHelper._internal();
  Future<List<Transaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i){
      return Transaction(
        id: maps[i]['id'],
        category: maps[i]['category'],
        amount: maps[i]['amount'],
        type: maps[i]['type'] == 'income' ? TransactionType.income : TransactionType.expense,
        date: DateTime.parse(maps[i]['date']),
      );
    });

  }

  Future<sql.Database> get database async {
    if (_database !=null){
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<sql.Database> _initDatabase() async{
    String path = join(await sql.getDatabasesPath(), 'transactions.db');
    return await sql.openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }


  Future<void>  _onCreate(sql.Database db, int version) async {
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

  Future<void> insertTransaction(Transaction transaction) async {
    final db = await database;
    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
  

  


  Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<void> updateTransaction(Transaction transaction) async {
    final db = await database;
    await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }


}

