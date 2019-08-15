// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final database = _$AppDatabase();
    database.database = await database.open(name ?? ':memory:', _migrations);
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AppLogDao _appLogDaoInstance;

  SyncDownloadLogicDao _syncDownloadLogicDaoInstance;

  SyncPhotoUploadDao _syncPhotoUploadDaoInstance;

  SyncUploadDao _syncUploadDaoInstance;

  MdPersonDao _mdPersonDaoInstance;

  AppConfigDao _appConfigDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);
      },
      onCreate: (database, _) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `app_log` (`id` TEXT, `versionName` TEXT, `device` TEXT, `type` TEXT, `content` TEXT, `stackTrace` TEXT, `time` TEXT, `note` TEXT, `dirty` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `sync_download_logic` (`tableName` TEXT, `tableOrder` TEXT, `timeStamp` TEXT, `version` TEXT, `isActive` TEXT, `transferred` TEXT, `keys` TEXT, PRIMARY KEY (`tableName`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `sync_upload` (`id` TEXT, `uniqueIdValues` TEXT, `name` TEXT, `type` TEXT, `status` TEXT, `time` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `sync_photo_upload` (`id` TEXT, `filePath` TEXT, `name` TEXT, `type` TEXT, `status` TEXT, `time` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MD_Person` (`id` TEXT, `UserCode` TEXT, `Password` TEXT, `FirstName` TEXT, `LastName` TEXT, `Type` TEXT, `RouteNumber` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `app_config` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userCode` TEXT, `userName` TEXT, `password` TEXT, `env` TEXT, `host` TEXT, `port` TEXT, `isSsl` TEXT, `syncInitFlag` TEXT, `version` TEXT, `lastUpdateTime` TEXT)');
      },
    );
  }

  @override
  AppLogDao get appLogDao {
    return _appLogDaoInstance ??= _$AppLogDao(database, changeListener);
  }

  @override
  SyncDownloadLogicDao get syncDownloadLogicDao {
    return _syncDownloadLogicDaoInstance ??=
        _$SyncDownloadLogicDao(database, changeListener);
  }

  @override
  SyncPhotoUploadDao get syncPhotoUploadDao {
    return _syncPhotoUploadDaoInstance ??=
        _$SyncPhotoUploadDao(database, changeListener);
  }

  @override
  SyncUploadDao get syncUploadDao {
    return _syncUploadDaoInstance ??= _$SyncUploadDao(database, changeListener);
  }

  @override
  MdPersonDao get mdPersonDao {
    return _mdPersonDaoInstance ??= _$MdPersonDao(database, changeListener);
  }

  @override
  AppConfigDao get appConfigDao {
    return _appConfigDaoInstance ??= _$AppConfigDao(database, changeListener);
  }
}

class _$AppLogDao extends AppLogDao {
  _$AppLogDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _appLogEntityInsertionAdapter = InsertionAdapter(
            database,
            'app_log',
            (AppLogEntity item) => <String, dynamic>{
                  'id': item.id,
                  'versionName': item.versionName,
                  'device': item.device,
                  'type': item.type,
                  'content': item.content,
                  'stackTrace': item.stackTrace,
                  'time': item.time,
                  'note': item.note,
                  'dirty': item.dirty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _app_logMapper = (Map<String, dynamic> row) => AppLogEntity(
      row['id'] as String,
      row['versionName'] as String,
      row['device'] as String,
      row['type'] as String,
      row['content'] as String,
      row['stackTrace'] as String,
      row['time'] as String,
      row['note'] as String,
      row['dirty'] as String);

  final InsertionAdapter<AppLogEntity> _appLogEntityInsertionAdapter;

  @override
  Future<List<AppLogEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM app_log',
        mapper: _app_logMapper);
  }

  @override
  Future<AppLogEntity> findEntityById(String id) async {
    return _queryAdapter.query('SELECT * FROM app_log WHERE id = ?',
        arguments: <dynamic>[id], mapper: _app_logMapper);
  }

  @override
  Future<void> insertEntity(AppLogEntity entity) async {
    await _appLogEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }
}

