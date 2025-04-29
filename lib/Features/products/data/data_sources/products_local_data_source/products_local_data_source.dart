import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:store_task/Features/products/data/model/product.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ProductsLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'products_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            title TEXT,
            price REAL,
            description TEXT,
            category TEXT,
            image TEXT,
            rating_rate REAL,
            rating_count INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertProducts(List<ProductModel> products) async {
    final db = await database;
    final batch = db.batch();
    final directory = await getApplicationDocumentsDirectory();

    for (final product in products) {
      // Download image
      final response = await http.get(Uri.parse(product.image));
      if (response.statusCode == 200) {
        final imageFile = File('${directory.path}/${product.id}.png');
        await imageFile.writeAsBytes(response.bodyBytes);
        final localImagePath = imageFile.path;

        // Save product with local image path
        final productWithLocalImage = product.copyWith(image: localImagePath);
        batch.insert(
          'products',
          productWithLocalImage.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        // If image fails to download, insert with original URL or handle as needed
        batch.insert(
          'products',
          product.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    await batch.commit(noResult: true);
  }

  Future<List<ProductModel>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        category: maps[i]['category'],
        image: maps[i]['image'],
        ratingRate: maps[i]['rating_rate'],
        ratingCount: maps[i]['rating_count'],
      );
    });
  }

  Future<ProductModel?> getProductById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ProductModel(
        id: maps[0]['id'],
        title: maps[0]['title'],
        price: maps[0]['price'],
        description: maps[0]['description'],
        category: maps[0]['category'],
        image: maps[0]['image'],
        ratingRate: maps[0]['rating_rate'],
        ratingCount: maps[0]['rating_count'],
      );
    }
    return null;
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
    );
    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        category: maps[i]['category'],
        image: maps[i]['image'],
        ratingRate: maps[i]['rating_rate'],
        ratingCount: maps[i]['rating_count'],
      );
    });
  }
}
