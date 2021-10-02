import 'package:getx_example/config/queries.dart';
import 'package:getx_example/data/model/cart-product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final dbHelper = DBHelper._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) _database = await initDB();
    return _database;
  }

  Future initDB() async {
    String path = join(await getDatabasesPath(), 'eCommerce.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(CREATE_CART_TABLE_QUERY);
      },
    );
  }

  insertProduct(CartProductModel cartProductModel) async {
    var db = await database;
    await db!.insert(CART_TABLE_NAME, cartProductModel.toMap());
  }

  Future<List<Map<String, Object?>>> fetchAllProducts() async {
    var db = await database;
    return await db!.query(CART_TABLE_NAME);
  }


  updateProduct(CartProductModel cartProductModel) async {
    var db = await database;
    await db!.update(CART_TABLE_NAME, cartProductModel.toMap(), where: '$CART_FIELD_ID = ?', whereArgs: [cartProductModel.id]);
  }

  deleteProduct(int id) async {
    var db = await database;
    await db!.delete(CART_TABLE_NAME, where: '$CART_FIELD_ID = ?', whereArgs: [id]);
  }

  Future<void> deleteAllProducts() async {
    var db = await database;
    await db!.delete(CART_TABLE_NAME);
  }


}