class _$SyncDownloadLogicDao extends SyncDownloadLogicDao {
  _$SyncDownloadLogicDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _syncDownloadLogicEntityInsertionAdapter = InsertionAdapter(
            database,
            'sync_download_logic',
            (SyncDownloadLogicEntity item) => <String, dynamic>{
                  'tableName': item.tableName,
                  'tableOrder': item.tableOrder,
                  'timeStamp': item.timeStamp,
                  'version': item.version,
                  'isActive': item.isActive,
                  'transferred': item.transferred,
                  'keys': item.keys
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _sync_download_logicMapper = (Map<String, dynamic> row) =>
      SyncDownloadLogicEntity(
          row['tableName'] as String,
          row['tableOrder'] as String,
          row['timeStamp'] as String,
          row['version'] as String,
          row['isActive'] as String,
          row['transferred'] as String,
          row['keys'] as String);

  final InsertionAdapter<SyncDownloadLogicEntity>
      _syncDownloadLogicEntityInsertionAdapter;

  @override
  Future<List<SyncDownloadLogicEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM sync_download_logic',
        mapper: _sync_download_logicMapper);
  }

  @override
  Future<SyncDownloadLogicEntity> findEntityById(String tableName) async {
    return _queryAdapter.query(
        'SELECT * FROM sync_download_logic WHERE tableName = ?',
        arguments: <dynamic>[tableName],
        mapper: _sync_download_logicMapper);
  }

  @override
  Future<List<SyncDownloadLogicEntity>> findEntityByVersion(
      String version, String isActive) async {
    return _queryAdapter.queryList(
        'SELECT * FROM sync_download_logic WHERE version = ? AND isActive = ?',
        arguments: <dynamic>[version, isActive],
        mapper: _sync_download_logicMapper);
  }

  @override
  Future<void> insertEntity(SyncDownloadLogicEntity entity) async {
    await _syncDownloadLogicEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }
}

class _$SyncPhotoUploadDao extends SyncPhotoUploadDao {
  _$SyncPhotoUploadDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _syncPhotoUploadEntityInsertionAdapter = InsertionAdapter(
            database,
            'sync_photo_upload',
            (SyncPhotoUploadEntity item) => <String, dynamic>{
                  'id': item.id,
                  'filePath': item.filePath,
                  'name': item.name,
                  'type': item.type,
                  'status': item.status,
                  'time': item.time
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _sync_photo_uploadMapper =
      (Map<String, dynamic> row) => SyncPhotoUploadEntity();

  final InsertionAdapter<SyncPhotoUploadEntity>
      _syncPhotoUploadEntityInsertionAdapter;

  @override
  Future<List<SyncPhotoUploadEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM sync_photo_upload',
        mapper: _sync_photo_uploadMapper);
  }

  @override
  Future<SyncPhotoUploadEntity> findEntityById(String id) async {
    return _queryAdapter.query('SELECT * FROM sync_photo_upload WHERE id = ?',
        arguments: <dynamic>[id], mapper: _sync_photo_uploadMapper);
  }

  @override
  Future<void> insertEntity(SyncPhotoUploadEntity entity) async {
    await _syncPhotoUploadEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }
}

class _$SyncUploadDao extends SyncUploadDao {
  _$SyncUploadDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _syncUploadEntityInsertionAdapter = InsertionAdapter(
            database,
            'sync_upload',
            (SyncUploadEntity item) => <String, dynamic>{
                  'id': item.id,
                  'uniqueIdValues': item.uniqueIdValues,
                  'name': item.name,
                  'type': item.type,
                  'status': item.status,
                  'time': item.time
                }),
        _syncUploadEntityDeletionAdapter = DeletionAdapter(
            database,
            'sync_upload',
            'id',
            (SyncUploadEntity item) => <String, dynamic>{
                  'id': item.id,
                  'uniqueIdValues': item.uniqueIdValues,
                  'name': item.name,
                  'type': item.type,
                  'status': item.status,
                  'time': item.time
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _sync_uploadMapper = (Map<String, dynamic> row) => SyncUploadEntity();

  final InsertionAdapter<SyncUploadEntity> _syncUploadEntityInsertionAdapter;

  final DeletionAdapter<SyncUploadEntity> _syncUploadEntityDeletionAdapter;

  @override
  Future<List<SyncUploadEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM sync_upload',
        mapper: _sync_uploadMapper);
  }

  @override
  Future<SyncUploadEntity> findEntityById(String id) async {
    return _queryAdapter.query('SELECT * FROM sync_upload WHERE id = ?',
        arguments: <dynamic>[id], mapper: _sync_uploadMapper);
  }

