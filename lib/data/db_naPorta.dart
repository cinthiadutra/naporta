// ignore_for_file: unnecessary_null_comparison, file_names

import 'dart:developer';

import 'package:get/get.dart';
import 'package:naporta/model/pedido.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbNaporta extends GetxService{
   
 String dbName = "naPorta";
  String userTable = "pedidos";

  // Create a singleton instance of the database handler
  static final DbNaporta _instance = DbNaporta._internal();
  factory DbNaporta() => _instance;
  DbNaporta._internal();

  // Declare a database variable
  static Database? _database;

  // Initialize the database
  Future<Database?> get database async {
    if (_database != null) return _database;

    // If _database is null we instantiate it
    _database = await initializeDatabase();
    return _database;
  }

  // Initialize the database by opening a connection and creating tables (if not exists)
  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, dbName);

    return await openDatabase(dbPath, version: 1,
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE $userTable(id INTEGER PRIMARY KEY,pedido TEXT,status TEXT, destinoFinal TEXT,nome TEXT,email TEXT,celular TEXT)");

    });
  }

   // Add a new pedido to the database
  Future<int> addPedido(PedidoModel pedido) async {
    final db = await database;
    int result = await db!.insert(userTable, pedido.toMap());
    return result;
  }
  // Get all pedidos from the database
  Future<List<PedidoModel>> getPedidos() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db!.query(userTable);
    List<PedidoModel> pedidos = [];
    for (var map in maps) {
      pedidos.add(PedidoModel.fromMap(map));
    }
    log(pedidos.toString());
    return pedidos;
  }

   // Update an existing user in the database
  Future<int> updateUser(PedidoModel pedido) async {
    final db = await database;
    int result = await db!
        .update(userTable, pedido.toMap(), where: 'id = ?', whereArgs: [pedido.id]);
    return result;
  }

  // Delete a user from the database
  Future<int> deleteUser(int id) async {
    final db = await database;
    int result = await db!.delete(userTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }
}
