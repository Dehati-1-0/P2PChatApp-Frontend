import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/message.dart';

class DatabaseService {
  final String currentUser;
  static DatabaseService? _instance;
  Database? _database;

  // Private constructor
  DatabaseService._internal({required this.currentUser});

  // Factory constructor to implement singleton pattern
  factory DatabaseService({required String currentUser}) {
    if (_instance == null || _instance!.currentUser != currentUser) {
      _instance = DatabaseService._internal(currentUser: currentUser);
    }
    return _instance!;
  }

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

  Future<List<Map<String, String>>> getConversations(String currentUser) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
        SELECT DISTINCT 
        CASE 
            WHEN senderUsername = ? THEN receiverUsername 
            ELSE senderUsername 
        END AS username,
        CASE 
            WHEN senderUsername = ? THEN receiverModelName 
            ELSE senderModelName 
        END AS modelName
        FROM messages
        WHERE senderUsername = ? OR receiverUsername = ?
    ''', [currentUser, currentUser, currentUser, currentUser]);

    // Map the result into a list of conversations
    return result.map((row) {
      return {
        'username': row['username'] as String,
        'modelName': row['modelName'] as String,
      };
    }).toList();
  }

  Future<void> loadConversations() async {
    final dbService = DatabaseService(currentUser: currentUser);
    List<Map<String, String>> conversations = await dbService.getConversations(currentUser);
    // setState() can be used to update UI based on conversations here if needed.
  }
}