  @override
  Future<SyncUploadEntity> findEntityByUniqueIdAndType(
      String unique, String type) async {
    return _queryAdapter.query(
        'SELECT * FROM sync_upload WHERE uniqueIdValues = ? and type = ?',
        arguments: <dynamic>[unique, type],
        mapper: _sync_uploadMapper);
  }

  @override
  Future<void> insertEntity(SyncUploadEntity entity) async {
    await _syncUploadEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<SyncUploadEntity> entityList) {
    return _syncUploadEntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$MdPersonDao extends MdPersonDao {
  _$MdPersonDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _mD_PersonMapper = (Map<String, dynamic> row) => MD_Person_Entity(
      row['id'] as String,
      row['UserCode'] as String,
      row['Password'] as String,
      row['FirstName'] as String,
      row['LastName'] as String,
      row['Type'] as String,
      row['RouteNumber'] as String);

  @override
  Future<List<MD_Person_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM MD_Person',
        mapper: _mD_PersonMapper);
  }

  @override
  Future<MD_Person_Entity> findEntityById(String id) async {
    return _queryAdapter.query('SELECT * FROM MD_Person WHERE id = ?',
        arguments: <dynamic>[id], mapper: _mD_PersonMapper);
  }
}

class _$AppConfigDao extends AppConfigDao {
  _$AppConfigDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _appConfigEntityInsertionAdapter = InsertionAdapter(
            database,
            'app_config',
            (AppConfigEntity item) => <String, dynamic>{
                  'id': item.id,
                  'userCode': item.userCode,
                  'userName': item.userName,
                  'password': item.password,
                  'env': item.env,
                  'host': item.host,
                  'port': item.port,
                  'isSsl': item.isSsl,
                  'syncInitFlag': item.syncInitFlag,
                  'version': item.version,
                  'lastUpdateTime': item.lastUpdateTime
                }),
        _appConfigEntityUpdateAdapter = UpdateAdapter(
            database,
            'app_config',
            'id',
            (AppConfigEntity item) => <String, dynamic>{
                  'id': item.id,
                  'userCode': item.userCode,
                  'userName': item.userName,
                  'password': item.password,
                  'env': item.env,
                  'host': item.host,
                  'port': item.port,
                  'isSsl': item.isSsl,
                  'syncInitFlag': item.syncInitFlag,
                  'version': item.version,
                  'lastUpdateTime': item.lastUpdateTime
                }),
        _appConfigEntityDeletionAdapter = DeletionAdapter(
            database,
            'app_config',
            'id',
            (AppConfigEntity item) => <String, dynamic>{
                  'id': item.id,
                  'userCode': item.userCode,
                  'userName': item.userName,
                  'password': item.password,
                  'env': item.env,
                  'host': item.host,
                  'port': item.port,
                  'isSsl': item.isSsl,
                  'syncInitFlag': item.syncInitFlag,
                  'version': item.version,
                  'lastUpdateTime': item.lastUpdateTime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _app_configMapper = (Map<String, dynamic> row) => AppConfigEntity(
      row['id'] as int,
      row['userCode'] as String,
      row['userName'] as String,
      row['password'] as String,
      row['env'] as String,
      row['host'] as String,
      row['port'] as String,
      row['isSsl'] as String,
      row['syncInitFlag'] as String,
      row['version'] as String,
      row['lastUpdateTime'] as String);

  final InsertionAdapter<AppConfigEntity> _appConfigEntityInsertionAdapter;

  final UpdateAdapter<AppConfigEntity> _appConfigEntityUpdateAdapter;

  final DeletionAdapter<AppConfigEntity> _appConfigEntityDeletionAdapter;

  @override
  Future<List<AppConfigEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM app_config',
        mapper: _app_configMapper);
  }

  @override
  Future<AppConfigEntity> findEntityByUserCode(String userCode) async {
    return _queryAdapter.query('SELECT * FROM app_config WHERE userCode = ?',
        arguments: <dynamic>[userCode], mapper: _app_configMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM app_config WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM app_config');
  }

  @override
  Future<void> insertEntity(AppConfigEntity entity) async {
    await _appConfigEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(AppConfigEntity entity) {
    return _appConfigEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<AppConfigEntity> entityList) {
    return _appConfigEntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}
