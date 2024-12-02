import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/message.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  DatabaseService._internal();
  factory DatabaseService() => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'chat_app.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            senderUsername TEXT,
            senderIp TEXT,
            senderModelName TEXT,
            receiverUsername TEXT,
            receiverIp TEXT,
            receiverModelName TEXT,
            content TEXT,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  Future<void> saveMessage(Message message) async {
    final db = await database;
    await db.insert(
      'messages',
      {
        'senderUsername': message.senderUsername,
        'senderIp': message.senderIp,
        'senderModelName': message.senderModelName,
        'receiverUsername': message.receiverUsername,
        'receiverIp': message.receiverIp,
        'receiverModelName': message.receiverModelName,
        'content': message.content,
        'timestamp': message.timestamp.toIso8601String(),
      },
    );
  }

  Future<List<Message>> getMessages(String senderUsername, String receiverUsername) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'messages',
      where: '(senderUsername = ? AND receiverUsername = ?) OR (senderUsername = ? AND receiverUsername = ?)',
      whereArgs: [senderUsername, receiverUsername, receiverUsername, senderUsername],
      orderBy: 'timestamp ASC',
    );

    return result.map((row) {
      return Message(
        senderUsername: row['senderUsername'],
        senderIp: row['senderIp'],
        senderModelName: row['senderModelName'],
        receiverUsername: row['receiverUsername'],
        receiverIp: row['receiverIp'],
        receiverModelName: row['receiverModelName'],
        content: row['content'],
        timestamp: DateTime.parse(row['timestamp']),
      );
    }).toList();
  }
}
