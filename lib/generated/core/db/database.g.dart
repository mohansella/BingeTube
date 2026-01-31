// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../core/db/database.dart';

// ignore_for_file: type=lint
class $ChannelsTable extends Channels with TableInfo<$ChannelsTable, Channel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChannelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _etagMeta = const VerificationMeta('etag');
  @override
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _setagMeta = const VerificationMeta('setag');
  @override
  late final GeneratedColumn<String> setag = GeneratedColumn<String>(
    'setag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [createdAt, updatedAt, id, etag, setag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channels';
  @override
  VerificationContext validateIntegrity(
    Insertable<Channel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('etag')) {
      context.handle(
        _etagMeta,
        etag.isAcceptableOrUnknown(data['etag']!, _etagMeta),
      );
    }
    if (data.containsKey('setag')) {
      context.handle(
        _setagMeta,
        setag.isAcceptableOrUnknown(data['setag']!, _setagMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Channel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Channel(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      etag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etag'],
      ),
      setag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setag'],
      ),
    );
  }

  @override
  $ChannelsTable createAlias(String alias) {
    return $ChannelsTable(attachedDatabase, alias);
  }
}

class Channel extends DataClass implements Insertable<Channel> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String? etag;
  final String? setag;
  const Channel({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.etag,
    this.setag,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || etag != null) {
      map['etag'] = Variable<String>(etag);
    }
    if (!nullToAbsent || setag != null) {
      map['setag'] = Variable<String>(setag);
    }
    return map;
  }

  ChannelsCompanion toCompanion(bool nullToAbsent) {
    return ChannelsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      etag: etag == null && nullToAbsent ? const Value.absent() : Value(etag),
      setag: setag == null && nullToAbsent
          ? const Value.absent()
          : Value(setag),
    );
  }

  factory Channel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Channel(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      etag: serializer.fromJson<String?>(json['etag']),
      setag: serializer.fromJson<String?>(json['setag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'etag': serializer.toJson<String?>(etag),
      'setag': serializer.toJson<String?>(setag),
    };
  }

  Channel copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    Value<String?> etag = const Value.absent(),
    Value<String?> setag = const Value.absent(),
  }) => Channel(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    etag: etag.present ? etag.value : this.etag,
    setag: setag.present ? setag.value : this.setag,
  );
  Channel copyWithCompanion(ChannelsCompanion data) {
    return Channel(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      etag: data.etag.present ? data.etag.value : this.etag,
      setag: data.setag.present ? data.setag.value : this.setag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Channel(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('etag: $etag, ')
          ..write('setag: $setag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, id, etag, setag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Channel &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.etag == this.etag &&
          other.setag == this.setag);
}

class ChannelsCompanion extends UpdateCompanion<Channel> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String?> etag;
  final Value<String?> setag;
  final Value<int> rowid;
  const ChannelsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.etag = const Value.absent(),
    this.setag = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    this.etag = const Value.absent(),
    this.setag = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Channel> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? etag,
    Expression<String>? setag,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (etag != null) 'etag': etag,
      if (setag != null) 'setag': setag,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String?>? etag,
    Value<String?>? setag,
    Value<int>? rowid,
  }) {
    return ChannelsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      etag: etag ?? this.etag,
      setag: setag ?? this.setag,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (etag.present) {
      map['etag'] = Variable<String>(etag.value);
    }
    if (setag.present) {
      map['setag'] = Variable<String>(setag.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('etag: $etag, ')
          ..write('setag: $setag, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChannelSnippetsTable extends ChannelSnippets
    with TableInfo<$ChannelSnippetsTable, ChannelSnippet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChannelSnippetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES channels (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    title,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_snippets';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChannelSnippet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelSnippet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelSnippet(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $ChannelSnippetsTable createAlias(String alias) {
    return $ChannelSnippetsTable(attachedDatabase, alias);
  }
}

class ChannelSnippet extends DataClass implements Insertable<ChannelSnippet> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String title;
  final String description;
  const ChannelSnippet({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    return map;
  }

  ChannelSnippetsCompanion toCompanion(bool nullToAbsent) {
    return ChannelSnippetsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      title: Value(title),
      description: Value(description),
    );
  }

  factory ChannelSnippet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelSnippet(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
    };
  }

  ChannelSnippet copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? title,
    String? description,
  }) => ChannelSnippet(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
  );
  ChannelSnippet copyWithCompanion(ChannelSnippetsCompanion data) {
    return ChannelSnippet(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelSnippet(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, id, title, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelSnippet &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description);
}

class ChannelSnippetsCompanion extends UpdateCompanion<ChannelSnippet> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<int> rowid;
  const ChannelSnippetsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelSnippetsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String title,
    required String description,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description);
  static Insertable<ChannelSnippet> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelSnippetsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return ChannelSnippetsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelSnippetsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChannelThumbnailsTable extends ChannelThumbnails
    with TableInfo<$ChannelThumbnailsTable, ChannelThumbnail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChannelThumbnailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES channels (id)',
    ),
  );
  static const VerificationMeta _defaultUrlMeta = const VerificationMeta(
    'defaultUrl',
  );
  @override
  late final GeneratedColumn<String> defaultUrl = GeneratedColumn<String>(
    'default_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediumUrlMeta = const VerificationMeta(
    'mediumUrl',
  );
  @override
  late final GeneratedColumn<String> mediumUrl = GeneratedColumn<String>(
    'medium_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _highUrlMeta = const VerificationMeta(
    'highUrl',
  );
  @override
  late final GeneratedColumn<String> highUrl = GeneratedColumn<String>(
    'high_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    defaultUrl,
    mediumUrl,
    highUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_thumbnails';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChannelThumbnail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('default_url')) {
      context.handle(
        _defaultUrlMeta,
        defaultUrl.isAcceptableOrUnknown(data['default_url']!, _defaultUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_defaultUrlMeta);
    }
    if (data.containsKey('medium_url')) {
      context.handle(
        _mediumUrlMeta,
        mediumUrl.isAcceptableOrUnknown(data['medium_url']!, _mediumUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_mediumUrlMeta);
    }
    if (data.containsKey('high_url')) {
      context.handle(
        _highUrlMeta,
        highUrl.isAcceptableOrUnknown(data['high_url']!, _highUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_highUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelThumbnail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelThumbnail(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      defaultUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_url'],
      )!,
      mediumUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medium_url'],
      )!,
      highUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}high_url'],
      )!,
    );
  }

  @override
  $ChannelThumbnailsTable createAlias(String alias) {
    return $ChannelThumbnailsTable(attachedDatabase, alias);
  }
}

class ChannelThumbnail extends DataClass
    implements Insertable<ChannelThumbnail> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String defaultUrl;
  final String mediumUrl;
  final String highUrl;
  const ChannelThumbnail({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.defaultUrl,
    required this.mediumUrl,
    required this.highUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['default_url'] = Variable<String>(defaultUrl);
    map['medium_url'] = Variable<String>(mediumUrl);
    map['high_url'] = Variable<String>(highUrl);
    return map;
  }

  ChannelThumbnailsCompanion toCompanion(bool nullToAbsent) {
    return ChannelThumbnailsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      defaultUrl: Value(defaultUrl),
      mediumUrl: Value(mediumUrl),
      highUrl: Value(highUrl),
    );
  }

  factory ChannelThumbnail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelThumbnail(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      defaultUrl: serializer.fromJson<String>(json['defaultUrl']),
      mediumUrl: serializer.fromJson<String>(json['mediumUrl']),
      highUrl: serializer.fromJson<String>(json['highUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'defaultUrl': serializer.toJson<String>(defaultUrl),
      'mediumUrl': serializer.toJson<String>(mediumUrl),
      'highUrl': serializer.toJson<String>(highUrl),
    };
  }

  ChannelThumbnail copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? defaultUrl,
    String? mediumUrl,
    String? highUrl,
  }) => ChannelThumbnail(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    defaultUrl: defaultUrl ?? this.defaultUrl,
    mediumUrl: mediumUrl ?? this.mediumUrl,
    highUrl: highUrl ?? this.highUrl,
  );
  ChannelThumbnail copyWithCompanion(ChannelThumbnailsCompanion data) {
    return ChannelThumbnail(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      defaultUrl: data.defaultUrl.present
          ? data.defaultUrl.value
          : this.defaultUrl,
      mediumUrl: data.mediumUrl.present ? data.mediumUrl.value : this.mediumUrl,
      highUrl: data.highUrl.present ? data.highUrl.value : this.highUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelThumbnail(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('defaultUrl: $defaultUrl, ')
          ..write('mediumUrl: $mediumUrl, ')
          ..write('highUrl: $highUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, defaultUrl, mediumUrl, highUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelThumbnail &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.defaultUrl == this.defaultUrl &&
          other.mediumUrl == this.mediumUrl &&
          other.highUrl == this.highUrl);
}

class ChannelThumbnailsCompanion extends UpdateCompanion<ChannelThumbnail> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> defaultUrl;
  final Value<String> mediumUrl;
  final Value<String> highUrl;
  final Value<int> rowid;
  const ChannelThumbnailsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.defaultUrl = const Value.absent(),
    this.mediumUrl = const Value.absent(),
    this.highUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelThumbnailsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String defaultUrl,
    required String mediumUrl,
    required String highUrl,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       defaultUrl = Value(defaultUrl),
       mediumUrl = Value(mediumUrl),
       highUrl = Value(highUrl);
  static Insertable<ChannelThumbnail> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? defaultUrl,
    Expression<String>? mediumUrl,
    Expression<String>? highUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (defaultUrl != null) 'default_url': defaultUrl,
      if (mediumUrl != null) 'medium_url': mediumUrl,
      if (highUrl != null) 'high_url': highUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelThumbnailsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? defaultUrl,
    Value<String>? mediumUrl,
    Value<String>? highUrl,
    Value<int>? rowid,
  }) {
    return ChannelThumbnailsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      defaultUrl: defaultUrl ?? this.defaultUrl,
      mediumUrl: mediumUrl ?? this.mediumUrl,
      highUrl: highUrl ?? this.highUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (defaultUrl.present) {
      map['default_url'] = Variable<String>(defaultUrl.value);
    }
    if (mediumUrl.present) {
      map['medium_url'] = Variable<String>(mediumUrl.value);
    }
    if (highUrl.present) {
      map['high_url'] = Variable<String>(highUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelThumbnailsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('defaultUrl: $defaultUrl, ')
          ..write('mediumUrl: $mediumUrl, ')
          ..write('highUrl: $highUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChannelContentDetailsTable extends ChannelContentDetails
    with TableInfo<$ChannelContentDetailsTable, ChannelContentDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChannelContentDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES channels (id)',
    ),
  );
  static const VerificationMeta _likesPlaylistMeta = const VerificationMeta(
    'likesPlaylist',
  );
  @override
  late final GeneratedColumn<String> likesPlaylist = GeneratedColumn<String>(
    'likes_playlist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uploadPlaylistMeta = const VerificationMeta(
    'uploadPlaylist',
  );
  @override
  late final GeneratedColumn<String> uploadPlaylist = GeneratedColumn<String>(
    'upload_playlist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    likesPlaylist,
    uploadPlaylist,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_content_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChannelContentDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('likes_playlist')) {
      context.handle(
        _likesPlaylistMeta,
        likesPlaylist.isAcceptableOrUnknown(
          data['likes_playlist']!,
          _likesPlaylistMeta,
        ),
      );
    }
    if (data.containsKey('upload_playlist')) {
      context.handle(
        _uploadPlaylistMeta,
        uploadPlaylist.isAcceptableOrUnknown(
          data['upload_playlist']!,
          _uploadPlaylistMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelContentDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelContentDetail(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      likesPlaylist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}likes_playlist'],
      ),
      uploadPlaylist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upload_playlist'],
      ),
    );
  }

  @override
  $ChannelContentDetailsTable createAlias(String alias) {
    return $ChannelContentDetailsTable(attachedDatabase, alias);
  }
}

class ChannelContentDetail extends DataClass
    implements Insertable<ChannelContentDetail> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String? likesPlaylist;
  final String? uploadPlaylist;
  const ChannelContentDetail({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.likesPlaylist,
    this.uploadPlaylist,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || likesPlaylist != null) {
      map['likes_playlist'] = Variable<String>(likesPlaylist);
    }
    if (!nullToAbsent || uploadPlaylist != null) {
      map['upload_playlist'] = Variable<String>(uploadPlaylist);
    }
    return map;
  }

  ChannelContentDetailsCompanion toCompanion(bool nullToAbsent) {
    return ChannelContentDetailsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      likesPlaylist: likesPlaylist == null && nullToAbsent
          ? const Value.absent()
          : Value(likesPlaylist),
      uploadPlaylist: uploadPlaylist == null && nullToAbsent
          ? const Value.absent()
          : Value(uploadPlaylist),
    );
  }

  factory ChannelContentDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelContentDetail(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      likesPlaylist: serializer.fromJson<String?>(json['likesPlaylist']),
      uploadPlaylist: serializer.fromJson<String?>(json['uploadPlaylist']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'likesPlaylist': serializer.toJson<String?>(likesPlaylist),
      'uploadPlaylist': serializer.toJson<String?>(uploadPlaylist),
    };
  }

  ChannelContentDetail copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    Value<String?> likesPlaylist = const Value.absent(),
    Value<String?> uploadPlaylist = const Value.absent(),
  }) => ChannelContentDetail(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    likesPlaylist: likesPlaylist.present
        ? likesPlaylist.value
        : this.likesPlaylist,
    uploadPlaylist: uploadPlaylist.present
        ? uploadPlaylist.value
        : this.uploadPlaylist,
  );
  ChannelContentDetail copyWithCompanion(ChannelContentDetailsCompanion data) {
    return ChannelContentDetail(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      likesPlaylist: data.likesPlaylist.present
          ? data.likesPlaylist.value
          : this.likesPlaylist,
      uploadPlaylist: data.uploadPlaylist.present
          ? data.uploadPlaylist.value
          : this.uploadPlaylist,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelContentDetail(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('likesPlaylist: $likesPlaylist, ')
          ..write('uploadPlaylist: $uploadPlaylist')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, likesPlaylist, uploadPlaylist);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelContentDetail &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.likesPlaylist == this.likesPlaylist &&
          other.uploadPlaylist == this.uploadPlaylist);
}

class ChannelContentDetailsCompanion
    extends UpdateCompanion<ChannelContentDetail> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String?> likesPlaylist;
  final Value<String?> uploadPlaylist;
  final Value<int> rowid;
  const ChannelContentDetailsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.likesPlaylist = const Value.absent(),
    this.uploadPlaylist = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelContentDetailsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    this.likesPlaylist = const Value.absent(),
    this.uploadPlaylist = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<ChannelContentDetail> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? likesPlaylist,
    Expression<String>? uploadPlaylist,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (likesPlaylist != null) 'likes_playlist': likesPlaylist,
      if (uploadPlaylist != null) 'upload_playlist': uploadPlaylist,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelContentDetailsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String?>? likesPlaylist,
    Value<String?>? uploadPlaylist,
    Value<int>? rowid,
  }) {
    return ChannelContentDetailsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      likesPlaylist: likesPlaylist ?? this.likesPlaylist,
      uploadPlaylist: uploadPlaylist ?? this.uploadPlaylist,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (likesPlaylist.present) {
      map['likes_playlist'] = Variable<String>(likesPlaylist.value);
    }
    if (uploadPlaylist.present) {
      map['upload_playlist'] = Variable<String>(uploadPlaylist.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelContentDetailsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('likesPlaylist: $likesPlaylist, ')
          ..write('uploadPlaylist: $uploadPlaylist, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChannelStatisticsTable extends ChannelStatistics
    with TableInfo<$ChannelStatisticsTable, ChannelStatistic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChannelStatisticsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES channels (id)',
    ),
  );
  static const VerificationMeta _viewCountMeta = const VerificationMeta(
    'viewCount',
  );
  @override
  late final GeneratedColumn<int> viewCount = GeneratedColumn<int>(
    'view_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subscriberCountMeta = const VerificationMeta(
    'subscriberCount',
  );
  @override
  late final GeneratedColumn<int> subscriberCount = GeneratedColumn<int>(
    'subscriber_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hiddenSubscriberCountMeta =
      const VerificationMeta('hiddenSubscriberCount');
  @override
  late final GeneratedColumn<bool> hiddenSubscriberCount =
      GeneratedColumn<bool>(
        'hidden_subscriber_count',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("hidden_subscriber_count" IN (0, 1))',
        ),
      );
  static const VerificationMeta _videoCountMeta = const VerificationMeta(
    'videoCount',
  );
  @override
  late final GeneratedColumn<int> videoCount = GeneratedColumn<int>(
    'video_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    viewCount,
    subscriberCount,
    hiddenSubscriberCount,
    videoCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_statistics';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChannelStatistic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('view_count')) {
      context.handle(
        _viewCountMeta,
        viewCount.isAcceptableOrUnknown(data['view_count']!, _viewCountMeta),
      );
    } else if (isInserting) {
      context.missing(_viewCountMeta);
    }
    if (data.containsKey('subscriber_count')) {
      context.handle(
        _subscriberCountMeta,
        subscriberCount.isAcceptableOrUnknown(
          data['subscriber_count']!,
          _subscriberCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subscriberCountMeta);
    }
    if (data.containsKey('hidden_subscriber_count')) {
      context.handle(
        _hiddenSubscriberCountMeta,
        hiddenSubscriberCount.isAcceptableOrUnknown(
          data['hidden_subscriber_count']!,
          _hiddenSubscriberCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hiddenSubscriberCountMeta);
    }
    if (data.containsKey('video_count')) {
      context.handle(
        _videoCountMeta,
        videoCount.isAcceptableOrUnknown(data['video_count']!, _videoCountMeta),
      );
    } else if (isInserting) {
      context.missing(_videoCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelStatistic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelStatistic(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      viewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}view_count'],
      )!,
      subscriberCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subscriber_count'],
      )!,
      hiddenSubscriberCount: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hidden_subscriber_count'],
      )!,
      videoCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}video_count'],
      )!,
    );
  }

  @override
  $ChannelStatisticsTable createAlias(String alias) {
    return $ChannelStatisticsTable(attachedDatabase, alias);
  }
}

class ChannelStatistic extends DataClass
    implements Insertable<ChannelStatistic> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final int viewCount;
  final int subscriberCount;
  final bool hiddenSubscriberCount;
  final int videoCount;
  const ChannelStatistic({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.viewCount,
    required this.subscriberCount,
    required this.hiddenSubscriberCount,
    required this.videoCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['view_count'] = Variable<int>(viewCount);
    map['subscriber_count'] = Variable<int>(subscriberCount);
    map['hidden_subscriber_count'] = Variable<bool>(hiddenSubscriberCount);
    map['video_count'] = Variable<int>(videoCount);
    return map;
  }

  ChannelStatisticsCompanion toCompanion(bool nullToAbsent) {
    return ChannelStatisticsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      viewCount: Value(viewCount),
      subscriberCount: Value(subscriberCount),
      hiddenSubscriberCount: Value(hiddenSubscriberCount),
      videoCount: Value(videoCount),
    );
  }

  factory ChannelStatistic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelStatistic(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      viewCount: serializer.fromJson<int>(json['viewCount']),
      subscriberCount: serializer.fromJson<int>(json['subscriberCount']),
      hiddenSubscriberCount: serializer.fromJson<bool>(
        json['hiddenSubscriberCount'],
      ),
      videoCount: serializer.fromJson<int>(json['videoCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'viewCount': serializer.toJson<int>(viewCount),
      'subscriberCount': serializer.toJson<int>(subscriberCount),
      'hiddenSubscriberCount': serializer.toJson<bool>(hiddenSubscriberCount),
      'videoCount': serializer.toJson<int>(videoCount),
    };
  }

  ChannelStatistic copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    int? viewCount,
    int? subscriberCount,
    bool? hiddenSubscriberCount,
    int? videoCount,
  }) => ChannelStatistic(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    viewCount: viewCount ?? this.viewCount,
    subscriberCount: subscriberCount ?? this.subscriberCount,
    hiddenSubscriberCount: hiddenSubscriberCount ?? this.hiddenSubscriberCount,
    videoCount: videoCount ?? this.videoCount,
  );
  ChannelStatistic copyWithCompanion(ChannelStatisticsCompanion data) {
    return ChannelStatistic(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      viewCount: data.viewCount.present ? data.viewCount.value : this.viewCount,
      subscriberCount: data.subscriberCount.present
          ? data.subscriberCount.value
          : this.subscriberCount,
      hiddenSubscriberCount: data.hiddenSubscriberCount.present
          ? data.hiddenSubscriberCount.value
          : this.hiddenSubscriberCount,
      videoCount: data.videoCount.present
          ? data.videoCount.value
          : this.videoCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelStatistic(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('viewCount: $viewCount, ')
          ..write('subscriberCount: $subscriberCount, ')
          ..write('hiddenSubscriberCount: $hiddenSubscriberCount, ')
          ..write('videoCount: $videoCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    viewCount,
    subscriberCount,
    hiddenSubscriberCount,
    videoCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelStatistic &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.viewCount == this.viewCount &&
          other.subscriberCount == this.subscriberCount &&
          other.hiddenSubscriberCount == this.hiddenSubscriberCount &&
          other.videoCount == this.videoCount);
}

class ChannelStatisticsCompanion extends UpdateCompanion<ChannelStatistic> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<int> viewCount;
  final Value<int> subscriberCount;
  final Value<bool> hiddenSubscriberCount;
  final Value<int> videoCount;
  final Value<int> rowid;
  const ChannelStatisticsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.subscriberCount = const Value.absent(),
    this.hiddenSubscriberCount = const Value.absent(),
    this.videoCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelStatisticsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required int viewCount,
    required int subscriberCount,
    required bool hiddenSubscriberCount,
    required int videoCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       viewCount = Value(viewCount),
       subscriberCount = Value(subscriberCount),
       hiddenSubscriberCount = Value(hiddenSubscriberCount),
       videoCount = Value(videoCount);
  static Insertable<ChannelStatistic> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<int>? viewCount,
    Expression<int>? subscriberCount,
    Expression<bool>? hiddenSubscriberCount,
    Expression<int>? videoCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (viewCount != null) 'view_count': viewCount,
      if (subscriberCount != null) 'subscriber_count': subscriberCount,
      if (hiddenSubscriberCount != null)
        'hidden_subscriber_count': hiddenSubscriberCount,
      if (videoCount != null) 'video_count': videoCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelStatisticsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<int>? viewCount,
    Value<int>? subscriberCount,
    Value<bool>? hiddenSubscriberCount,
    Value<int>? videoCount,
    Value<int>? rowid,
  }) {
    return ChannelStatisticsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      viewCount: viewCount ?? this.viewCount,
      subscriberCount: subscriberCount ?? this.subscriberCount,
      hiddenSubscriberCount:
          hiddenSubscriberCount ?? this.hiddenSubscriberCount,
      videoCount: videoCount ?? this.videoCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (viewCount.present) {
      map['view_count'] = Variable<int>(viewCount.value);
    }
    if (subscriberCount.present) {
      map['subscriber_count'] = Variable<int>(subscriberCount.value);
    }
    if (hiddenSubscriberCount.present) {
      map['hidden_subscriber_count'] = Variable<bool>(
        hiddenSubscriberCount.value,
      );
    }
    if (videoCount.present) {
      map['video_count'] = Variable<int>(videoCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelStatisticsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('viewCount: $viewCount, ')
          ..write('subscriberCount: $subscriberCount, ')
          ..write('hiddenSubscriberCount: $hiddenSubscriberCount, ')
          ..write('videoCount: $videoCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChannelStatusesTable extends ChannelStatuses
    with TableInfo<$ChannelStatusesTable, ChannelStatuse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChannelStatusesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES channels (id)',
    ),
  );
  static const VerificationMeta _privacyStatusMeta = const VerificationMeta(
    'privacyStatus',
  );
  @override
  late final GeneratedColumn<String> privacyStatus = GeneratedColumn<String>(
    'privacy_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isLinkedMeta = const VerificationMeta(
    'isLinked',
  );
  @override
  late final GeneratedColumn<bool> isLinked = GeneratedColumn<bool>(
    'is_linked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_linked" IN (0, 1))',
    ),
  );
  static const VerificationMeta _longUploadsStatusMeta = const VerificationMeta(
    'longUploadsStatus',
  );
  @override
  late final GeneratedColumn<String> longUploadsStatus =
      GeneratedColumn<String>(
        'long_uploads_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _madeForKidsMeta = const VerificationMeta(
    'madeForKids',
  );
  @override
  late final GeneratedColumn<bool> madeForKids = GeneratedColumn<bool>(
    'made_for_kids',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("made_for_kids" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    privacyStatus,
    isLinked,
    longUploadsStatus,
    madeForKids,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_statuses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChannelStatuse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('privacy_status')) {
      context.handle(
        _privacyStatusMeta,
        privacyStatus.isAcceptableOrUnknown(
          data['privacy_status']!,
          _privacyStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_privacyStatusMeta);
    }
    if (data.containsKey('is_linked')) {
      context.handle(
        _isLinkedMeta,
        isLinked.isAcceptableOrUnknown(data['is_linked']!, _isLinkedMeta),
      );
    } else if (isInserting) {
      context.missing(_isLinkedMeta);
    }
    if (data.containsKey('long_uploads_status')) {
      context.handle(
        _longUploadsStatusMeta,
        longUploadsStatus.isAcceptableOrUnknown(
          data['long_uploads_status']!,
          _longUploadsStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_longUploadsStatusMeta);
    }
    if (data.containsKey('made_for_kids')) {
      context.handle(
        _madeForKidsMeta,
        madeForKids.isAcceptableOrUnknown(
          data['made_for_kids']!,
          _madeForKidsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelStatuse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelStatuse(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      privacyStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}privacy_status'],
      )!,
      isLinked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_linked'],
      )!,
      longUploadsStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}long_uploads_status'],
      )!,
      madeForKids: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}made_for_kids'],
      ),
    );
  }

  @override
  $ChannelStatusesTable createAlias(String alias) {
    return $ChannelStatusesTable(attachedDatabase, alias);
  }
}

class ChannelStatuse extends DataClass implements Insertable<ChannelStatuse> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String privacyStatus;
  final bool isLinked;
  final String longUploadsStatus;
  final bool? madeForKids;
  const ChannelStatuse({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.privacyStatus,
    required this.isLinked,
    required this.longUploadsStatus,
    this.madeForKids,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['privacy_status'] = Variable<String>(privacyStatus);
    map['is_linked'] = Variable<bool>(isLinked);
    map['long_uploads_status'] = Variable<String>(longUploadsStatus);
    if (!nullToAbsent || madeForKids != null) {
      map['made_for_kids'] = Variable<bool>(madeForKids);
    }
    return map;
  }

  ChannelStatusesCompanion toCompanion(bool nullToAbsent) {
    return ChannelStatusesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      privacyStatus: Value(privacyStatus),
      isLinked: Value(isLinked),
      longUploadsStatus: Value(longUploadsStatus),
      madeForKids: madeForKids == null && nullToAbsent
          ? const Value.absent()
          : Value(madeForKids),
    );
  }

  factory ChannelStatuse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelStatuse(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      privacyStatus: serializer.fromJson<String>(json['privacyStatus']),
      isLinked: serializer.fromJson<bool>(json['isLinked']),
      longUploadsStatus: serializer.fromJson<String>(json['longUploadsStatus']),
      madeForKids: serializer.fromJson<bool?>(json['madeForKids']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'privacyStatus': serializer.toJson<String>(privacyStatus),
      'isLinked': serializer.toJson<bool>(isLinked),
      'longUploadsStatus': serializer.toJson<String>(longUploadsStatus),
      'madeForKids': serializer.toJson<bool?>(madeForKids),
    };
  }

  ChannelStatuse copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? privacyStatus,
    bool? isLinked,
    String? longUploadsStatus,
    Value<bool?> madeForKids = const Value.absent(),
  }) => ChannelStatuse(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    privacyStatus: privacyStatus ?? this.privacyStatus,
    isLinked: isLinked ?? this.isLinked,
    longUploadsStatus: longUploadsStatus ?? this.longUploadsStatus,
    madeForKids: madeForKids.present ? madeForKids.value : this.madeForKids,
  );
  ChannelStatuse copyWithCompanion(ChannelStatusesCompanion data) {
    return ChannelStatuse(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      privacyStatus: data.privacyStatus.present
          ? data.privacyStatus.value
          : this.privacyStatus,
      isLinked: data.isLinked.present ? data.isLinked.value : this.isLinked,
      longUploadsStatus: data.longUploadsStatus.present
          ? data.longUploadsStatus.value
          : this.longUploadsStatus,
      madeForKids: data.madeForKids.present
          ? data.madeForKids.value
          : this.madeForKids,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelStatuse(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('privacyStatus: $privacyStatus, ')
          ..write('isLinked: $isLinked, ')
          ..write('longUploadsStatus: $longUploadsStatus, ')
          ..write('madeForKids: $madeForKids')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    privacyStatus,
    isLinked,
    longUploadsStatus,
    madeForKids,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelStatuse &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.privacyStatus == this.privacyStatus &&
          other.isLinked == this.isLinked &&
          other.longUploadsStatus == this.longUploadsStatus &&
          other.madeForKids == this.madeForKids);
}

class ChannelStatusesCompanion extends UpdateCompanion<ChannelStatuse> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> privacyStatus;
  final Value<bool> isLinked;
  final Value<String> longUploadsStatus;
  final Value<bool?> madeForKids;
  final Value<int> rowid;
  const ChannelStatusesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.privacyStatus = const Value.absent(),
    this.isLinked = const Value.absent(),
    this.longUploadsStatus = const Value.absent(),
    this.madeForKids = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelStatusesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String privacyStatus,
    required bool isLinked,
    required String longUploadsStatus,
    this.madeForKids = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       privacyStatus = Value(privacyStatus),
       isLinked = Value(isLinked),
       longUploadsStatus = Value(longUploadsStatus);
  static Insertable<ChannelStatuse> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? privacyStatus,
    Expression<bool>? isLinked,
    Expression<String>? longUploadsStatus,
    Expression<bool>? madeForKids,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (privacyStatus != null) 'privacy_status': privacyStatus,
      if (isLinked != null) 'is_linked': isLinked,
      if (longUploadsStatus != null) 'long_uploads_status': longUploadsStatus,
      if (madeForKids != null) 'made_for_kids': madeForKids,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelStatusesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? privacyStatus,
    Value<bool>? isLinked,
    Value<String>? longUploadsStatus,
    Value<bool?>? madeForKids,
    Value<int>? rowid,
  }) {
    return ChannelStatusesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      privacyStatus: privacyStatus ?? this.privacyStatus,
      isLinked: isLinked ?? this.isLinked,
      longUploadsStatus: longUploadsStatus ?? this.longUploadsStatus,
      madeForKids: madeForKids ?? this.madeForKids,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (privacyStatus.present) {
      map['privacy_status'] = Variable<String>(privacyStatus.value);
    }
    if (isLinked.present) {
      map['is_linked'] = Variable<bool>(isLinked.value);
    }
    if (longUploadsStatus.present) {
      map['long_uploads_status'] = Variable<String>(longUploadsStatus.value);
    }
    if (madeForKids.present) {
      map['made_for_kids'] = Variable<bool>(madeForKids.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelStatusesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('privacyStatus: $privacyStatus, ')
          ..write('isLinked: $isLinked, ')
          ..write('longUploadsStatus: $longUploadsStatus, ')
          ..write('madeForKids: $madeForKids, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VideosTable extends Videos with TableInfo<$VideosTable, Video> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _etagMeta = const VerificationMeta('etag');
  @override
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _setagMeta = const VerificationMeta('setag');
  @override
  late final GeneratedColumn<String> setag = GeneratedColumn<String>(
    'setag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _channelIdMeta = const VerificationMeta(
    'channelId',
  );
  @override
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
    'channel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES channels (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    etag,
    setag,
    channelId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'videos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Video> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('etag')) {
      context.handle(
        _etagMeta,
        etag.isAcceptableOrUnknown(data['etag']!, _etagMeta),
      );
    }
    if (data.containsKey('setag')) {
      context.handle(
        _setagMeta,
        setag.isAcceptableOrUnknown(data['setag']!, _setagMeta),
      );
    }
    if (data.containsKey('channel_id')) {
      context.handle(
        _channelIdMeta,
        channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_channelIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Video map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Video(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      etag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etag'],
      ),
      setag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setag'],
      ),
      channelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel_id'],
      )!,
    );
  }

  @override
  $VideosTable createAlias(String alias) {
    return $VideosTable(attachedDatabase, alias);
  }
}

class Video extends DataClass implements Insertable<Video> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String? etag;
  final String? setag;
  final String channelId;
  const Video({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.etag,
    this.setag,
    required this.channelId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || etag != null) {
      map['etag'] = Variable<String>(etag);
    }
    if (!nullToAbsent || setag != null) {
      map['setag'] = Variable<String>(setag);
    }
    map['channel_id'] = Variable<String>(channelId);
    return map;
  }

  VideosCompanion toCompanion(bool nullToAbsent) {
    return VideosCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      etag: etag == null && nullToAbsent ? const Value.absent() : Value(etag),
      setag: setag == null && nullToAbsent
          ? const Value.absent()
          : Value(setag),
      channelId: Value(channelId),
    );
  }

  factory Video.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Video(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      etag: serializer.fromJson<String?>(json['etag']),
      setag: serializer.fromJson<String?>(json['setag']),
      channelId: serializer.fromJson<String>(json['channelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'etag': serializer.toJson<String?>(etag),
      'setag': serializer.toJson<String?>(setag),
      'channelId': serializer.toJson<String>(channelId),
    };
  }

  Video copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    Value<String?> etag = const Value.absent(),
    Value<String?> setag = const Value.absent(),
    String? channelId,
  }) => Video(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    etag: etag.present ? etag.value : this.etag,
    setag: setag.present ? setag.value : this.setag,
    channelId: channelId ?? this.channelId,
  );
  Video copyWithCompanion(VideosCompanion data) {
    return Video(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      etag: data.etag.present ? data.etag.value : this.etag,
      setag: data.setag.present ? data.setag.value : this.setag,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Video(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('etag: $etag, ')
          ..write('setag: $setag, ')
          ..write('channelId: $channelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, etag, setag, channelId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Video &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.etag == this.etag &&
          other.setag == this.setag &&
          other.channelId == this.channelId);
}

class VideosCompanion extends UpdateCompanion<Video> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String?> etag;
  final Value<String?> setag;
  final Value<String> channelId;
  final Value<int> rowid;
  const VideosCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.etag = const Value.absent(),
    this.setag = const Value.absent(),
    this.channelId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideosCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    this.etag = const Value.absent(),
    this.setag = const Value.absent(),
    required String channelId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       channelId = Value(channelId);
  static Insertable<Video> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? etag,
    Expression<String>? setag,
    Expression<String>? channelId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (etag != null) 'etag': etag,
      if (setag != null) 'setag': setag,
      if (channelId != null) 'channel_id': channelId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideosCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String?>? etag,
    Value<String?>? setag,
    Value<String>? channelId,
    Value<int>? rowid,
  }) {
    return VideosCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      etag: etag ?? this.etag,
      setag: setag ?? this.setag,
      channelId: channelId ?? this.channelId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (etag.present) {
      map['etag'] = Variable<String>(etag.value);
    }
    if (setag.present) {
      map['setag'] = Variable<String>(setag.value);
    }
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideosCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('etag: $etag, ')
          ..write('setag: $setag, ')
          ..write('channelId: $channelId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VideoSnippetsTable extends VideoSnippets
    with TableInfo<$VideoSnippetsTable, VideoSnippet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoSnippetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES videos (id)',
    ),
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _channelTitleMeta = const VerificationMeta(
    'channelTitle',
  );
  @override
  late final GeneratedColumn<String> channelTitle = GeneratedColumn<String>(
    'channel_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    publishedAt,
    title,
    description,
    channelTitle,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_snippets';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoSnippet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_publishedAtMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('channel_title')) {
      context.handle(
        _channelTitleMeta,
        channelTitle.isAcceptableOrUnknown(
          data['channel_title']!,
          _channelTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_channelTitleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoSnippet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoSnippet(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      channelTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel_title'],
      )!,
    );
  }

  @override
  $VideoSnippetsTable createAlias(String alias) {
    return $VideoSnippetsTable(attachedDatabase, alias);
  }
}

class VideoSnippet extends DataClass implements Insertable<VideoSnippet> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final DateTime publishedAt;
  final String title;
  final String description;
  final String channelTitle;
  const VideoSnippet({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.publishedAt,
    required this.title,
    required this.description,
    required this.channelTitle,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['published_at'] = Variable<DateTime>(publishedAt);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['channel_title'] = Variable<String>(channelTitle);
    return map;
  }

  VideoSnippetsCompanion toCompanion(bool nullToAbsent) {
    return VideoSnippetsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      publishedAt: Value(publishedAt),
      title: Value(title),
      description: Value(description),
      channelTitle: Value(channelTitle),
    );
  }

  factory VideoSnippet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoSnippet(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      channelTitle: serializer.fromJson<String>(json['channelTitle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'channelTitle': serializer.toJson<String>(channelTitle),
    };
  }

  VideoSnippet copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    DateTime? publishedAt,
    String? title,
    String? description,
    String? channelTitle,
  }) => VideoSnippet(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    publishedAt: publishedAt ?? this.publishedAt,
    title: title ?? this.title,
    description: description ?? this.description,
    channelTitle: channelTitle ?? this.channelTitle,
  );
  VideoSnippet copyWithCompanion(VideoSnippetsCompanion data) {
    return VideoSnippet(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      channelTitle: data.channelTitle.present
          ? data.channelTitle.value
          : this.channelTitle,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoSnippet(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('channelTitle: $channelTitle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    publishedAt,
    title,
    description,
    channelTitle,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoSnippet &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.publishedAt == this.publishedAt &&
          other.title == this.title &&
          other.description == this.description &&
          other.channelTitle == this.channelTitle);
}

class VideoSnippetsCompanion extends UpdateCompanion<VideoSnippet> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<DateTime> publishedAt;
  final Value<String> title;
  final Value<String> description;
  final Value<String> channelTitle;
  final Value<int> rowid;
  const VideoSnippetsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.channelTitle = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoSnippetsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required DateTime publishedAt,
    required String title,
    required String description,
    required String channelTitle,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       publishedAt = Value(publishedAt),
       title = Value(title),
       description = Value(description),
       channelTitle = Value(channelTitle);
  static Insertable<VideoSnippet> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<DateTime>? publishedAt,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? channelTitle,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (publishedAt != null) 'published_at': publishedAt,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (channelTitle != null) 'channel_title': channelTitle,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoSnippetsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<DateTime>? publishedAt,
    Value<String>? title,
    Value<String>? description,
    Value<String>? channelTitle,
    Value<int>? rowid,
  }) {
    return VideoSnippetsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      publishedAt: publishedAt ?? this.publishedAt,
      title: title ?? this.title,
      description: description ?? this.description,
      channelTitle: channelTitle ?? this.channelTitle,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (channelTitle.present) {
      map['channel_title'] = Variable<String>(channelTitle.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoSnippetsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('channelTitle: $channelTitle, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VideoThumbnailsTable extends VideoThumbnails
    with TableInfo<$VideoThumbnailsTable, VideoThumbnail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoThumbnailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES videos (id)',
    ),
  );
  static const VerificationMeta _defaultUrlMeta = const VerificationMeta(
    'defaultUrl',
  );
  @override
  late final GeneratedColumn<String> defaultUrl = GeneratedColumn<String>(
    'default_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediumUrlMeta = const VerificationMeta(
    'mediumUrl',
  );
  @override
  late final GeneratedColumn<String> mediumUrl = GeneratedColumn<String>(
    'medium_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _highUrlMeta = const VerificationMeta(
    'highUrl',
  );
  @override
  late final GeneratedColumn<String> highUrl = GeneratedColumn<String>(
    'high_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _standardUrlMeta = const VerificationMeta(
    'standardUrl',
  );
  @override
  late final GeneratedColumn<String> standardUrl = GeneratedColumn<String>(
    'standard_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxresUrlMeta = const VerificationMeta(
    'maxresUrl',
  );
  @override
  late final GeneratedColumn<String> maxresUrl = GeneratedColumn<String>(
    'maxres_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    defaultUrl,
    mediumUrl,
    highUrl,
    standardUrl,
    maxresUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_thumbnails';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoThumbnail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('default_url')) {
      context.handle(
        _defaultUrlMeta,
        defaultUrl.isAcceptableOrUnknown(data['default_url']!, _defaultUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_defaultUrlMeta);
    }
    if (data.containsKey('medium_url')) {
      context.handle(
        _mediumUrlMeta,
        mediumUrl.isAcceptableOrUnknown(data['medium_url']!, _mediumUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_mediumUrlMeta);
    }
    if (data.containsKey('high_url')) {
      context.handle(
        _highUrlMeta,
        highUrl.isAcceptableOrUnknown(data['high_url']!, _highUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_highUrlMeta);
    }
    if (data.containsKey('standard_url')) {
      context.handle(
        _standardUrlMeta,
        standardUrl.isAcceptableOrUnknown(
          data['standard_url']!,
          _standardUrlMeta,
        ),
      );
    }
    if (data.containsKey('maxres_url')) {
      context.handle(
        _maxresUrlMeta,
        maxresUrl.isAcceptableOrUnknown(data['maxres_url']!, _maxresUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoThumbnail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoThumbnail(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      defaultUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_url'],
      )!,
      mediumUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medium_url'],
      )!,
      highUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}high_url'],
      )!,
      standardUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}standard_url'],
      ),
      maxresUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}maxres_url'],
      ),
    );
  }

  @override
  $VideoThumbnailsTable createAlias(String alias) {
    return $VideoThumbnailsTable(attachedDatabase, alias);
  }
}

class VideoThumbnail extends DataClass implements Insertable<VideoThumbnail> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String defaultUrl;
  final String mediumUrl;
  final String highUrl;
  final String? standardUrl;
  final String? maxresUrl;
  const VideoThumbnail({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.defaultUrl,
    required this.mediumUrl,
    required this.highUrl,
    this.standardUrl,
    this.maxresUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['default_url'] = Variable<String>(defaultUrl);
    map['medium_url'] = Variable<String>(mediumUrl);
    map['high_url'] = Variable<String>(highUrl);
    if (!nullToAbsent || standardUrl != null) {
      map['standard_url'] = Variable<String>(standardUrl);
    }
    if (!nullToAbsent || maxresUrl != null) {
      map['maxres_url'] = Variable<String>(maxresUrl);
    }
    return map;
  }

  VideoThumbnailsCompanion toCompanion(bool nullToAbsent) {
    return VideoThumbnailsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      defaultUrl: Value(defaultUrl),
      mediumUrl: Value(mediumUrl),
      highUrl: Value(highUrl),
      standardUrl: standardUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(standardUrl),
      maxresUrl: maxresUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(maxresUrl),
    );
  }

  factory VideoThumbnail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoThumbnail(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      defaultUrl: serializer.fromJson<String>(json['defaultUrl']),
      mediumUrl: serializer.fromJson<String>(json['mediumUrl']),
      highUrl: serializer.fromJson<String>(json['highUrl']),
      standardUrl: serializer.fromJson<String?>(json['standardUrl']),
      maxresUrl: serializer.fromJson<String?>(json['maxresUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'defaultUrl': serializer.toJson<String>(defaultUrl),
      'mediumUrl': serializer.toJson<String>(mediumUrl),
      'highUrl': serializer.toJson<String>(highUrl),
      'standardUrl': serializer.toJson<String?>(standardUrl),
      'maxresUrl': serializer.toJson<String?>(maxresUrl),
    };
  }

  VideoThumbnail copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? defaultUrl,
    String? mediumUrl,
    String? highUrl,
    Value<String?> standardUrl = const Value.absent(),
    Value<String?> maxresUrl = const Value.absent(),
  }) => VideoThumbnail(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    defaultUrl: defaultUrl ?? this.defaultUrl,
    mediumUrl: mediumUrl ?? this.mediumUrl,
    highUrl: highUrl ?? this.highUrl,
    standardUrl: standardUrl.present ? standardUrl.value : this.standardUrl,
    maxresUrl: maxresUrl.present ? maxresUrl.value : this.maxresUrl,
  );
  VideoThumbnail copyWithCompanion(VideoThumbnailsCompanion data) {
    return VideoThumbnail(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      defaultUrl: data.defaultUrl.present
          ? data.defaultUrl.value
          : this.defaultUrl,
      mediumUrl: data.mediumUrl.present ? data.mediumUrl.value : this.mediumUrl,
      highUrl: data.highUrl.present ? data.highUrl.value : this.highUrl,
      standardUrl: data.standardUrl.present
          ? data.standardUrl.value
          : this.standardUrl,
      maxresUrl: data.maxresUrl.present ? data.maxresUrl.value : this.maxresUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoThumbnail(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('defaultUrl: $defaultUrl, ')
          ..write('mediumUrl: $mediumUrl, ')
          ..write('highUrl: $highUrl, ')
          ..write('standardUrl: $standardUrl, ')
          ..write('maxresUrl: $maxresUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    defaultUrl,
    mediumUrl,
    highUrl,
    standardUrl,
    maxresUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoThumbnail &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.defaultUrl == this.defaultUrl &&
          other.mediumUrl == this.mediumUrl &&
          other.highUrl == this.highUrl &&
          other.standardUrl == this.standardUrl &&
          other.maxresUrl == this.maxresUrl);
}

class VideoThumbnailsCompanion extends UpdateCompanion<VideoThumbnail> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> defaultUrl;
  final Value<String> mediumUrl;
  final Value<String> highUrl;
  final Value<String?> standardUrl;
  final Value<String?> maxresUrl;
  final Value<int> rowid;
  const VideoThumbnailsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.defaultUrl = const Value.absent(),
    this.mediumUrl = const Value.absent(),
    this.highUrl = const Value.absent(),
    this.standardUrl = const Value.absent(),
    this.maxresUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoThumbnailsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String defaultUrl,
    required String mediumUrl,
    required String highUrl,
    this.standardUrl = const Value.absent(),
    this.maxresUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       defaultUrl = Value(defaultUrl),
       mediumUrl = Value(mediumUrl),
       highUrl = Value(highUrl);
  static Insertable<VideoThumbnail> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? defaultUrl,
    Expression<String>? mediumUrl,
    Expression<String>? highUrl,
    Expression<String>? standardUrl,
    Expression<String>? maxresUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (defaultUrl != null) 'default_url': defaultUrl,
      if (mediumUrl != null) 'medium_url': mediumUrl,
      if (highUrl != null) 'high_url': highUrl,
      if (standardUrl != null) 'standard_url': standardUrl,
      if (maxresUrl != null) 'maxres_url': maxresUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoThumbnailsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? defaultUrl,
    Value<String>? mediumUrl,
    Value<String>? highUrl,
    Value<String?>? standardUrl,
    Value<String?>? maxresUrl,
    Value<int>? rowid,
  }) {
    return VideoThumbnailsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      defaultUrl: defaultUrl ?? this.defaultUrl,
      mediumUrl: mediumUrl ?? this.mediumUrl,
      highUrl: highUrl ?? this.highUrl,
      standardUrl: standardUrl ?? this.standardUrl,
      maxresUrl: maxresUrl ?? this.maxresUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (defaultUrl.present) {
      map['default_url'] = Variable<String>(defaultUrl.value);
    }
    if (mediumUrl.present) {
      map['medium_url'] = Variable<String>(mediumUrl.value);
    }
    if (highUrl.present) {
      map['high_url'] = Variable<String>(highUrl.value);
    }
    if (standardUrl.present) {
      map['standard_url'] = Variable<String>(standardUrl.value);
    }
    if (maxresUrl.present) {
      map['maxres_url'] = Variable<String>(maxresUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoThumbnailsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('defaultUrl: $defaultUrl, ')
          ..write('mediumUrl: $mediumUrl, ')
          ..write('highUrl: $highUrl, ')
          ..write('standardUrl: $standardUrl, ')
          ..write('maxresUrl: $maxresUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VideoContentDetailsTable extends VideoContentDetails
    with TableInfo<$VideoContentDetailsTable, VideoContentDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoContentDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES videos (id)',
    ),
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dimensionMeta = const VerificationMeta(
    'dimension',
  );
  @override
  late final GeneratedColumn<String> dimension = GeneratedColumn<String>(
    'dimension',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licensedContentMeta = const VerificationMeta(
    'licensedContent',
  );
  @override
  late final GeneratedColumn<bool> licensedContent = GeneratedColumn<bool>(
    'licensed_content',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("licensed_content" IN (0, 1))',
    ),
  );
  static const VerificationMeta _projectionMeta = const VerificationMeta(
    'projection',
  );
  @override
  late final GeneratedColumn<String> projection = GeneratedColumn<String>(
    'projection',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    duration,
    dimension,
    definition,
    caption,
    licensedContent,
    projection,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_content_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoContentDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('dimension')) {
      context.handle(
        _dimensionMeta,
        dimension.isAcceptableOrUnknown(data['dimension']!, _dimensionMeta),
      );
    } else if (isInserting) {
      context.missing(_dimensionMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    } else if (isInserting) {
      context.missing(_captionMeta);
    }
    if (data.containsKey('licensed_content')) {
      context.handle(
        _licensedContentMeta,
        licensedContent.isAcceptableOrUnknown(
          data['licensed_content']!,
          _licensedContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licensedContentMeta);
    }
    if (data.containsKey('projection')) {
      context.handle(
        _projectionMeta,
        projection.isAcceptableOrUnknown(data['projection']!, _projectionMeta),
      );
    } else if (isInserting) {
      context.missing(_projectionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoContentDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoContentDetail(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duration'],
      )!,
      dimension: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dimension'],
      )!,
      definition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition'],
      )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      )!,
      licensedContent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}licensed_content'],
      )!,
      projection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}projection'],
      )!,
    );
  }

  @override
  $VideoContentDetailsTable createAlias(String alias) {
    return $VideoContentDetailsTable(attachedDatabase, alias);
  }
}

class VideoContentDetail extends DataClass
    implements Insertable<VideoContentDetail> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String duration;
  final String dimension;
  final String definition;
  final String caption;
  final bool licensedContent;
  final String projection;
  const VideoContentDetail({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.duration,
    required this.dimension,
    required this.definition,
    required this.caption,
    required this.licensedContent,
    required this.projection,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['duration'] = Variable<String>(duration);
    map['dimension'] = Variable<String>(dimension);
    map['definition'] = Variable<String>(definition);
    map['caption'] = Variable<String>(caption);
    map['licensed_content'] = Variable<bool>(licensedContent);
    map['projection'] = Variable<String>(projection);
    return map;
  }

  VideoContentDetailsCompanion toCompanion(bool nullToAbsent) {
    return VideoContentDetailsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      duration: Value(duration),
      dimension: Value(dimension),
      definition: Value(definition),
      caption: Value(caption),
      licensedContent: Value(licensedContent),
      projection: Value(projection),
    );
  }

  factory VideoContentDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoContentDetail(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      duration: serializer.fromJson<String>(json['duration']),
      dimension: serializer.fromJson<String>(json['dimension']),
      definition: serializer.fromJson<String>(json['definition']),
      caption: serializer.fromJson<String>(json['caption']),
      licensedContent: serializer.fromJson<bool>(json['licensedContent']),
      projection: serializer.fromJson<String>(json['projection']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'duration': serializer.toJson<String>(duration),
      'dimension': serializer.toJson<String>(dimension),
      'definition': serializer.toJson<String>(definition),
      'caption': serializer.toJson<String>(caption),
      'licensedContent': serializer.toJson<bool>(licensedContent),
      'projection': serializer.toJson<String>(projection),
    };
  }

  VideoContentDetail copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? duration,
    String? dimension,
    String? definition,
    String? caption,
    bool? licensedContent,
    String? projection,
  }) => VideoContentDetail(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    duration: duration ?? this.duration,
    dimension: dimension ?? this.dimension,
    definition: definition ?? this.definition,
    caption: caption ?? this.caption,
    licensedContent: licensedContent ?? this.licensedContent,
    projection: projection ?? this.projection,
  );
  VideoContentDetail copyWithCompanion(VideoContentDetailsCompanion data) {
    return VideoContentDetail(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      duration: data.duration.present ? data.duration.value : this.duration,
      dimension: data.dimension.present ? data.dimension.value : this.dimension,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
      caption: data.caption.present ? data.caption.value : this.caption,
      licensedContent: data.licensedContent.present
          ? data.licensedContent.value
          : this.licensedContent,
      projection: data.projection.present
          ? data.projection.value
          : this.projection,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoContentDetail(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('duration: $duration, ')
          ..write('dimension: $dimension, ')
          ..write('definition: $definition, ')
          ..write('caption: $caption, ')
          ..write('licensedContent: $licensedContent, ')
          ..write('projection: $projection')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    duration,
    dimension,
    definition,
    caption,
    licensedContent,
    projection,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoContentDetail &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.duration == this.duration &&
          other.dimension == this.dimension &&
          other.definition == this.definition &&
          other.caption == this.caption &&
          other.licensedContent == this.licensedContent &&
          other.projection == this.projection);
}

class VideoContentDetailsCompanion extends UpdateCompanion<VideoContentDetail> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> duration;
  final Value<String> dimension;
  final Value<String> definition;
  final Value<String> caption;
  final Value<bool> licensedContent;
  final Value<String> projection;
  final Value<int> rowid;
  const VideoContentDetailsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.duration = const Value.absent(),
    this.dimension = const Value.absent(),
    this.definition = const Value.absent(),
    this.caption = const Value.absent(),
    this.licensedContent = const Value.absent(),
    this.projection = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoContentDetailsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String duration,
    required String dimension,
    required String definition,
    required String caption,
    required bool licensedContent,
    required String projection,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       duration = Value(duration),
       dimension = Value(dimension),
       definition = Value(definition),
       caption = Value(caption),
       licensedContent = Value(licensedContent),
       projection = Value(projection);
  static Insertable<VideoContentDetail> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? duration,
    Expression<String>? dimension,
    Expression<String>? definition,
    Expression<String>? caption,
    Expression<bool>? licensedContent,
    Expression<String>? projection,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (duration != null) 'duration': duration,
      if (dimension != null) 'dimension': dimension,
      if (definition != null) 'definition': definition,
      if (caption != null) 'caption': caption,
      if (licensedContent != null) 'licensed_content': licensedContent,
      if (projection != null) 'projection': projection,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoContentDetailsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? duration,
    Value<String>? dimension,
    Value<String>? definition,
    Value<String>? caption,
    Value<bool>? licensedContent,
    Value<String>? projection,
    Value<int>? rowid,
  }) {
    return VideoContentDetailsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      duration: duration ?? this.duration,
      dimension: dimension ?? this.dimension,
      definition: definition ?? this.definition,
      caption: caption ?? this.caption,
      licensedContent: licensedContent ?? this.licensedContent,
      projection: projection ?? this.projection,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (dimension.present) {
      map['dimension'] = Variable<String>(dimension.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (licensedContent.present) {
      map['licensed_content'] = Variable<bool>(licensedContent.value);
    }
    if (projection.present) {
      map['projection'] = Variable<String>(projection.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoContentDetailsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('duration: $duration, ')
          ..write('dimension: $dimension, ')
          ..write('definition: $definition, ')
          ..write('caption: $caption, ')
          ..write('licensedContent: $licensedContent, ')
          ..write('projection: $projection, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VideoStatusesTable extends VideoStatuses
    with TableInfo<$VideoStatusesTable, VideoStatuse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoStatusesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES videos (id)',
    ),
  );
  static const VerificationMeta _uploadStatusMeta = const VerificationMeta(
    'uploadStatus',
  );
  @override
  late final GeneratedColumn<String> uploadStatus = GeneratedColumn<String>(
    'upload_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _privacyStatusMeta = const VerificationMeta(
    'privacyStatus',
  );
  @override
  late final GeneratedColumn<String> privacyStatus = GeneratedColumn<String>(
    'privacy_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licenseMeta = const VerificationMeta(
    'license',
  );
  @override
  late final GeneratedColumn<String> license = GeneratedColumn<String>(
    'license',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _embeddableMeta = const VerificationMeta(
    'embeddable',
  );
  @override
  late final GeneratedColumn<bool> embeddable = GeneratedColumn<bool>(
    'embeddable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("embeddable" IN (0, 1))',
    ),
  );
  static const VerificationMeta _publicStatsViewableMeta =
      const VerificationMeta('publicStatsViewable');
  @override
  late final GeneratedColumn<bool> publicStatsViewable = GeneratedColumn<bool>(
    'public_stats_viewable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("public_stats_viewable" IN (0, 1))',
    ),
  );
  static const VerificationMeta _madeForKidsMeta = const VerificationMeta(
    'madeForKids',
  );
  @override
  late final GeneratedColumn<bool> madeForKids = GeneratedColumn<bool>(
    'made_for_kids',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("made_for_kids" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    uploadStatus,
    privacyStatus,
    license,
    embeddable,
    publicStatsViewable,
    madeForKids,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_statuses';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoStatuse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('upload_status')) {
      context.handle(
        _uploadStatusMeta,
        uploadStatus.isAcceptableOrUnknown(
          data['upload_status']!,
          _uploadStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_uploadStatusMeta);
    }
    if (data.containsKey('privacy_status')) {
      context.handle(
        _privacyStatusMeta,
        privacyStatus.isAcceptableOrUnknown(
          data['privacy_status']!,
          _privacyStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_privacyStatusMeta);
    }
    if (data.containsKey('license')) {
      context.handle(
        _licenseMeta,
        license.isAcceptableOrUnknown(data['license']!, _licenseMeta),
      );
    } else if (isInserting) {
      context.missing(_licenseMeta);
    }
    if (data.containsKey('embeddable')) {
      context.handle(
        _embeddableMeta,
        embeddable.isAcceptableOrUnknown(data['embeddable']!, _embeddableMeta),
      );
    } else if (isInserting) {
      context.missing(_embeddableMeta);
    }
    if (data.containsKey('public_stats_viewable')) {
      context.handle(
        _publicStatsViewableMeta,
        publicStatsViewable.isAcceptableOrUnknown(
          data['public_stats_viewable']!,
          _publicStatsViewableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_publicStatsViewableMeta);
    }
    if (data.containsKey('made_for_kids')) {
      context.handle(
        _madeForKidsMeta,
        madeForKids.isAcceptableOrUnknown(
          data['made_for_kids']!,
          _madeForKidsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_madeForKidsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoStatuse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoStatuse(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      uploadStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upload_status'],
      )!,
      privacyStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}privacy_status'],
      )!,
      license: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license'],
      )!,
      embeddable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}embeddable'],
      )!,
      publicStatsViewable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}public_stats_viewable'],
      )!,
      madeForKids: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}made_for_kids'],
      )!,
    );
  }

  @override
  $VideoStatusesTable createAlias(String alias) {
    return $VideoStatusesTable(attachedDatabase, alias);
  }
}

class VideoStatuse extends DataClass implements Insertable<VideoStatuse> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String uploadStatus;
  final String privacyStatus;
  final String license;
  final bool embeddable;
  final bool publicStatsViewable;
  final bool madeForKids;
  const VideoStatuse({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.uploadStatus,
    required this.privacyStatus,
    required this.license,
    required this.embeddable,
    required this.publicStatsViewable,
    required this.madeForKids,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['upload_status'] = Variable<String>(uploadStatus);
    map['privacy_status'] = Variable<String>(privacyStatus);
    map['license'] = Variable<String>(license);
    map['embeddable'] = Variable<bool>(embeddable);
    map['public_stats_viewable'] = Variable<bool>(publicStatsViewable);
    map['made_for_kids'] = Variable<bool>(madeForKids);
    return map;
  }

  VideoStatusesCompanion toCompanion(bool nullToAbsent) {
    return VideoStatusesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      uploadStatus: Value(uploadStatus),
      privacyStatus: Value(privacyStatus),
      license: Value(license),
      embeddable: Value(embeddable),
      publicStatsViewable: Value(publicStatsViewable),
      madeForKids: Value(madeForKids),
    );
  }

  factory VideoStatuse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoStatuse(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      uploadStatus: serializer.fromJson<String>(json['uploadStatus']),
      privacyStatus: serializer.fromJson<String>(json['privacyStatus']),
      license: serializer.fromJson<String>(json['license']),
      embeddable: serializer.fromJson<bool>(json['embeddable']),
      publicStatsViewable: serializer.fromJson<bool>(
        json['publicStatsViewable'],
      ),
      madeForKids: serializer.fromJson<bool>(json['madeForKids']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'uploadStatus': serializer.toJson<String>(uploadStatus),
      'privacyStatus': serializer.toJson<String>(privacyStatus),
      'license': serializer.toJson<String>(license),
      'embeddable': serializer.toJson<bool>(embeddable),
      'publicStatsViewable': serializer.toJson<bool>(publicStatsViewable),
      'madeForKids': serializer.toJson<bool>(madeForKids),
    };
  }

  VideoStatuse copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? uploadStatus,
    String? privacyStatus,
    String? license,
    bool? embeddable,
    bool? publicStatsViewable,
    bool? madeForKids,
  }) => VideoStatuse(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    uploadStatus: uploadStatus ?? this.uploadStatus,
    privacyStatus: privacyStatus ?? this.privacyStatus,
    license: license ?? this.license,
    embeddable: embeddable ?? this.embeddable,
    publicStatsViewable: publicStatsViewable ?? this.publicStatsViewable,
    madeForKids: madeForKids ?? this.madeForKids,
  );
  VideoStatuse copyWithCompanion(VideoStatusesCompanion data) {
    return VideoStatuse(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      uploadStatus: data.uploadStatus.present
          ? data.uploadStatus.value
          : this.uploadStatus,
      privacyStatus: data.privacyStatus.present
          ? data.privacyStatus.value
          : this.privacyStatus,
      license: data.license.present ? data.license.value : this.license,
      embeddable: data.embeddable.present
          ? data.embeddable.value
          : this.embeddable,
      publicStatsViewable: data.publicStatsViewable.present
          ? data.publicStatsViewable.value
          : this.publicStatsViewable,
      madeForKids: data.madeForKids.present
          ? data.madeForKids.value
          : this.madeForKids,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoStatuse(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('privacyStatus: $privacyStatus, ')
          ..write('license: $license, ')
          ..write('embeddable: $embeddable, ')
          ..write('publicStatsViewable: $publicStatsViewable, ')
          ..write('madeForKids: $madeForKids')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    uploadStatus,
    privacyStatus,
    license,
    embeddable,
    publicStatsViewable,
    madeForKids,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoStatuse &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.uploadStatus == this.uploadStatus &&
          other.privacyStatus == this.privacyStatus &&
          other.license == this.license &&
          other.embeddable == this.embeddable &&
          other.publicStatsViewable == this.publicStatsViewable &&
          other.madeForKids == this.madeForKids);
}

class VideoStatusesCompanion extends UpdateCompanion<VideoStatuse> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> uploadStatus;
  final Value<String> privacyStatus;
  final Value<String> license;
  final Value<bool> embeddable;
  final Value<bool> publicStatsViewable;
  final Value<bool> madeForKids;
  final Value<int> rowid;
  const VideoStatusesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.privacyStatus = const Value.absent(),
    this.license = const Value.absent(),
    this.embeddable = const Value.absent(),
    this.publicStatsViewable = const Value.absent(),
    this.madeForKids = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoStatusesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String uploadStatus,
    required String privacyStatus,
    required String license,
    required bool embeddable,
    required bool publicStatsViewable,
    required bool madeForKids,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       uploadStatus = Value(uploadStatus),
       privacyStatus = Value(privacyStatus),
       license = Value(license),
       embeddable = Value(embeddable),
       publicStatsViewable = Value(publicStatsViewable),
       madeForKids = Value(madeForKids);
  static Insertable<VideoStatuse> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? uploadStatus,
    Expression<String>? privacyStatus,
    Expression<String>? license,
    Expression<bool>? embeddable,
    Expression<bool>? publicStatsViewable,
    Expression<bool>? madeForKids,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (uploadStatus != null) 'upload_status': uploadStatus,
      if (privacyStatus != null) 'privacy_status': privacyStatus,
      if (license != null) 'license': license,
      if (embeddable != null) 'embeddable': embeddable,
      if (publicStatsViewable != null)
        'public_stats_viewable': publicStatsViewable,
      if (madeForKids != null) 'made_for_kids': madeForKids,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoStatusesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? uploadStatus,
    Value<String>? privacyStatus,
    Value<String>? license,
    Value<bool>? embeddable,
    Value<bool>? publicStatsViewable,
    Value<bool>? madeForKids,
    Value<int>? rowid,
  }) {
    return VideoStatusesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      privacyStatus: privacyStatus ?? this.privacyStatus,
      license: license ?? this.license,
      embeddable: embeddable ?? this.embeddable,
      publicStatsViewable: publicStatsViewable ?? this.publicStatsViewable,
      madeForKids: madeForKids ?? this.madeForKids,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uploadStatus.present) {
      map['upload_status'] = Variable<String>(uploadStatus.value);
    }
    if (privacyStatus.present) {
      map['privacy_status'] = Variable<String>(privacyStatus.value);
    }
    if (license.present) {
      map['license'] = Variable<String>(license.value);
    }
    if (embeddable.present) {
      map['embeddable'] = Variable<bool>(embeddable.value);
    }
    if (publicStatsViewable.present) {
      map['public_stats_viewable'] = Variable<bool>(publicStatsViewable.value);
    }
    if (madeForKids.present) {
      map['made_for_kids'] = Variable<bool>(madeForKids.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoStatusesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('privacyStatus: $privacyStatus, ')
          ..write('license: $license, ')
          ..write('embeddable: $embeddable, ')
          ..write('publicStatsViewable: $publicStatsViewable, ')
          ..write('madeForKids: $madeForKids, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VideoStatisticsTable extends VideoStatistics
    with TableInfo<$VideoStatisticsTable, VideoStatistic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoStatisticsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES videos (id)',
    ),
  );
  static const VerificationMeta _viewCountMeta = const VerificationMeta(
    'viewCount',
  );
  @override
  late final GeneratedColumn<int> viewCount = GeneratedColumn<int>(
    'view_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _likeCountMeta = const VerificationMeta(
    'likeCount',
  );
  @override
  late final GeneratedColumn<int> likeCount = GeneratedColumn<int>(
    'like_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dislikeCountMeta = const VerificationMeta(
    'dislikeCount',
  );
  @override
  late final GeneratedColumn<int> dislikeCount = GeneratedColumn<int>(
    'dislike_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _favoriteCountMeta = const VerificationMeta(
    'favoriteCount',
  );
  @override
  late final GeneratedColumn<int> favoriteCount = GeneratedColumn<int>(
    'favorite_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentCountMeta = const VerificationMeta(
    'commentCount',
  );
  @override
  late final GeneratedColumn<int> commentCount = GeneratedColumn<int>(
    'comment_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    viewCount,
    likeCount,
    dislikeCount,
    favoriteCount,
    commentCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_statistics';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoStatistic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('view_count')) {
      context.handle(
        _viewCountMeta,
        viewCount.isAcceptableOrUnknown(data['view_count']!, _viewCountMeta),
      );
    } else if (isInserting) {
      context.missing(_viewCountMeta);
    }
    if (data.containsKey('like_count')) {
      context.handle(
        _likeCountMeta,
        likeCount.isAcceptableOrUnknown(data['like_count']!, _likeCountMeta),
      );
    }
    if (data.containsKey('dislike_count')) {
      context.handle(
        _dislikeCountMeta,
        dislikeCount.isAcceptableOrUnknown(
          data['dislike_count']!,
          _dislikeCountMeta,
        ),
      );
    }
    if (data.containsKey('favorite_count')) {
      context.handle(
        _favoriteCountMeta,
        favoriteCount.isAcceptableOrUnknown(
          data['favorite_count']!,
          _favoriteCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_favoriteCountMeta);
    }
    if (data.containsKey('comment_count')) {
      context.handle(
        _commentCountMeta,
        commentCount.isAcceptableOrUnknown(
          data['comment_count']!,
          _commentCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoStatistic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoStatistic(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      viewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}view_count'],
      )!,
      likeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}like_count'],
      ),
      dislikeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dislike_count'],
      ),
      favoriteCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}favorite_count'],
      )!,
      commentCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}comment_count'],
      ),
    );
  }

  @override
  $VideoStatisticsTable createAlias(String alias) {
    return $VideoStatisticsTable(attachedDatabase, alias);
  }
}

class VideoStatistic extends DataClass implements Insertable<VideoStatistic> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final int viewCount;
  final int? likeCount;
  final int? dislikeCount;
  final int favoriteCount;
  final int? commentCount;
  const VideoStatistic({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.viewCount,
    this.likeCount,
    this.dislikeCount,
    required this.favoriteCount,
    this.commentCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['view_count'] = Variable<int>(viewCount);
    if (!nullToAbsent || likeCount != null) {
      map['like_count'] = Variable<int>(likeCount);
    }
    if (!nullToAbsent || dislikeCount != null) {
      map['dislike_count'] = Variable<int>(dislikeCount);
    }
    map['favorite_count'] = Variable<int>(favoriteCount);
    if (!nullToAbsent || commentCount != null) {
      map['comment_count'] = Variable<int>(commentCount);
    }
    return map;
  }

  VideoStatisticsCompanion toCompanion(bool nullToAbsent) {
    return VideoStatisticsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      viewCount: Value(viewCount),
      likeCount: likeCount == null && nullToAbsent
          ? const Value.absent()
          : Value(likeCount),
      dislikeCount: dislikeCount == null && nullToAbsent
          ? const Value.absent()
          : Value(dislikeCount),
      favoriteCount: Value(favoriteCount),
      commentCount: commentCount == null && nullToAbsent
          ? const Value.absent()
          : Value(commentCount),
    );
  }

  factory VideoStatistic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoStatistic(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      viewCount: serializer.fromJson<int>(json['viewCount']),
      likeCount: serializer.fromJson<int?>(json['likeCount']),
      dislikeCount: serializer.fromJson<int?>(json['dislikeCount']),
      favoriteCount: serializer.fromJson<int>(json['favoriteCount']),
      commentCount: serializer.fromJson<int?>(json['commentCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'viewCount': serializer.toJson<int>(viewCount),
      'likeCount': serializer.toJson<int?>(likeCount),
      'dislikeCount': serializer.toJson<int?>(dislikeCount),
      'favoriteCount': serializer.toJson<int>(favoriteCount),
      'commentCount': serializer.toJson<int?>(commentCount),
    };
  }

  VideoStatistic copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    int? viewCount,
    Value<int?> likeCount = const Value.absent(),
    Value<int?> dislikeCount = const Value.absent(),
    int? favoriteCount,
    Value<int?> commentCount = const Value.absent(),
  }) => VideoStatistic(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    viewCount: viewCount ?? this.viewCount,
    likeCount: likeCount.present ? likeCount.value : this.likeCount,
    dislikeCount: dislikeCount.present ? dislikeCount.value : this.dislikeCount,
    favoriteCount: favoriteCount ?? this.favoriteCount,
    commentCount: commentCount.present ? commentCount.value : this.commentCount,
  );
  VideoStatistic copyWithCompanion(VideoStatisticsCompanion data) {
    return VideoStatistic(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      viewCount: data.viewCount.present ? data.viewCount.value : this.viewCount,
      likeCount: data.likeCount.present ? data.likeCount.value : this.likeCount,
      dislikeCount: data.dislikeCount.present
          ? data.dislikeCount.value
          : this.dislikeCount,
      favoriteCount: data.favoriteCount.present
          ? data.favoriteCount.value
          : this.favoriteCount,
      commentCount: data.commentCount.present
          ? data.commentCount.value
          : this.commentCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoStatistic(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('viewCount: $viewCount, ')
          ..write('likeCount: $likeCount, ')
          ..write('dislikeCount: $dislikeCount, ')
          ..write('favoriteCount: $favoriteCount, ')
          ..write('commentCount: $commentCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    viewCount,
    likeCount,
    dislikeCount,
    favoriteCount,
    commentCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoStatistic &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.viewCount == this.viewCount &&
          other.likeCount == this.likeCount &&
          other.dislikeCount == this.dislikeCount &&
          other.favoriteCount == this.favoriteCount &&
          other.commentCount == this.commentCount);
}

class VideoStatisticsCompanion extends UpdateCompanion<VideoStatistic> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<int> viewCount;
  final Value<int?> likeCount;
  final Value<int?> dislikeCount;
  final Value<int> favoriteCount;
  final Value<int?> commentCount;
  final Value<int> rowid;
  const VideoStatisticsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.dislikeCount = const Value.absent(),
    this.favoriteCount = const Value.absent(),
    this.commentCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoStatisticsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required int viewCount,
    this.likeCount = const Value.absent(),
    this.dislikeCount = const Value.absent(),
    required int favoriteCount,
    this.commentCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       viewCount = Value(viewCount),
       favoriteCount = Value(favoriteCount);
  static Insertable<VideoStatistic> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<int>? viewCount,
    Expression<int>? likeCount,
    Expression<int>? dislikeCount,
    Expression<int>? favoriteCount,
    Expression<int>? commentCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (viewCount != null) 'view_count': viewCount,
      if (likeCount != null) 'like_count': likeCount,
      if (dislikeCount != null) 'dislike_count': dislikeCount,
      if (favoriteCount != null) 'favorite_count': favoriteCount,
      if (commentCount != null) 'comment_count': commentCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoStatisticsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<int>? viewCount,
    Value<int?>? likeCount,
    Value<int?>? dislikeCount,
    Value<int>? favoriteCount,
    Value<int?>? commentCount,
    Value<int>? rowid,
  }) {
    return VideoStatisticsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      dislikeCount: dislikeCount ?? this.dislikeCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      commentCount: commentCount ?? this.commentCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (viewCount.present) {
      map['view_count'] = Variable<int>(viewCount.value);
    }
    if (likeCount.present) {
      map['like_count'] = Variable<int>(likeCount.value);
    }
    if (dislikeCount.present) {
      map['dislike_count'] = Variable<int>(dislikeCount.value);
    }
    if (favoriteCount.present) {
      map['favorite_count'] = Variable<int>(favoriteCount.value);
    }
    if (commentCount.present) {
      map['comment_count'] = Variable<int>(commentCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoStatisticsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('viewCount: $viewCount, ')
          ..write('likeCount: $likeCount, ')
          ..write('dislikeCount: $dislikeCount, ')
          ..write('favoriteCount: $favoriteCount, ')
          ..write('commentCount: $commentCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VideoProgressTable extends VideoProgress
    with TableInfo<$VideoProgressTable, VideoProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES videos (id)',
    ),
  );
  static const VerificationMeta _watchPositionMeta = const VerificationMeta(
    'watchPosition',
  );
  @override
  late final GeneratedColumn<int> watchPosition = GeneratedColumn<int>(
    'watch_position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isFinishedMeta = const VerificationMeta(
    'isFinished',
  );
  @override
  late final GeneratedColumn<bool> isFinished = GeneratedColumn<bool>(
    'is_finished',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_finished" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    watchPosition,
    isFinished,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('watch_position')) {
      context.handle(
        _watchPositionMeta,
        watchPosition.isAcceptableOrUnknown(
          data['watch_position']!,
          _watchPositionMeta,
        ),
      );
    }
    if (data.containsKey('is_finished')) {
      context.handle(
        _isFinishedMeta,
        isFinished.isAcceptableOrUnknown(data['is_finished']!, _isFinishedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoProgressData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      watchPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}watch_position'],
      )!,
      isFinished: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_finished'],
      )!,
    );
  }

  @override
  $VideoProgressTable createAlias(String alias) {
    return $VideoProgressTable(attachedDatabase, alias);
  }
}

class VideoProgressData extends DataClass
    implements Insertable<VideoProgressData> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final int watchPosition;
  final bool isFinished;
  const VideoProgressData({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.watchPosition,
    required this.isFinished,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['watch_position'] = Variable<int>(watchPosition);
    map['is_finished'] = Variable<bool>(isFinished);
    return map;
  }

  VideoProgressCompanion toCompanion(bool nullToAbsent) {
    return VideoProgressCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      watchPosition: Value(watchPosition),
      isFinished: Value(isFinished),
    );
  }

  factory VideoProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoProgressData(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      watchPosition: serializer.fromJson<int>(json['watchPosition']),
      isFinished: serializer.fromJson<bool>(json['isFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'watchPosition': serializer.toJson<int>(watchPosition),
      'isFinished': serializer.toJson<bool>(isFinished),
    };
  }

  VideoProgressData copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    int? watchPosition,
    bool? isFinished,
  }) => VideoProgressData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    watchPosition: watchPosition ?? this.watchPosition,
    isFinished: isFinished ?? this.isFinished,
  );
  VideoProgressData copyWithCompanion(VideoProgressCompanion data) {
    return VideoProgressData(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      watchPosition: data.watchPosition.present
          ? data.watchPosition.value
          : this.watchPosition,
      isFinished: data.isFinished.present
          ? data.isFinished.value
          : this.isFinished,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoProgressData(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('watchPosition: $watchPosition, ')
          ..write('isFinished: $isFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, watchPosition, isFinished);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoProgressData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.watchPosition == this.watchPosition &&
          other.isFinished == this.isFinished);
}

class VideoProgressCompanion extends UpdateCompanion<VideoProgressData> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<int> watchPosition;
  final Value<bool> isFinished;
  final Value<int> rowid;
  const VideoProgressCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.watchPosition = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoProgressCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    this.watchPosition = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<VideoProgressData> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<int>? watchPosition,
    Expression<bool>? isFinished,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (watchPosition != null) 'watch_position': watchPosition,
      if (isFinished != null) 'is_finished': isFinished,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoProgressCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<int>? watchPosition,
    Value<bool>? isFinished,
    Value<int>? rowid,
  }) {
    return VideoProgressCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      watchPosition: watchPosition ?? this.watchPosition,
      isFinished: isFinished ?? this.isFinished,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (watchPosition.present) {
      map['watch_position'] = Variable<int>(watchPosition.value);
    }
    if (isFinished.present) {
      map['is_finished'] = Variable<bool>(isFinished.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoProgressCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('watchPosition: $watchPosition, ')
          ..write('isFinished: $isFinished, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTable extends Playlists
    with TableInfo<$PlaylistsTable, Playlist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _channelIdMeta = const VerificationMeta(
    'channelId',
  );
  @override
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
    'channel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES channels (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PlaylistType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<PlaylistType>($PlaylistsTable.$convertertype);
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _etagMeta = const VerificationMeta('etag');
  @override
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    channelId,
    type,
    priority,
    etag,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlists';
  @override
  VerificationContext validateIntegrity(
    Insertable<Playlist> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('channel_id')) {
      context.handle(
        _channelIdMeta,
        channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_channelIdMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('etag')) {
      context.handle(
        _etagMeta,
        etag.isAcceptableOrUnknown(data['etag']!, _etagMeta),
      );
    } else if (isInserting) {
      context.missing(_etagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Playlist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Playlist(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      channelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel_id'],
      )!,
      type: $PlaylistsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      etag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etag'],
      )!,
    );
  }

  @override
  $PlaylistsTable createAlias(String alias) {
    return $PlaylistsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlaylistType, int, int> $convertertype =
      const EnumIndexConverter<PlaylistType>(PlaylistType.values);
}

class Playlist extends DataClass implements Insertable<Playlist> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String channelId;
  final PlaylistType type;
  final int priority;
  final String etag;
  const Playlist({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.channelId,
    required this.type,
    required this.priority,
    required this.etag,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['channel_id'] = Variable<String>(channelId);
    {
      map['type'] = Variable<int>($PlaylistsTable.$convertertype.toSql(type));
    }
    map['priority'] = Variable<int>(priority);
    map['etag'] = Variable<String>(etag);
    return map;
  }

  PlaylistsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      channelId: Value(channelId),
      type: Value(type),
      priority: Value(priority),
      etag: Value(etag),
    );
  }

  factory Playlist.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Playlist(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      channelId: serializer.fromJson<String>(json['channelId']),
      type: $PlaylistsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      priority: serializer.fromJson<int>(json['priority']),
      etag: serializer.fromJson<String>(json['etag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'channelId': serializer.toJson<String>(channelId),
      'type': serializer.toJson<int>(
        $PlaylistsTable.$convertertype.toJson(type),
      ),
      'priority': serializer.toJson<int>(priority),
      'etag': serializer.toJson<String>(etag),
    };
  }

  Playlist copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? channelId,
    PlaylistType? type,
    int? priority,
    String? etag,
  }) => Playlist(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    channelId: channelId ?? this.channelId,
    type: type ?? this.type,
    priority: priority ?? this.priority,
    etag: etag ?? this.etag,
  );
  Playlist copyWithCompanion(PlaylistsCompanion data) {
    return Playlist(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      type: data.type.present ? data.type.value : this.type,
      priority: data.priority.present ? data.priority.value : this.priority,
      etag: data.etag.present ? data.etag.value : this.etag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Playlist(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('channelId: $channelId, ')
          ..write('type: $type, ')
          ..write('priority: $priority, ')
          ..write('etag: $etag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, channelId, type, priority, etag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Playlist &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.channelId == this.channelId &&
          other.type == this.type &&
          other.priority == this.priority &&
          other.etag == this.etag);
}

class PlaylistsCompanion extends UpdateCompanion<Playlist> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> channelId;
  final Value<PlaylistType> type;
  final Value<int> priority;
  final Value<String> etag;
  final Value<int> rowid;
  const PlaylistsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.channelId = const Value.absent(),
    this.type = const Value.absent(),
    this.priority = const Value.absent(),
    this.etag = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String channelId,
    required PlaylistType type,
    required int priority,
    required String etag,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       channelId = Value(channelId),
       type = Value(type),
       priority = Value(priority),
       etag = Value(etag);
  static Insertable<Playlist> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? channelId,
    Expression<int>? type,
    Expression<int>? priority,
    Expression<String>? etag,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (channelId != null) 'channel_id': channelId,
      if (type != null) 'type': type,
      if (priority != null) 'priority': priority,
      if (etag != null) 'etag': etag,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? channelId,
    Value<PlaylistType>? type,
    Value<int>? priority,
    Value<String>? etag,
    Value<int>? rowid,
  }) {
    return PlaylistsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      channelId: channelId ?? this.channelId,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      etag: etag ?? this.etag,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $PlaylistsTable.$convertertype.toSql(type.value),
      );
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (etag.present) {
      map['etag'] = Variable<String>(etag.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('channelId: $channelId, ')
          ..write('type: $type, ')
          ..write('priority: $priority, ')
          ..write('etag: $etag, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistSnippetsTable extends PlaylistSnippets
    with TableInfo<$PlaylistSnippetsTable, PlaylistSnippet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistSnippetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES playlists (id)',
    ),
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _channelTitleMeta = const VerificationMeta(
    'channelTitle',
  );
  @override
  late final GeneratedColumn<String> channelTitle = GeneratedColumn<String>(
    'channel_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    publishedAt,
    title,
    description,
    channelTitle,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_snippets';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaylistSnippet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_publishedAtMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('channel_title')) {
      context.handle(
        _channelTitleMeta,
        channelTitle.isAcceptableOrUnknown(
          data['channel_title']!,
          _channelTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_channelTitleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistSnippet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistSnippet(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      channelTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel_title'],
      )!,
    );
  }

  @override
  $PlaylistSnippetsTable createAlias(String alias) {
    return $PlaylistSnippetsTable(attachedDatabase, alias);
  }
}

class PlaylistSnippet extends DataClass implements Insertable<PlaylistSnippet> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final DateTime publishedAt;
  final String title;
  final String description;
  final String channelTitle;
  const PlaylistSnippet({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.publishedAt,
    required this.title,
    required this.description,
    required this.channelTitle,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['published_at'] = Variable<DateTime>(publishedAt);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['channel_title'] = Variable<String>(channelTitle);
    return map;
  }

  PlaylistSnippetsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistSnippetsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      publishedAt: Value(publishedAt),
      title: Value(title),
      description: Value(description),
      channelTitle: Value(channelTitle),
    );
  }

  factory PlaylistSnippet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistSnippet(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      channelTitle: serializer.fromJson<String>(json['channelTitle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'channelTitle': serializer.toJson<String>(channelTitle),
    };
  }

  PlaylistSnippet copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    DateTime? publishedAt,
    String? title,
    String? description,
    String? channelTitle,
  }) => PlaylistSnippet(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    publishedAt: publishedAt ?? this.publishedAt,
    title: title ?? this.title,
    description: description ?? this.description,
    channelTitle: channelTitle ?? this.channelTitle,
  );
  PlaylistSnippet copyWithCompanion(PlaylistSnippetsCompanion data) {
    return PlaylistSnippet(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      channelTitle: data.channelTitle.present
          ? data.channelTitle.value
          : this.channelTitle,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistSnippet(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('channelTitle: $channelTitle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    publishedAt,
    title,
    description,
    channelTitle,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistSnippet &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.publishedAt == this.publishedAt &&
          other.title == this.title &&
          other.description == this.description &&
          other.channelTitle == this.channelTitle);
}

class PlaylistSnippetsCompanion extends UpdateCompanion<PlaylistSnippet> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<DateTime> publishedAt;
  final Value<String> title;
  final Value<String> description;
  final Value<String> channelTitle;
  final Value<int> rowid;
  const PlaylistSnippetsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.channelTitle = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistSnippetsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required DateTime publishedAt,
    required String title,
    required String description,
    required String channelTitle,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       publishedAt = Value(publishedAt),
       title = Value(title),
       description = Value(description),
       channelTitle = Value(channelTitle);
  static Insertable<PlaylistSnippet> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<DateTime>? publishedAt,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? channelTitle,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (publishedAt != null) 'published_at': publishedAt,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (channelTitle != null) 'channel_title': channelTitle,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistSnippetsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<DateTime>? publishedAt,
    Value<String>? title,
    Value<String>? description,
    Value<String>? channelTitle,
    Value<int>? rowid,
  }) {
    return PlaylistSnippetsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      publishedAt: publishedAt ?? this.publishedAt,
      title: title ?? this.title,
      description: description ?? this.description,
      channelTitle: channelTitle ?? this.channelTitle,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (channelTitle.present) {
      map['channel_title'] = Variable<String>(channelTitle.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistSnippetsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('channelTitle: $channelTitle, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistThumbnailsTable extends PlaylistThumbnails
    with TableInfo<$PlaylistThumbnailsTable, PlaylistThumbnail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistThumbnailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES playlists (id)',
    ),
  );
  static const VerificationMeta _defaultUrlMeta = const VerificationMeta(
    'defaultUrl',
  );
  @override
  late final GeneratedColumn<String> defaultUrl = GeneratedColumn<String>(
    'default_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediumUrlMeta = const VerificationMeta(
    'mediumUrl',
  );
  @override
  late final GeneratedColumn<String> mediumUrl = GeneratedColumn<String>(
    'medium_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _highUrlMeta = const VerificationMeta(
    'highUrl',
  );
  @override
  late final GeneratedColumn<String> highUrl = GeneratedColumn<String>(
    'high_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _standardUrlMeta = const VerificationMeta(
    'standardUrl',
  );
  @override
  late final GeneratedColumn<String> standardUrl = GeneratedColumn<String>(
    'standard_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxresUrlMeta = const VerificationMeta(
    'maxresUrl',
  );
  @override
  late final GeneratedColumn<String> maxresUrl = GeneratedColumn<String>(
    'maxres_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    defaultUrl,
    mediumUrl,
    highUrl,
    standardUrl,
    maxresUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_thumbnails';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaylistThumbnail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('default_url')) {
      context.handle(
        _defaultUrlMeta,
        defaultUrl.isAcceptableOrUnknown(data['default_url']!, _defaultUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_defaultUrlMeta);
    }
    if (data.containsKey('medium_url')) {
      context.handle(
        _mediumUrlMeta,
        mediumUrl.isAcceptableOrUnknown(data['medium_url']!, _mediumUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_mediumUrlMeta);
    }
    if (data.containsKey('high_url')) {
      context.handle(
        _highUrlMeta,
        highUrl.isAcceptableOrUnknown(data['high_url']!, _highUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_highUrlMeta);
    }
    if (data.containsKey('standard_url')) {
      context.handle(
        _standardUrlMeta,
        standardUrl.isAcceptableOrUnknown(
          data['standard_url']!,
          _standardUrlMeta,
        ),
      );
    }
    if (data.containsKey('maxres_url')) {
      context.handle(
        _maxresUrlMeta,
        maxresUrl.isAcceptableOrUnknown(data['maxres_url']!, _maxresUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistThumbnail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistThumbnail(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      defaultUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_url'],
      )!,
      mediumUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medium_url'],
      )!,
      highUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}high_url'],
      )!,
      standardUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}standard_url'],
      ),
      maxresUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}maxres_url'],
      ),
    );
  }

  @override
  $PlaylistThumbnailsTable createAlias(String alias) {
    return $PlaylistThumbnailsTable(attachedDatabase, alias);
  }
}

class PlaylistThumbnail extends DataClass
    implements Insertable<PlaylistThumbnail> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String defaultUrl;
  final String mediumUrl;
  final String highUrl;
  final String? standardUrl;
  final String? maxresUrl;
  const PlaylistThumbnail({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.defaultUrl,
    required this.mediumUrl,
    required this.highUrl,
    this.standardUrl,
    this.maxresUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['default_url'] = Variable<String>(defaultUrl);
    map['medium_url'] = Variable<String>(mediumUrl);
    map['high_url'] = Variable<String>(highUrl);
    if (!nullToAbsent || standardUrl != null) {
      map['standard_url'] = Variable<String>(standardUrl);
    }
    if (!nullToAbsent || maxresUrl != null) {
      map['maxres_url'] = Variable<String>(maxresUrl);
    }
    return map;
  }

  PlaylistThumbnailsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistThumbnailsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      defaultUrl: Value(defaultUrl),
      mediumUrl: Value(mediumUrl),
      highUrl: Value(highUrl),
      standardUrl: standardUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(standardUrl),
      maxresUrl: maxresUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(maxresUrl),
    );
  }

  factory PlaylistThumbnail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistThumbnail(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      defaultUrl: serializer.fromJson<String>(json['defaultUrl']),
      mediumUrl: serializer.fromJson<String>(json['mediumUrl']),
      highUrl: serializer.fromJson<String>(json['highUrl']),
      standardUrl: serializer.fromJson<String?>(json['standardUrl']),
      maxresUrl: serializer.fromJson<String?>(json['maxresUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'defaultUrl': serializer.toJson<String>(defaultUrl),
      'mediumUrl': serializer.toJson<String>(mediumUrl),
      'highUrl': serializer.toJson<String>(highUrl),
      'standardUrl': serializer.toJson<String?>(standardUrl),
      'maxresUrl': serializer.toJson<String?>(maxresUrl),
    };
  }

  PlaylistThumbnail copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? defaultUrl,
    String? mediumUrl,
    String? highUrl,
    Value<String?> standardUrl = const Value.absent(),
    Value<String?> maxresUrl = const Value.absent(),
  }) => PlaylistThumbnail(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    defaultUrl: defaultUrl ?? this.defaultUrl,
    mediumUrl: mediumUrl ?? this.mediumUrl,
    highUrl: highUrl ?? this.highUrl,
    standardUrl: standardUrl.present ? standardUrl.value : this.standardUrl,
    maxresUrl: maxresUrl.present ? maxresUrl.value : this.maxresUrl,
  );
  PlaylistThumbnail copyWithCompanion(PlaylistThumbnailsCompanion data) {
    return PlaylistThumbnail(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      defaultUrl: data.defaultUrl.present
          ? data.defaultUrl.value
          : this.defaultUrl,
      mediumUrl: data.mediumUrl.present ? data.mediumUrl.value : this.mediumUrl,
      highUrl: data.highUrl.present ? data.highUrl.value : this.highUrl,
      standardUrl: data.standardUrl.present
          ? data.standardUrl.value
          : this.standardUrl,
      maxresUrl: data.maxresUrl.present ? data.maxresUrl.value : this.maxresUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistThumbnail(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('defaultUrl: $defaultUrl, ')
          ..write('mediumUrl: $mediumUrl, ')
          ..write('highUrl: $highUrl, ')
          ..write('standardUrl: $standardUrl, ')
          ..write('maxresUrl: $maxresUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    defaultUrl,
    mediumUrl,
    highUrl,
    standardUrl,
    maxresUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistThumbnail &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.defaultUrl == this.defaultUrl &&
          other.mediumUrl == this.mediumUrl &&
          other.highUrl == this.highUrl &&
          other.standardUrl == this.standardUrl &&
          other.maxresUrl == this.maxresUrl);
}

class PlaylistThumbnailsCompanion extends UpdateCompanion<PlaylistThumbnail> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> defaultUrl;
  final Value<String> mediumUrl;
  final Value<String> highUrl;
  final Value<String?> standardUrl;
  final Value<String?> maxresUrl;
  final Value<int> rowid;
  const PlaylistThumbnailsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.defaultUrl = const Value.absent(),
    this.mediumUrl = const Value.absent(),
    this.highUrl = const Value.absent(),
    this.standardUrl = const Value.absent(),
    this.maxresUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistThumbnailsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String defaultUrl,
    required String mediumUrl,
    required String highUrl,
    this.standardUrl = const Value.absent(),
    this.maxresUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       defaultUrl = Value(defaultUrl),
       mediumUrl = Value(mediumUrl),
       highUrl = Value(highUrl);
  static Insertable<PlaylistThumbnail> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? defaultUrl,
    Expression<String>? mediumUrl,
    Expression<String>? highUrl,
    Expression<String>? standardUrl,
    Expression<String>? maxresUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (defaultUrl != null) 'default_url': defaultUrl,
      if (mediumUrl != null) 'medium_url': mediumUrl,
      if (highUrl != null) 'high_url': highUrl,
      if (standardUrl != null) 'standard_url': standardUrl,
      if (maxresUrl != null) 'maxres_url': maxresUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistThumbnailsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? defaultUrl,
    Value<String>? mediumUrl,
    Value<String>? highUrl,
    Value<String?>? standardUrl,
    Value<String?>? maxresUrl,
    Value<int>? rowid,
  }) {
    return PlaylistThumbnailsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      defaultUrl: defaultUrl ?? this.defaultUrl,
      mediumUrl: mediumUrl ?? this.mediumUrl,
      highUrl: highUrl ?? this.highUrl,
      standardUrl: standardUrl ?? this.standardUrl,
      maxresUrl: maxresUrl ?? this.maxresUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (defaultUrl.present) {
      map['default_url'] = Variable<String>(defaultUrl.value);
    }
    if (mediumUrl.present) {
      map['medium_url'] = Variable<String>(mediumUrl.value);
    }
    if (highUrl.present) {
      map['high_url'] = Variable<String>(highUrl.value);
    }
    if (standardUrl.present) {
      map['standard_url'] = Variable<String>(standardUrl.value);
    }
    if (maxresUrl.present) {
      map['maxres_url'] = Variable<String>(maxresUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistThumbnailsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('defaultUrl: $defaultUrl, ')
          ..write('mediumUrl: $mediumUrl, ')
          ..write('highUrl: $highUrl, ')
          ..write('standardUrl: $standardUrl, ')
          ..write('maxresUrl: $maxresUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistContentDetailsTable extends PlaylistContentDetails
    with TableInfo<$PlaylistContentDetailsTable, PlaylistContentDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistContentDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES playlists (id)',
    ),
  );
  static const VerificationMeta _itemCountMeta = const VerificationMeta(
    'itemCount',
  );
  @override
  late final GeneratedColumn<int> itemCount = GeneratedColumn<int>(
    'item_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [createdAt, updatedAt, id, itemCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_content_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaylistContentDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_count')) {
      context.handle(
        _itemCountMeta,
        itemCount.isAcceptableOrUnknown(data['item_count']!, _itemCountMeta),
      );
    } else if (isInserting) {
      context.missing(_itemCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistContentDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistContentDetail(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_count'],
      )!,
    );
  }

  @override
  $PlaylistContentDetailsTable createAlias(String alias) {
    return $PlaylistContentDetailsTable(attachedDatabase, alias);
  }
}

class PlaylistContentDetail extends DataClass
    implements Insertable<PlaylistContentDetail> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final int itemCount;
  const PlaylistContentDetail({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.itemCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['item_count'] = Variable<int>(itemCount);
    return map;
  }

  PlaylistContentDetailsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistContentDetailsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      itemCount: Value(itemCount),
    );
  }

  factory PlaylistContentDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistContentDetail(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      itemCount: serializer.fromJson<int>(json['itemCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'itemCount': serializer.toJson<int>(itemCount),
    };
  }

  PlaylistContentDetail copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    int? itemCount,
  }) => PlaylistContentDetail(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    itemCount: itemCount ?? this.itemCount,
  );
  PlaylistContentDetail copyWithCompanion(
    PlaylistContentDetailsCompanion data,
  ) {
    return PlaylistContentDetail(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      itemCount: data.itemCount.present ? data.itemCount.value : this.itemCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistContentDetail(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('itemCount: $itemCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, id, itemCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistContentDetail &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.itemCount == this.itemCount);
}

class PlaylistContentDetailsCompanion
    extends UpdateCompanion<PlaylistContentDetail> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<int> itemCount;
  final Value<int> rowid;
  const PlaylistContentDetailsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.itemCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistContentDetailsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required int itemCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       itemCount = Value(itemCount);
  static Insertable<PlaylistContentDetail> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<int>? itemCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (itemCount != null) 'item_count': itemCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistContentDetailsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<int>? itemCount,
    Value<int>? rowid,
  }) {
    return PlaylistContentDetailsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      itemCount: itemCount ?? this.itemCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemCount.present) {
      map['item_count'] = Variable<int>(itemCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistContentDetailsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('itemCount: $itemCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistVsVideosTable extends PlaylistVsVideos
    with TableInfo<$PlaylistVsVideosTable, PlaylistVsVideo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistVsVideosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playlistIdMeta = const VerificationMeta(
    'playlistId',
  );
  @override
  late final GeneratedColumn<String> playlistId = GeneratedColumn<String>(
    'playlist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES playlists (id)',
    ),
  );
  static const VerificationMeta _videoIdMeta = const VerificationMeta(
    'videoId',
  );
  @override
  late final GeneratedColumn<String> videoId = GeneratedColumn<String>(
    'video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES videos (id)',
    ),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [playlistId, videoId, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_vs_videos';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaylistVsVideo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
        _playlistIdMeta,
        playlistId.isAcceptableOrUnknown(data['playlist_id']!, _playlistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('video_id')) {
      context.handle(
        _videoIdMeta,
        videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, videoId};
  @override
  PlaylistVsVideo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistVsVideo(
      playlistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}playlist_id'],
      )!,
      videoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_id'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
    );
  }

  @override
  $PlaylistVsVideosTable createAlias(String alias) {
    return $PlaylistVsVideosTable(attachedDatabase, alias);
  }
}

class PlaylistVsVideo extends DataClass implements Insertable<PlaylistVsVideo> {
  final String playlistId;
  final String videoId;
  final int priority;
  const PlaylistVsVideo({
    required this.playlistId,
    required this.videoId,
    required this.priority,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['playlist_id'] = Variable<String>(playlistId);
    map['video_id'] = Variable<String>(videoId);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  PlaylistVsVideosCompanion toCompanion(bool nullToAbsent) {
    return PlaylistVsVideosCompanion(
      playlistId: Value(playlistId),
      videoId: Value(videoId),
      priority: Value(priority),
    );
  }

  factory PlaylistVsVideo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistVsVideo(
      playlistId: serializer.fromJson<String>(json['playlistId']),
      videoId: serializer.fromJson<String>(json['videoId']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playlistId': serializer.toJson<String>(playlistId),
      'videoId': serializer.toJson<String>(videoId),
      'priority': serializer.toJson<int>(priority),
    };
  }

  PlaylistVsVideo copyWith({
    String? playlistId,
    String? videoId,
    int? priority,
  }) => PlaylistVsVideo(
    playlistId: playlistId ?? this.playlistId,
    videoId: videoId ?? this.videoId,
    priority: priority ?? this.priority,
  );
  PlaylistVsVideo copyWithCompanion(PlaylistVsVideosCompanion data) {
    return PlaylistVsVideo(
      playlistId: data.playlistId.present
          ? data.playlistId.value
          : this.playlistId,
      videoId: data.videoId.present ? data.videoId.value : this.videoId,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistVsVideo(')
          ..write('playlistId: $playlistId, ')
          ..write('videoId: $videoId, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playlistId, videoId, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistVsVideo &&
          other.playlistId == this.playlistId &&
          other.videoId == this.videoId &&
          other.priority == this.priority);
}

class PlaylistVsVideosCompanion extends UpdateCompanion<PlaylistVsVideo> {
  final Value<String> playlistId;
  final Value<String> videoId;
  final Value<int> priority;
  final Value<int> rowid;
  const PlaylistVsVideosCompanion({
    this.playlistId = const Value.absent(),
    this.videoId = const Value.absent(),
    this.priority = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistVsVideosCompanion.insert({
    required String playlistId,
    required String videoId,
    required int priority,
    this.rowid = const Value.absent(),
  }) : playlistId = Value(playlistId),
       videoId = Value(videoId),
       priority = Value(priority);
  static Insertable<PlaylistVsVideo> custom({
    Expression<String>? playlistId,
    Expression<String>? videoId,
    Expression<int>? priority,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (videoId != null) 'video_id': videoId,
      if (priority != null) 'priority': priority,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistVsVideosCompanion copyWith({
    Value<String>? playlistId,
    Value<String>? videoId,
    Value<int>? priority,
    Value<int>? rowid,
  }) {
    return PlaylistVsVideosCompanion(
      playlistId: playlistId ?? this.playlistId,
      videoId: videoId ?? this.videoId,
      priority: priority ?? this.priority,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<String>(videoId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistVsVideosCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('videoId: $videoId, ')
          ..write('priority: $priority, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChannelSearchesTable extends ChannelSearches
    with TableInfo<$ChannelSearchesTable, ChannelSearche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChannelSearchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
    'query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [createdAt, updatedAt, id, query];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_searches';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChannelSearche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('query')) {
      context.handle(
        _queryMeta,
        query.isAcceptableOrUnknown(data['query']!, _queryMeta),
      );
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelSearche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelSearche(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      query: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}query'],
      )!,
    );
  }

  @override
  $ChannelSearchesTable createAlias(String alias) {
    return $ChannelSearchesTable(attachedDatabase, alias);
  }
}

class ChannelSearche extends DataClass implements Insertable<ChannelSearche> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final String query;
  const ChannelSearche({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.query,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<int>(id);
    map['query'] = Variable<String>(query);
    return map;
  }

  ChannelSearchesCompanion toCompanion(bool nullToAbsent) {
    return ChannelSearchesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      query: Value(query),
    );
  }

  factory ChannelSearche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelSearche(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<int>(json['id']),
      query: serializer.fromJson<String>(json['query']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<int>(id),
      'query': serializer.toJson<String>(query),
    };
  }

  ChannelSearche copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    int? id,
    String? query,
  }) => ChannelSearche(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    query: query ?? this.query,
  );
  ChannelSearche copyWithCompanion(ChannelSearchesCompanion data) {
    return ChannelSearche(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      query: data.query.present ? data.query.value : this.query,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelSearche(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('query: $query')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, id, query);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelSearche &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.query == this.query);
}

class ChannelSearchesCompanion extends UpdateCompanion<ChannelSearche> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> id;
  final Value<String> query;
  const ChannelSearchesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.query = const Value.absent(),
  });
  ChannelSearchesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    required String query,
  }) : query = Value(query);
  static Insertable<ChannelSearche> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? id,
    Expression<String>? query,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (query != null) 'query': query,
    });
  }

  ChannelSearchesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? id,
    Value<String>? query,
  }) {
    return ChannelSearchesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      query: query ?? this.query,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelSearchesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('query: $query')
          ..write(')'))
        .toString();
  }
}

class $ChannelSearchVsChannelsTable extends ChannelSearchVsChannels
    with TableInfo<$ChannelSearchVsChannelsTable, ChannelSearchVsChannel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChannelSearchVsChannelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _searchIdMeta = const VerificationMeta(
    'searchId',
  );
  @override
  late final GeneratedColumn<int> searchId = GeneratedColumn<int>(
    'search_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES channel_searches (id)',
    ),
  );
  static const VerificationMeta _channelIdMeta = const VerificationMeta(
    'channelId',
  );
  @override
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
    'channel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES channels (id)',
    ),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [searchId, channelId, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_search_vs_channels';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChannelSearchVsChannel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('search_id')) {
      context.handle(
        _searchIdMeta,
        searchId.isAcceptableOrUnknown(data['search_id']!, _searchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_searchIdMeta);
    }
    if (data.containsKey('channel_id')) {
      context.handle(
        _channelIdMeta,
        channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_channelIdMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {searchId, channelId};
  @override
  ChannelSearchVsChannel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelSearchVsChannel(
      searchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}search_id'],
      )!,
      channelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel_id'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
    );
  }

  @override
  $ChannelSearchVsChannelsTable createAlias(String alias) {
    return $ChannelSearchVsChannelsTable(attachedDatabase, alias);
  }
}

class ChannelSearchVsChannel extends DataClass
    implements Insertable<ChannelSearchVsChannel> {
  final int searchId;
  final String channelId;
  final int priority;
  const ChannelSearchVsChannel({
    required this.searchId,
    required this.channelId,
    required this.priority,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['search_id'] = Variable<int>(searchId);
    map['channel_id'] = Variable<String>(channelId);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  ChannelSearchVsChannelsCompanion toCompanion(bool nullToAbsent) {
    return ChannelSearchVsChannelsCompanion(
      searchId: Value(searchId),
      channelId: Value(channelId),
      priority: Value(priority),
    );
  }

  factory ChannelSearchVsChannel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelSearchVsChannel(
      searchId: serializer.fromJson<int>(json['searchId']),
      channelId: serializer.fromJson<String>(json['channelId']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'searchId': serializer.toJson<int>(searchId),
      'channelId': serializer.toJson<String>(channelId),
      'priority': serializer.toJson<int>(priority),
    };
  }

  ChannelSearchVsChannel copyWith({
    int? searchId,
    String? channelId,
    int? priority,
  }) => ChannelSearchVsChannel(
    searchId: searchId ?? this.searchId,
    channelId: channelId ?? this.channelId,
    priority: priority ?? this.priority,
  );
  ChannelSearchVsChannel copyWithCompanion(
    ChannelSearchVsChannelsCompanion data,
  ) {
    return ChannelSearchVsChannel(
      searchId: data.searchId.present ? data.searchId.value : this.searchId,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelSearchVsChannel(')
          ..write('searchId: $searchId, ')
          ..write('channelId: $channelId, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(searchId, channelId, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelSearchVsChannel &&
          other.searchId == this.searchId &&
          other.channelId == this.channelId &&
          other.priority == this.priority);
}

class ChannelSearchVsChannelsCompanion
    extends UpdateCompanion<ChannelSearchVsChannel> {
  final Value<int> searchId;
  final Value<String> channelId;
  final Value<int> priority;
  final Value<int> rowid;
  const ChannelSearchVsChannelsCompanion({
    this.searchId = const Value.absent(),
    this.channelId = const Value.absent(),
    this.priority = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelSearchVsChannelsCompanion.insert({
    required int searchId,
    required String channelId,
    required int priority,
    this.rowid = const Value.absent(),
  }) : searchId = Value(searchId),
       channelId = Value(channelId),
       priority = Value(priority);
  static Insertable<ChannelSearchVsChannel> custom({
    Expression<int>? searchId,
    Expression<String>? channelId,
    Expression<int>? priority,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (searchId != null) 'search_id': searchId,
      if (channelId != null) 'channel_id': channelId,
      if (priority != null) 'priority': priority,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelSearchVsChannelsCompanion copyWith({
    Value<int>? searchId,
    Value<String>? channelId,
    Value<int>? priority,
    Value<int>? rowid,
  }) {
    return ChannelSearchVsChannelsCompanion(
      searchId: searchId ?? this.searchId,
      channelId: channelId ?? this.channelId,
      priority: priority ?? this.priority,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (searchId.present) {
      map['search_id'] = Variable<int>(searchId.value);
    }
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelSearchVsChannelsCompanion(')
          ..write('searchId: $searchId, ')
          ..write('channelId: $channelId, ')
          ..write('priority: $priority, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VideoSearchesTable extends VideoSearches
    with TableInfo<$VideoSearchesTable, VideoSearche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoSearchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
    'query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [createdAt, updatedAt, id, query];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_searches';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoSearche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('query')) {
      context.handle(
        _queryMeta,
        query.isAcceptableOrUnknown(data['query']!, _queryMeta),
      );
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoSearche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoSearche(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      query: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}query'],
      )!,
    );
  }

  @override
  $VideoSearchesTable createAlias(String alias) {
    return $VideoSearchesTable(attachedDatabase, alias);
  }
}

class VideoSearche extends DataClass implements Insertable<VideoSearche> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final String query;
  const VideoSearche({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.query,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<int>(id);
    map['query'] = Variable<String>(query);
    return map;
  }

  VideoSearchesCompanion toCompanion(bool nullToAbsent) {
    return VideoSearchesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      query: Value(query),
    );
  }

  factory VideoSearche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoSearche(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<int>(json['id']),
      query: serializer.fromJson<String>(json['query']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<int>(id),
      'query': serializer.toJson<String>(query),
    };
  }

  VideoSearche copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    int? id,
    String? query,
  }) => VideoSearche(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    query: query ?? this.query,
  );
  VideoSearche copyWithCompanion(VideoSearchesCompanion data) {
    return VideoSearche(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      query: data.query.present ? data.query.value : this.query,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoSearche(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('query: $query')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, id, query);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoSearche &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.query == this.query);
}

class VideoSearchesCompanion extends UpdateCompanion<VideoSearche> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> id;
  final Value<String> query;
  const VideoSearchesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.query = const Value.absent(),
  });
  VideoSearchesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    required String query,
  }) : query = Value(query);
  static Insertable<VideoSearche> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? id,
    Expression<String>? query,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (query != null) 'query': query,
    });
  }

  VideoSearchesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? id,
    Value<String>? query,
  }) {
    return VideoSearchesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      query: query ?? this.query,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoSearchesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('query: $query')
          ..write(')'))
        .toString();
  }
}

class $VideoSearchVsVideosTable extends VideoSearchVsVideos
    with TableInfo<$VideoSearchVsVideosTable, VideoSearchVsVideo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoSearchVsVideosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _searchIdMeta = const VerificationMeta(
    'searchId',
  );
  @override
  late final GeneratedColumn<int> searchId = GeneratedColumn<int>(
    'search_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES video_searches (id)',
    ),
  );
  static const VerificationMeta _videoIdMeta = const VerificationMeta(
    'videoId',
  );
  @override
  late final GeneratedColumn<String> videoId = GeneratedColumn<String>(
    'video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES videos (id)',
    ),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [searchId, videoId, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_search_vs_videos';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoSearchVsVideo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('search_id')) {
      context.handle(
        _searchIdMeta,
        searchId.isAcceptableOrUnknown(data['search_id']!, _searchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_searchIdMeta);
    }
    if (data.containsKey('video_id')) {
      context.handle(
        _videoIdMeta,
        videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {searchId, videoId};
  @override
  VideoSearchVsVideo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoSearchVsVideo(
      searchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}search_id'],
      )!,
      videoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_id'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
    );
  }

  @override
  $VideoSearchVsVideosTable createAlias(String alias) {
    return $VideoSearchVsVideosTable(attachedDatabase, alias);
  }
}

class VideoSearchVsVideo extends DataClass
    implements Insertable<VideoSearchVsVideo> {
  final int searchId;
  final String videoId;
  final int priority;
  const VideoSearchVsVideo({
    required this.searchId,
    required this.videoId,
    required this.priority,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['search_id'] = Variable<int>(searchId);
    map['video_id'] = Variable<String>(videoId);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  VideoSearchVsVideosCompanion toCompanion(bool nullToAbsent) {
    return VideoSearchVsVideosCompanion(
      searchId: Value(searchId),
      videoId: Value(videoId),
      priority: Value(priority),
    );
  }

  factory VideoSearchVsVideo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoSearchVsVideo(
      searchId: serializer.fromJson<int>(json['searchId']),
      videoId: serializer.fromJson<String>(json['videoId']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'searchId': serializer.toJson<int>(searchId),
      'videoId': serializer.toJson<String>(videoId),
      'priority': serializer.toJson<int>(priority),
    };
  }

  VideoSearchVsVideo copyWith({
    int? searchId,
    String? videoId,
    int? priority,
  }) => VideoSearchVsVideo(
    searchId: searchId ?? this.searchId,
    videoId: videoId ?? this.videoId,
    priority: priority ?? this.priority,
  );
  VideoSearchVsVideo copyWithCompanion(VideoSearchVsVideosCompanion data) {
    return VideoSearchVsVideo(
      searchId: data.searchId.present ? data.searchId.value : this.searchId,
      videoId: data.videoId.present ? data.videoId.value : this.videoId,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoSearchVsVideo(')
          ..write('searchId: $searchId, ')
          ..write('videoId: $videoId, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(searchId, videoId, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoSearchVsVideo &&
          other.searchId == this.searchId &&
          other.videoId == this.videoId &&
          other.priority == this.priority);
}

class VideoSearchVsVideosCompanion extends UpdateCompanion<VideoSearchVsVideo> {
  final Value<int> searchId;
  final Value<String> videoId;
  final Value<int> priority;
  final Value<int> rowid;
  const VideoSearchVsVideosCompanion({
    this.searchId = const Value.absent(),
    this.videoId = const Value.absent(),
    this.priority = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoSearchVsVideosCompanion.insert({
    required int searchId,
    required String videoId,
    required int priority,
    this.rowid = const Value.absent(),
  }) : searchId = Value(searchId),
       videoId = Value(videoId),
       priority = Value(priority);
  static Insertable<VideoSearchVsVideo> custom({
    Expression<int>? searchId,
    Expression<String>? videoId,
    Expression<int>? priority,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (searchId != null) 'search_id': searchId,
      if (videoId != null) 'video_id': videoId,
      if (priority != null) 'priority': priority,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoSearchVsVideosCompanion copyWith({
    Value<int>? searchId,
    Value<String>? videoId,
    Value<int>? priority,
    Value<int>? rowid,
  }) {
    return VideoSearchVsVideosCompanion(
      searchId: searchId ?? this.searchId,
      videoId: videoId ?? this.videoId,
      priority: priority ?? this.priority,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (searchId.present) {
      map['search_id'] = Variable<int>(searchId.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<String>(videoId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoSearchVsVideosCompanion(')
          ..write('searchId: $searchId, ')
          ..write('videoId: $videoId, ')
          ..write('priority: $priority, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CollectionsTable extends Collections
    with TableInfo<$CollectionsTable, Collection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    isSystem,
    priority,
    name,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Collection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    } else if (isInserting) {
      context.missing(_isSystemMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Collection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Collection(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $CollectionsTable createAlias(String alias) {
    return $CollectionsTable(attachedDatabase, alias);
  }
}

class Collection extends DataClass implements Insertable<Collection> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final bool isSystem;
  final int priority;
  final String name;
  final String description;
  const Collection({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.isSystem,
    required this.priority,
    required this.name,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<int>(id);
    map['is_system'] = Variable<bool>(isSystem);
    map['priority'] = Variable<int>(priority);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    return map;
  }

  CollectionsCompanion toCompanion(bool nullToAbsent) {
    return CollectionsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      isSystem: Value(isSystem),
      priority: Value(priority),
      name: Value(name),
      description: Value(description),
    );
  }

  factory Collection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Collection(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<int>(json['id']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      priority: serializer.fromJson<int>(json['priority']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<int>(id),
      'isSystem': serializer.toJson<bool>(isSystem),
      'priority': serializer.toJson<int>(priority),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  Collection copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    int? id,
    bool? isSystem,
    int? priority,
    String? name,
    String? description,
  }) => Collection(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    isSystem: isSystem ?? this.isSystem,
    priority: priority ?? this.priority,
    name: name ?? this.name,
    description: description ?? this.description,
  );
  Collection copyWithCompanion(CollectionsCompanion data) {
    return Collection(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      priority: data.priority.present ? data.priority.value : this.priority,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Collection(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('isSystem: $isSystem, ')
          ..write('priority: $priority, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    isSystem,
    priority,
    name,
    description,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Collection &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.isSystem == this.isSystem &&
          other.priority == this.priority &&
          other.name == this.name &&
          other.description == this.description);
}

class CollectionsCompanion extends UpdateCompanion<Collection> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> id;
  final Value<bool> isSystem;
  final Value<int> priority;
  final Value<String> name;
  final Value<String> description;
  const CollectionsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.priority = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  CollectionsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    required bool isSystem,
    required int priority,
    required String name,
    required String description,
  }) : isSystem = Value(isSystem),
       priority = Value(priority),
       name = Value(name),
       description = Value(description);
  static Insertable<Collection> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? id,
    Expression<bool>? isSystem,
    Expression<int>? priority,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (isSystem != null) 'is_system': isSystem,
      if (priority != null) 'priority': priority,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  CollectionsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? id,
    Value<bool>? isSystem,
    Value<int>? priority,
    Value<String>? name,
    Value<String>? description,
  }) {
    return CollectionsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      isSystem: isSystem ?? this.isSystem,
      priority: priority ?? this.priority,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('isSystem: $isSystem, ')
          ..write('priority: $priority, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $SeriesTable extends Series with TableInfo<$SeriesTable, Sery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collections (id)',
    ),
  );
  static const VerificationMeta _coverVideoIdMeta = const VerificationMeta(
    'coverVideoId',
  );
  @override
  late final GeneratedColumn<String> coverVideoId = GeneratedColumn<String>(
    'cover_video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES videos (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    collectionId,
    coverVideoId,
    name,
    description,
    priority,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'series';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sery> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('cover_video_id')) {
      context.handle(
        _coverVideoIdMeta,
        coverVideoId.isAcceptableOrUnknown(
          data['cover_video_id']!,
          _coverVideoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coverVideoIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sery map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sery(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}collection_id'],
      )!,
      coverVideoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_video_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
    );
  }

  @override
  $SeriesTable createAlias(String alias) {
    return $SeriesTable(attachedDatabase, alias);
  }
}

class Sery extends DataClass implements Insertable<Sery> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int collectionId;
  final String coverVideoId;
  final String name;
  final String description;
  final int priority;
  const Sery({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.collectionId,
    required this.coverVideoId,
    required this.name,
    required this.description,
    required this.priority,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<int>(collectionId);
    map['cover_video_id'] = Variable<String>(coverVideoId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  SeriesCompanion toCompanion(bool nullToAbsent) {
    return SeriesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      collectionId: Value(collectionId),
      coverVideoId: Value(coverVideoId),
      name: Value(name),
      description: Value(description),
      priority: Value(priority),
    );
  }

  factory Sery.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sery(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int>(json['collectionId']),
      coverVideoId: serializer.fromJson<String>(json['coverVideoId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int>(collectionId),
      'coverVideoId': serializer.toJson<String>(coverVideoId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'priority': serializer.toJson<int>(priority),
    };
  }

  Sery copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    int? id,
    int? collectionId,
    String? coverVideoId,
    String? name,
    String? description,
    int? priority,
  }) => Sery(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    coverVideoId: coverVideoId ?? this.coverVideoId,
    name: name ?? this.name,
    description: description ?? this.description,
    priority: priority ?? this.priority,
  );
  Sery copyWithCompanion(SeriesCompanion data) {
    return Sery(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      coverVideoId: data.coverVideoId.present
          ? data.coverVideoId.value
          : this.coverVideoId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sery(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('coverVideoId: $coverVideoId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    collectionId,
    coverVideoId,
    name,
    description,
    priority,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sery &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.coverVideoId == this.coverVideoId &&
          other.name == this.name &&
          other.description == this.description &&
          other.priority == this.priority);
}

class SeriesCompanion extends UpdateCompanion<Sery> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> id;
  final Value<int> collectionId;
  final Value<String> coverVideoId;
  final Value<String> name;
  final Value<String> description;
  final Value<int> priority;
  const SeriesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.coverVideoId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
  });
  SeriesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    required int collectionId,
    required String coverVideoId,
    required String name,
    required String description,
    required int priority,
  }) : collectionId = Value(collectionId),
       coverVideoId = Value(coverVideoId),
       name = Value(name),
       description = Value(description),
       priority = Value(priority);
  static Insertable<Sery> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<String>? coverVideoId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? priority,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (coverVideoId != null) 'cover_video_id': coverVideoId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (priority != null) 'priority': priority,
    });
  }

  SeriesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? id,
    Value<int>? collectionId,
    Value<String>? coverVideoId,
    Value<String>? name,
    Value<String>? description,
    Value<int>? priority,
  }) {
    return SeriesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      coverVideoId: coverVideoId ?? this.coverVideoId,
      name: name ?? this.name,
      description: description ?? this.description,
      priority: priority ?? this.priority,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (coverVideoId.present) {
      map['cover_video_id'] = Variable<String>(coverVideoId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeriesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('coverVideoId: $coverVideoId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }
}

class $SeriesVsVideosTable extends SeriesVsVideos
    with TableInfo<$SeriesVsVideosTable, SeriesVsVideo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeriesVsVideosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _seriesIdMeta = const VerificationMeta(
    'seriesId',
  );
  @override
  late final GeneratedColumn<int> seriesId = GeneratedColumn<int>(
    'series_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES series (id)',
    ),
  );
  static const VerificationMeta _videoIdMeta = const VerificationMeta(
    'videoId',
  );
  @override
  late final GeneratedColumn<String> videoId = GeneratedColumn<String>(
    'video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES videos (id)',
    ),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [seriesId, videoId, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'series_vs_videos';
  @override
  VerificationContext validateIntegrity(
    Insertable<SeriesVsVideo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('series_id')) {
      context.handle(
        _seriesIdMeta,
        seriesId.isAcceptableOrUnknown(data['series_id']!, _seriesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_seriesIdMeta);
    }
    if (data.containsKey('video_id')) {
      context.handle(
        _videoIdMeta,
        videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {seriesId, videoId};
  @override
  SeriesVsVideo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeriesVsVideo(
      seriesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}series_id'],
      )!,
      videoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_id'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
    );
  }

  @override
  $SeriesVsVideosTable createAlias(String alias) {
    return $SeriesVsVideosTable(attachedDatabase, alias);
  }
}

class SeriesVsVideo extends DataClass implements Insertable<SeriesVsVideo> {
  final int seriesId;
  final String videoId;
  final int priority;
  const SeriesVsVideo({
    required this.seriesId,
    required this.videoId,
    required this.priority,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['series_id'] = Variable<int>(seriesId);
    map['video_id'] = Variable<String>(videoId);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  SeriesVsVideosCompanion toCompanion(bool nullToAbsent) {
    return SeriesVsVideosCompanion(
      seriesId: Value(seriesId),
      videoId: Value(videoId),
      priority: Value(priority),
    );
  }

  factory SeriesVsVideo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeriesVsVideo(
      seriesId: serializer.fromJson<int>(json['seriesId']),
      videoId: serializer.fromJson<String>(json['videoId']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'seriesId': serializer.toJson<int>(seriesId),
      'videoId': serializer.toJson<String>(videoId),
      'priority': serializer.toJson<int>(priority),
    };
  }

  SeriesVsVideo copyWith({int? seriesId, String? videoId, int? priority}) =>
      SeriesVsVideo(
        seriesId: seriesId ?? this.seriesId,
        videoId: videoId ?? this.videoId,
        priority: priority ?? this.priority,
      );
  SeriesVsVideo copyWithCompanion(SeriesVsVideosCompanion data) {
    return SeriesVsVideo(
      seriesId: data.seriesId.present ? data.seriesId.value : this.seriesId,
      videoId: data.videoId.present ? data.videoId.value : this.videoId,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SeriesVsVideo(')
          ..write('seriesId: $seriesId, ')
          ..write('videoId: $videoId, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(seriesId, videoId, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SeriesVsVideo &&
          other.seriesId == this.seriesId &&
          other.videoId == this.videoId &&
          other.priority == this.priority);
}

class SeriesVsVideosCompanion extends UpdateCompanion<SeriesVsVideo> {
  final Value<int> seriesId;
  final Value<String> videoId;
  final Value<int> priority;
  final Value<int> rowid;
  const SeriesVsVideosCompanion({
    this.seriesId = const Value.absent(),
    this.videoId = const Value.absent(),
    this.priority = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SeriesVsVideosCompanion.insert({
    required int seriesId,
    required String videoId,
    required int priority,
    this.rowid = const Value.absent(),
  }) : seriesId = Value(seriesId),
       videoId = Value(videoId),
       priority = Value(priority);
  static Insertable<SeriesVsVideo> custom({
    Expression<int>? seriesId,
    Expression<String>? videoId,
    Expression<int>? priority,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (seriesId != null) 'series_id': seriesId,
      if (videoId != null) 'video_id': videoId,
      if (priority != null) 'priority': priority,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SeriesVsVideosCompanion copyWith({
    Value<int>? seriesId,
    Value<String>? videoId,
    Value<int>? priority,
    Value<int>? rowid,
  }) {
    return SeriesVsVideosCompanion(
      seriesId: seriesId ?? this.seriesId,
      videoId: videoId ?? this.videoId,
      priority: priority ?? this.priority,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (seriesId.present) {
      map['series_id'] = Variable<int>(seriesId.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<String>(videoId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeriesVsVideosCompanion(')
          ..write('seriesId: $seriesId, ')
          ..write('videoId: $videoId, ')
          ..write('priority: $priority, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $ChannelsTable channels = $ChannelsTable(this);
  late final $ChannelSnippetsTable channelSnippets = $ChannelSnippetsTable(
    this,
  );
  late final $ChannelThumbnailsTable channelThumbnails =
      $ChannelThumbnailsTable(this);
  late final $ChannelContentDetailsTable channelContentDetails =
      $ChannelContentDetailsTable(this);
  late final $ChannelStatisticsTable channelStatistics =
      $ChannelStatisticsTable(this);
  late final $ChannelStatusesTable channelStatuses = $ChannelStatusesTable(
    this,
  );
  late final $VideosTable videos = $VideosTable(this);
  late final $VideoSnippetsTable videoSnippets = $VideoSnippetsTable(this);
  late final $VideoThumbnailsTable videoThumbnails = $VideoThumbnailsTable(
    this,
  );
  late final $VideoContentDetailsTable videoContentDetails =
      $VideoContentDetailsTable(this);
  late final $VideoStatusesTable videoStatuses = $VideoStatusesTable(this);
  late final $VideoStatisticsTable videoStatistics = $VideoStatisticsTable(
    this,
  );
  late final $VideoProgressTable videoProgress = $VideoProgressTable(this);
  late final $PlaylistsTable playlists = $PlaylistsTable(this);
  late final $PlaylistSnippetsTable playlistSnippets = $PlaylistSnippetsTable(
    this,
  );
  late final $PlaylistThumbnailsTable playlistThumbnails =
      $PlaylistThumbnailsTable(this);
  late final $PlaylistContentDetailsTable playlistContentDetails =
      $PlaylistContentDetailsTable(this);
  late final $PlaylistVsVideosTable playlistVsVideos = $PlaylistVsVideosTable(
    this,
  );
  late final $ChannelSearchesTable channelSearches = $ChannelSearchesTable(
    this,
  );
  late final $ChannelSearchVsChannelsTable channelSearchVsChannels =
      $ChannelSearchVsChannelsTable(this);
  late final $VideoSearchesTable videoSearches = $VideoSearchesTable(this);
  late final $VideoSearchVsVideosTable videoSearchVsVideos =
      $VideoSearchVsVideosTable(this);
  late final $CollectionsTable collections = $CollectionsTable(this);
  late final $SeriesTable series = $SeriesTable(this);
  late final $SeriesVsVideosTable seriesVsVideos = $SeriesVsVideosTable(this);
  late final Index channelsIndexETag = Index(
    'ChannelsIndexETag',
    'CREATE INDEX ChannelsIndexETag ON channels (etag)',
  );
  late final Index videosIndexETag = Index(
    'VideosIndexETag',
    'CREATE INDEX VideosIndexETag ON videos (etag)',
  );
  late final Index playlistIndexETag = Index(
    'PlaylistIndexETag',
    'CREATE INDEX PlaylistIndexETag ON playlists (etag)',
  );
  late final Index channelSearchesIndexQuery = Index(
    'ChannelSearchesIndexQuery',
    'CREATE INDEX ChannelSearchesIndexQuery ON channel_searches ("query")',
  );
  late final Index videoSearchesIndexQuery = Index(
    'VideoSearchesIndexQuery',
    'CREATE INDEX VideoSearchesIndexQuery ON video_searches ("query")',
  );
  late final ChannelsDao channelsDao = ChannelsDao(this as Database);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    channels,
    channelSnippets,
    channelThumbnails,
    channelContentDetails,
    channelStatistics,
    channelStatuses,
    videos,
    videoSnippets,
    videoThumbnails,
    videoContentDetails,
    videoStatuses,
    videoStatistics,
    videoProgress,
    playlists,
    playlistSnippets,
    playlistThumbnails,
    playlistContentDetails,
    playlistVsVideos,
    channelSearches,
    channelSearchVsChannels,
    videoSearches,
    videoSearchVsVideos,
    collections,
    series,
    seriesVsVideos,
    channelsIndexETag,
    videosIndexETag,
    playlistIndexETag,
    channelSearchesIndexQuery,
    videoSearchesIndexQuery,
  ];
}

typedef $$ChannelsTableCreateCompanionBuilder =
    ChannelsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      Value<String?> etag,
      Value<String?> setag,
      Value<int> rowid,
    });
typedef $$ChannelsTableUpdateCompanionBuilder =
    ChannelsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String?> etag,
      Value<String?> setag,
      Value<int> rowid,
    });

final class $$ChannelsTableReferences
    extends BaseReferences<_$Database, $ChannelsTable, Channel> {
  $$ChannelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChannelSnippetsTable, List<ChannelSnippet>>
  _channelSnippetsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.channelSnippets,
    aliasName: $_aliasNameGenerator(db.channels.id, db.channelSnippets.id),
  );

  $$ChannelSnippetsTableProcessedTableManager get channelSnippetsRefs {
    final manager = $$ChannelSnippetsTableTableManager(
      $_db,
      $_db.channelSnippets,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _channelSnippetsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChannelThumbnailsTable, List<ChannelThumbnail>>
  _channelThumbnailsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.channelThumbnails,
    aliasName: $_aliasNameGenerator(db.channels.id, db.channelThumbnails.id),
  );

  $$ChannelThumbnailsTableProcessedTableManager get channelThumbnailsRefs {
    final manager = $$ChannelThumbnailsTableTableManager(
      $_db,
      $_db.channelThumbnails,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _channelThumbnailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ChannelContentDetailsTable,
    List<ChannelContentDetail>
  >
  _channelContentDetailsRefsTable(_$Database db) =>
      MultiTypedResultKey.fromTable(
        db.channelContentDetails,
        aliasName: $_aliasNameGenerator(
          db.channels.id,
          db.channelContentDetails.id,
        ),
      );

  $$ChannelContentDetailsTableProcessedTableManager
  get channelContentDetailsRefs {
    final manager = $$ChannelContentDetailsTableTableManager(
      $_db,
      $_db.channelContentDetails,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _channelContentDetailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChannelStatisticsTable, List<ChannelStatistic>>
  _channelStatisticsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.channelStatistics,
    aliasName: $_aliasNameGenerator(db.channels.id, db.channelStatistics.id),
  );

  $$ChannelStatisticsTableProcessedTableManager get channelStatisticsRefs {
    final manager = $$ChannelStatisticsTableTableManager(
      $_db,
      $_db.channelStatistics,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _channelStatisticsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChannelStatusesTable, List<ChannelStatuse>>
  _channelStatusesRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.channelStatuses,
    aliasName: $_aliasNameGenerator(db.channels.id, db.channelStatuses.id),
  );

  $$ChannelStatusesTableProcessedTableManager get channelStatusesRefs {
    final manager = $$ChannelStatusesTableTableManager(
      $_db,
      $_db.channelStatuses,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _channelStatusesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VideosTable, List<Video>> _videosRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.videos,
    aliasName: $_aliasNameGenerator(db.channels.id, db.videos.channelId),
  );

  $$VideosTableProcessedTableManager get videosRefs {
    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.channelId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_videosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlaylistsTable, List<Playlist>>
  _playlistsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.playlists,
    aliasName: $_aliasNameGenerator(db.channels.id, db.playlists.channelId),
  );

  $$PlaylistsTableProcessedTableManager get playlistsRefs {
    final manager = $$PlaylistsTableTableManager(
      $_db,
      $_db.playlists,
    ).filter((f) => f.channelId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_playlistsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ChannelSearchVsChannelsTable,
    List<ChannelSearchVsChannel>
  >
  _channelSearchVsChannelsRefsTable(_$Database db) =>
      MultiTypedResultKey.fromTable(
        db.channelSearchVsChannels,
        aliasName: $_aliasNameGenerator(
          db.channels.id,
          db.channelSearchVsChannels.channelId,
        ),
      );

  $$ChannelSearchVsChannelsTableProcessedTableManager
  get channelSearchVsChannelsRefs {
    final manager = $$ChannelSearchVsChannelsTableTableManager(
      $_db,
      $_db.channelSearchVsChannels,
    ).filter((f) => f.channelId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _channelSearchVsChannelsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChannelsTableFilterComposer
    extends Composer<_$Database, $ChannelsTable> {
  $$ChannelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setag => $composableBuilder(
    column: $table.setag,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> channelSnippetsRefs(
    Expression<bool> Function($$ChannelSnippetsTableFilterComposer f) f,
  ) {
    final $$ChannelSnippetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channelSnippets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelSnippetsTableFilterComposer(
            $db: $db,
            $table: $db.channelSnippets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> channelThumbnailsRefs(
    Expression<bool> Function($$ChannelThumbnailsTableFilterComposer f) f,
  ) {
    final $$ChannelThumbnailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channelThumbnails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelThumbnailsTableFilterComposer(
            $db: $db,
            $table: $db.channelThumbnails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> channelContentDetailsRefs(
    Expression<bool> Function($$ChannelContentDetailsTableFilterComposer f) f,
  ) {
    final $$ChannelContentDetailsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.channelContentDetails,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChannelContentDetailsTableFilterComposer(
                $db: $db,
                $table: $db.channelContentDetails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> channelStatisticsRefs(
    Expression<bool> Function($$ChannelStatisticsTableFilterComposer f) f,
  ) {
    final $$ChannelStatisticsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channelStatistics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelStatisticsTableFilterComposer(
            $db: $db,
            $table: $db.channelStatistics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> channelStatusesRefs(
    Expression<bool> Function($$ChannelStatusesTableFilterComposer f) f,
  ) {
    final $$ChannelStatusesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channelStatuses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelStatusesTableFilterComposer(
            $db: $db,
            $table: $db.channelStatuses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> videosRefs(
    Expression<bool> Function($$VideosTableFilterComposer f) f,
  ) {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.channelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> playlistsRefs(
    Expression<bool> Function($$PlaylistsTableFilterComposer f) f,
  ) {
    final $$PlaylistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.channelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableFilterComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> channelSearchVsChannelsRefs(
    Expression<bool> Function($$ChannelSearchVsChannelsTableFilterComposer f) f,
  ) {
    final $$ChannelSearchVsChannelsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.channelSearchVsChannels,
          getReferencedColumn: (t) => t.channelId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChannelSearchVsChannelsTableFilterComposer(
                $db: $db,
                $table: $db.channelSearchVsChannels,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ChannelsTableOrderingComposer
    extends Composer<_$Database, $ChannelsTable> {
  $$ChannelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setag => $composableBuilder(
    column: $table.setag,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChannelsTableAnnotationComposer
    extends Composer<_$Database, $ChannelsTable> {
  $$ChannelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get etag =>
      $composableBuilder(column: $table.etag, builder: (column) => column);

  GeneratedColumn<String> get setag =>
      $composableBuilder(column: $table.setag, builder: (column) => column);

  Expression<T> channelSnippetsRefs<T extends Object>(
    Expression<T> Function($$ChannelSnippetsTableAnnotationComposer a) f,
  ) {
    final $$ChannelSnippetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channelSnippets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelSnippetsTableAnnotationComposer(
            $db: $db,
            $table: $db.channelSnippets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> channelThumbnailsRefs<T extends Object>(
    Expression<T> Function($$ChannelThumbnailsTableAnnotationComposer a) f,
  ) {
    final $$ChannelThumbnailsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.channelThumbnails,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChannelThumbnailsTableAnnotationComposer(
                $db: $db,
                $table: $db.channelThumbnails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> channelContentDetailsRefs<T extends Object>(
    Expression<T> Function($$ChannelContentDetailsTableAnnotationComposer a) f,
  ) {
    final $$ChannelContentDetailsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.channelContentDetails,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChannelContentDetailsTableAnnotationComposer(
                $db: $db,
                $table: $db.channelContentDetails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> channelStatisticsRefs<T extends Object>(
    Expression<T> Function($$ChannelStatisticsTableAnnotationComposer a) f,
  ) {
    final $$ChannelStatisticsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.channelStatistics,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChannelStatisticsTableAnnotationComposer(
                $db: $db,
                $table: $db.channelStatistics,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> channelStatusesRefs<T extends Object>(
    Expression<T> Function($$ChannelStatusesTableAnnotationComposer a) f,
  ) {
    final $$ChannelStatusesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channelStatuses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelStatusesTableAnnotationComposer(
            $db: $db,
            $table: $db.channelStatuses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> videosRefs<T extends Object>(
    Expression<T> Function($$VideosTableAnnotationComposer a) f,
  ) {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.channelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> playlistsRefs<T extends Object>(
    Expression<T> Function($$PlaylistsTableAnnotationComposer a) f,
  ) {
    final $$PlaylistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.channelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableAnnotationComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> channelSearchVsChannelsRefs<T extends Object>(
    Expression<T> Function($$ChannelSearchVsChannelsTableAnnotationComposer a)
    f,
  ) {
    final $$ChannelSearchVsChannelsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.channelSearchVsChannels,
          getReferencedColumn: (t) => t.channelId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChannelSearchVsChannelsTableAnnotationComposer(
                $db: $db,
                $table: $db.channelSearchVsChannels,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ChannelsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ChannelsTable,
          Channel,
          $$ChannelsTableFilterComposer,
          $$ChannelsTableOrderingComposer,
          $$ChannelsTableAnnotationComposer,
          $$ChannelsTableCreateCompanionBuilder,
          $$ChannelsTableUpdateCompanionBuilder,
          (Channel, $$ChannelsTableReferences),
          Channel,
          PrefetchHooks Function({
            bool channelSnippetsRefs,
            bool channelThumbnailsRefs,
            bool channelContentDetailsRefs,
            bool channelStatisticsRefs,
            bool channelStatusesRefs,
            bool videosRefs,
            bool playlistsRefs,
            bool channelSearchVsChannelsRefs,
          })
        > {
  $$ChannelsTableTableManager(_$Database db, $ChannelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChannelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChannelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChannelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String?> etag = const Value.absent(),
                Value<String?> setag = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChannelsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                etag: etag,
                setag: setag,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                Value<String?> etag = const Value.absent(),
                Value<String?> setag = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChannelsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                etag: etag,
                setag: setag,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChannelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                channelSnippetsRefs = false,
                channelThumbnailsRefs = false,
                channelContentDetailsRefs = false,
                channelStatisticsRefs = false,
                channelStatusesRefs = false,
                videosRefs = false,
                playlistsRefs = false,
                channelSearchVsChannelsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (channelSnippetsRefs) db.channelSnippets,
                    if (channelThumbnailsRefs) db.channelThumbnails,
                    if (channelContentDetailsRefs) db.channelContentDetails,
                    if (channelStatisticsRefs) db.channelStatistics,
                    if (channelStatusesRefs) db.channelStatuses,
                    if (videosRefs) db.videos,
                    if (playlistsRefs) db.playlists,
                    if (channelSearchVsChannelsRefs) db.channelSearchVsChannels,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (channelSnippetsRefs)
                        await $_getPrefetchedData<
                          Channel,
                          $ChannelsTable,
                          ChannelSnippet
                        >(
                          currentTable: table,
                          referencedTable: $$ChannelsTableReferences
                              ._channelSnippetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChannelsTableReferences(
                                db,
                                table,
                                p0,
                              ).channelSnippetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (channelThumbnailsRefs)
                        await $_getPrefetchedData<
                          Channel,
                          $ChannelsTable,
                          ChannelThumbnail
                        >(
                          currentTable: table,
                          referencedTable: $$ChannelsTableReferences
                              ._channelThumbnailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChannelsTableReferences(
                                db,
                                table,
                                p0,
                              ).channelThumbnailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (channelContentDetailsRefs)
                        await $_getPrefetchedData<
                          Channel,
                          $ChannelsTable,
                          ChannelContentDetail
                        >(
                          currentTable: table,
                          referencedTable: $$ChannelsTableReferences
                              ._channelContentDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChannelsTableReferences(
                                db,
                                table,
                                p0,
                              ).channelContentDetailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (channelStatisticsRefs)
                        await $_getPrefetchedData<
                          Channel,
                          $ChannelsTable,
                          ChannelStatistic
                        >(
                          currentTable: table,
                          referencedTable: $$ChannelsTableReferences
                              ._channelStatisticsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChannelsTableReferences(
                                db,
                                table,
                                p0,
                              ).channelStatisticsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (channelStatusesRefs)
                        await $_getPrefetchedData<
                          Channel,
                          $ChannelsTable,
                          ChannelStatuse
                        >(
                          currentTable: table,
                          referencedTable: $$ChannelsTableReferences
                              ._channelStatusesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChannelsTableReferences(
                                db,
                                table,
                                p0,
                              ).channelStatusesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (videosRefs)
                        await $_getPrefetchedData<
                          Channel,
                          $ChannelsTable,
                          Video
                        >(
                          currentTable: table,
                          referencedTable: $$ChannelsTableReferences
                              ._videosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChannelsTableReferences(
                                db,
                                table,
                                p0,
                              ).videosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.channelId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (playlistsRefs)
                        await $_getPrefetchedData<
                          Channel,
                          $ChannelsTable,
                          Playlist
                        >(
                          currentTable: table,
                          referencedTable: $$ChannelsTableReferences
                              ._playlistsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChannelsTableReferences(
                                db,
                                table,
                                p0,
                              ).playlistsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.channelId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (channelSearchVsChannelsRefs)
                        await $_getPrefetchedData<
                          Channel,
                          $ChannelsTable,
                          ChannelSearchVsChannel
                        >(
                          currentTable: table,
                          referencedTable: $$ChannelsTableReferences
                              ._channelSearchVsChannelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChannelsTableReferences(
                                db,
                                table,
                                p0,
                              ).channelSearchVsChannelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.channelId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ChannelsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ChannelsTable,
      Channel,
      $$ChannelsTableFilterComposer,
      $$ChannelsTableOrderingComposer,
      $$ChannelsTableAnnotationComposer,
      $$ChannelsTableCreateCompanionBuilder,
      $$ChannelsTableUpdateCompanionBuilder,
      (Channel, $$ChannelsTableReferences),
      Channel,
      PrefetchHooks Function({
        bool channelSnippetsRefs,
        bool channelThumbnailsRefs,
        bool channelContentDetailsRefs,
        bool channelStatisticsRefs,
        bool channelStatusesRefs,
        bool videosRefs,
        bool playlistsRefs,
        bool channelSearchVsChannelsRefs,
      })
    >;
typedef $$ChannelSnippetsTableCreateCompanionBuilder =
    ChannelSnippetsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String title,
      required String description,
      Value<int> rowid,
    });
typedef $$ChannelSnippetsTableUpdateCompanionBuilder =
    ChannelSnippetsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<int> rowid,
    });

final class $$ChannelSnippetsTableReferences
    extends BaseReferences<_$Database, $ChannelSnippetsTable, ChannelSnippet> {
  $$ChannelSnippetsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChannelsTable _idTable(_$Database db) => db.channels.createAlias(
    $_aliasNameGenerator(db.channelSnippets.id, db.channels.id),
  );

  $$ChannelsTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$ChannelsTableTableManager(
      $_db,
      $_db.channels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChannelSnippetsTableFilterComposer
    extends Composer<_$Database, $ChannelSnippetsTable> {
  $$ChannelSnippetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  $$ChannelsTableFilterComposer get id {
    final $$ChannelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableFilterComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelSnippetsTableOrderingComposer
    extends Composer<_$Database, $ChannelSnippetsTable> {
  $$ChannelSnippetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChannelsTableOrderingComposer get id {
    final $$ChannelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableOrderingComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelSnippetsTableAnnotationComposer
    extends Composer<_$Database, $ChannelSnippetsTable> {
  $$ChannelSnippetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$ChannelsTableAnnotationComposer get id {
    final $$ChannelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableAnnotationComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelSnippetsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ChannelSnippetsTable,
          ChannelSnippet,
          $$ChannelSnippetsTableFilterComposer,
          $$ChannelSnippetsTableOrderingComposer,
          $$ChannelSnippetsTableAnnotationComposer,
          $$ChannelSnippetsTableCreateCompanionBuilder,
          $$ChannelSnippetsTableUpdateCompanionBuilder,
          (ChannelSnippet, $$ChannelSnippetsTableReferences),
          ChannelSnippet,
          PrefetchHooks Function({bool id})
        > {
  $$ChannelSnippetsTableTableManager(_$Database db, $ChannelSnippetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChannelSnippetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChannelSnippetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChannelSnippetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChannelSnippetsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                title: title,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String title,
                required String description,
                Value<int> rowid = const Value.absent(),
              }) => ChannelSnippetsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                title: title,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChannelSnippetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$ChannelSnippetsTableReferences._idTable(
                                      db,
                                    ),
                                referencedColumn:
                                    $$ChannelSnippetsTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChannelSnippetsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ChannelSnippetsTable,
      ChannelSnippet,
      $$ChannelSnippetsTableFilterComposer,
      $$ChannelSnippetsTableOrderingComposer,
      $$ChannelSnippetsTableAnnotationComposer,
      $$ChannelSnippetsTableCreateCompanionBuilder,
      $$ChannelSnippetsTableUpdateCompanionBuilder,
      (ChannelSnippet, $$ChannelSnippetsTableReferences),
      ChannelSnippet,
      PrefetchHooks Function({bool id})
    >;
typedef $$ChannelThumbnailsTableCreateCompanionBuilder =
    ChannelThumbnailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String defaultUrl,
      required String mediumUrl,
      required String highUrl,
      Value<int> rowid,
    });
typedef $$ChannelThumbnailsTableUpdateCompanionBuilder =
    ChannelThumbnailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> defaultUrl,
      Value<String> mediumUrl,
      Value<String> highUrl,
      Value<int> rowid,
    });

final class $$ChannelThumbnailsTableReferences
    extends
        BaseReferences<_$Database, $ChannelThumbnailsTable, ChannelThumbnail> {
  $$ChannelThumbnailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChannelsTable _idTable(_$Database db) => db.channels.createAlias(
    $_aliasNameGenerator(db.channelThumbnails.id, db.channels.id),
  );

  $$ChannelsTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$ChannelsTableTableManager(
      $_db,
      $_db.channels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChannelThumbnailsTableFilterComposer
    extends Composer<_$Database, $ChannelThumbnailsTable> {
  $$ChannelThumbnailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultUrl => $composableBuilder(
    column: $table.defaultUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediumUrl => $composableBuilder(
    column: $table.mediumUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get highUrl => $composableBuilder(
    column: $table.highUrl,
    builder: (column) => ColumnFilters(column),
  );

  $$ChannelsTableFilterComposer get id {
    final $$ChannelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableFilterComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelThumbnailsTableOrderingComposer
    extends Composer<_$Database, $ChannelThumbnailsTable> {
  $$ChannelThumbnailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultUrl => $composableBuilder(
    column: $table.defaultUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediumUrl => $composableBuilder(
    column: $table.mediumUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get highUrl => $composableBuilder(
    column: $table.highUrl,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChannelsTableOrderingComposer get id {
    final $$ChannelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableOrderingComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelThumbnailsTableAnnotationComposer
    extends Composer<_$Database, $ChannelThumbnailsTable> {
  $$ChannelThumbnailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get defaultUrl => $composableBuilder(
    column: $table.defaultUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mediumUrl =>
      $composableBuilder(column: $table.mediumUrl, builder: (column) => column);

  GeneratedColumn<String> get highUrl =>
      $composableBuilder(column: $table.highUrl, builder: (column) => column);

  $$ChannelsTableAnnotationComposer get id {
    final $$ChannelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableAnnotationComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelThumbnailsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ChannelThumbnailsTable,
          ChannelThumbnail,
          $$ChannelThumbnailsTableFilterComposer,
          $$ChannelThumbnailsTableOrderingComposer,
          $$ChannelThumbnailsTableAnnotationComposer,
          $$ChannelThumbnailsTableCreateCompanionBuilder,
          $$ChannelThumbnailsTableUpdateCompanionBuilder,
          (ChannelThumbnail, $$ChannelThumbnailsTableReferences),
          ChannelThumbnail,
          PrefetchHooks Function({bool id})
        > {
  $$ChannelThumbnailsTableTableManager(
    _$Database db,
    $ChannelThumbnailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChannelThumbnailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChannelThumbnailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChannelThumbnailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> defaultUrl = const Value.absent(),
                Value<String> mediumUrl = const Value.absent(),
                Value<String> highUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChannelThumbnailsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                defaultUrl: defaultUrl,
                mediumUrl: mediumUrl,
                highUrl: highUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String defaultUrl,
                required String mediumUrl,
                required String highUrl,
                Value<int> rowid = const Value.absent(),
              }) => ChannelThumbnailsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                defaultUrl: defaultUrl,
                mediumUrl: mediumUrl,
                highUrl: highUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChannelThumbnailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$ChannelThumbnailsTableReferences._idTable(
                                      db,
                                    ),
                                referencedColumn:
                                    $$ChannelThumbnailsTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChannelThumbnailsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ChannelThumbnailsTable,
      ChannelThumbnail,
      $$ChannelThumbnailsTableFilterComposer,
      $$ChannelThumbnailsTableOrderingComposer,
      $$ChannelThumbnailsTableAnnotationComposer,
      $$ChannelThumbnailsTableCreateCompanionBuilder,
      $$ChannelThumbnailsTableUpdateCompanionBuilder,
      (ChannelThumbnail, $$ChannelThumbnailsTableReferences),
      ChannelThumbnail,
      PrefetchHooks Function({bool id})
    >;
typedef $$ChannelContentDetailsTableCreateCompanionBuilder =
    ChannelContentDetailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      Value<String?> likesPlaylist,
      Value<String?> uploadPlaylist,
      Value<int> rowid,
    });
typedef $$ChannelContentDetailsTableUpdateCompanionBuilder =
    ChannelContentDetailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String?> likesPlaylist,
      Value<String?> uploadPlaylist,
      Value<int> rowid,
    });

final class $$ChannelContentDetailsTableReferences
    extends
        BaseReferences<
          _$Database,
          $ChannelContentDetailsTable,
          ChannelContentDetail
        > {
  $$ChannelContentDetailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChannelsTable _idTable(_$Database db) => db.channels.createAlias(
    $_aliasNameGenerator(db.channelContentDetails.id, db.channels.id),
  );

  $$ChannelsTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$ChannelsTableTableManager(
      $_db,
      $_db.channels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChannelContentDetailsTableFilterComposer
    extends Composer<_$Database, $ChannelContentDetailsTable> {
  $$ChannelContentDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get likesPlaylist => $composableBuilder(
    column: $table.likesPlaylist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uploadPlaylist => $composableBuilder(
    column: $table.uploadPlaylist,
    builder: (column) => ColumnFilters(column),
  );

  $$ChannelsTableFilterComposer get id {
    final $$ChannelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableFilterComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelContentDetailsTableOrderingComposer
    extends Composer<_$Database, $ChannelContentDetailsTable> {
  $$ChannelContentDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get likesPlaylist => $composableBuilder(
    column: $table.likesPlaylist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uploadPlaylist => $composableBuilder(
    column: $table.uploadPlaylist,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChannelsTableOrderingComposer get id {
    final $$ChannelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableOrderingComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelContentDetailsTableAnnotationComposer
    extends Composer<_$Database, $ChannelContentDetailsTable> {
  $$ChannelContentDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get likesPlaylist => $composableBuilder(
    column: $table.likesPlaylist,
    builder: (column) => column,
  );

  GeneratedColumn<String> get uploadPlaylist => $composableBuilder(
    column: $table.uploadPlaylist,
    builder: (column) => column,
  );

  $$ChannelsTableAnnotationComposer get id {
    final $$ChannelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableAnnotationComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelContentDetailsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ChannelContentDetailsTable,
          ChannelContentDetail,
          $$ChannelContentDetailsTableFilterComposer,
          $$ChannelContentDetailsTableOrderingComposer,
          $$ChannelContentDetailsTableAnnotationComposer,
          $$ChannelContentDetailsTableCreateCompanionBuilder,
          $$ChannelContentDetailsTableUpdateCompanionBuilder,
          (ChannelContentDetail, $$ChannelContentDetailsTableReferences),
          ChannelContentDetail,
          PrefetchHooks Function({bool id})
        > {
  $$ChannelContentDetailsTableTableManager(
    _$Database db,
    $ChannelContentDetailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChannelContentDetailsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ChannelContentDetailsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ChannelContentDetailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String?> likesPlaylist = const Value.absent(),
                Value<String?> uploadPlaylist = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChannelContentDetailsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                likesPlaylist: likesPlaylist,
                uploadPlaylist: uploadPlaylist,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                Value<String?> likesPlaylist = const Value.absent(),
                Value<String?> uploadPlaylist = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChannelContentDetailsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                likesPlaylist: likesPlaylist,
                uploadPlaylist: uploadPlaylist,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChannelContentDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$ChannelContentDetailsTableReferences
                                        ._idTable(db),
                                referencedColumn:
                                    $$ChannelContentDetailsTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChannelContentDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ChannelContentDetailsTable,
      ChannelContentDetail,
      $$ChannelContentDetailsTableFilterComposer,
      $$ChannelContentDetailsTableOrderingComposer,
      $$ChannelContentDetailsTableAnnotationComposer,
      $$ChannelContentDetailsTableCreateCompanionBuilder,
      $$ChannelContentDetailsTableUpdateCompanionBuilder,
      (ChannelContentDetail, $$ChannelContentDetailsTableReferences),
      ChannelContentDetail,
      PrefetchHooks Function({bool id})
    >;
typedef $$ChannelStatisticsTableCreateCompanionBuilder =
    ChannelStatisticsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required int viewCount,
      required int subscriberCount,
      required bool hiddenSubscriberCount,
      required int videoCount,
      Value<int> rowid,
    });
typedef $$ChannelStatisticsTableUpdateCompanionBuilder =
    ChannelStatisticsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<int> viewCount,
      Value<int> subscriberCount,
      Value<bool> hiddenSubscriberCount,
      Value<int> videoCount,
      Value<int> rowid,
    });

final class $$ChannelStatisticsTableReferences
    extends
        BaseReferences<_$Database, $ChannelStatisticsTable, ChannelStatistic> {
  $$ChannelStatisticsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChannelsTable _idTable(_$Database db) => db.channels.createAlias(
    $_aliasNameGenerator(db.channelStatistics.id, db.channels.id),
  );

  $$ChannelsTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$ChannelsTableTableManager(
      $_db,
      $_db.channels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChannelStatisticsTableFilterComposer
    extends Composer<_$Database, $ChannelStatisticsTable> {
  $$ChannelStatisticsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get viewCount => $composableBuilder(
    column: $table.viewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subscriberCount => $composableBuilder(
    column: $table.subscriberCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hiddenSubscriberCount => $composableBuilder(
    column: $table.hiddenSubscriberCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get videoCount => $composableBuilder(
    column: $table.videoCount,
    builder: (column) => ColumnFilters(column),
  );

  $$ChannelsTableFilterComposer get id {
    final $$ChannelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableFilterComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelStatisticsTableOrderingComposer
    extends Composer<_$Database, $ChannelStatisticsTable> {
  $$ChannelStatisticsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get viewCount => $composableBuilder(
    column: $table.viewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subscriberCount => $composableBuilder(
    column: $table.subscriberCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hiddenSubscriberCount => $composableBuilder(
    column: $table.hiddenSubscriberCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get videoCount => $composableBuilder(
    column: $table.videoCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChannelsTableOrderingComposer get id {
    final $$ChannelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableOrderingComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelStatisticsTableAnnotationComposer
    extends Composer<_$Database, $ChannelStatisticsTable> {
  $$ChannelStatisticsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get viewCount =>
      $composableBuilder(column: $table.viewCount, builder: (column) => column);

  GeneratedColumn<int> get subscriberCount => $composableBuilder(
    column: $table.subscriberCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hiddenSubscriberCount => $composableBuilder(
    column: $table.hiddenSubscriberCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get videoCount => $composableBuilder(
    column: $table.videoCount,
    builder: (column) => column,
  );

  $$ChannelsTableAnnotationComposer get id {
    final $$ChannelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableAnnotationComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelStatisticsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ChannelStatisticsTable,
          ChannelStatistic,
          $$ChannelStatisticsTableFilterComposer,
          $$ChannelStatisticsTableOrderingComposer,
          $$ChannelStatisticsTableAnnotationComposer,
          $$ChannelStatisticsTableCreateCompanionBuilder,
          $$ChannelStatisticsTableUpdateCompanionBuilder,
          (ChannelStatistic, $$ChannelStatisticsTableReferences),
          ChannelStatistic,
          PrefetchHooks Function({bool id})
        > {
  $$ChannelStatisticsTableTableManager(
    _$Database db,
    $ChannelStatisticsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChannelStatisticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChannelStatisticsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChannelStatisticsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<int> viewCount = const Value.absent(),
                Value<int> subscriberCount = const Value.absent(),
                Value<bool> hiddenSubscriberCount = const Value.absent(),
                Value<int> videoCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChannelStatisticsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                viewCount: viewCount,
                subscriberCount: subscriberCount,
                hiddenSubscriberCount: hiddenSubscriberCount,
                videoCount: videoCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required int viewCount,
                required int subscriberCount,
                required bool hiddenSubscriberCount,
                required int videoCount,
                Value<int> rowid = const Value.absent(),
              }) => ChannelStatisticsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                viewCount: viewCount,
                subscriberCount: subscriberCount,
                hiddenSubscriberCount: hiddenSubscriberCount,
                videoCount: videoCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChannelStatisticsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$ChannelStatisticsTableReferences._idTable(
                                      db,
                                    ),
                                referencedColumn:
                                    $$ChannelStatisticsTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChannelStatisticsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ChannelStatisticsTable,
      ChannelStatistic,
      $$ChannelStatisticsTableFilterComposer,
      $$ChannelStatisticsTableOrderingComposer,
      $$ChannelStatisticsTableAnnotationComposer,
      $$ChannelStatisticsTableCreateCompanionBuilder,
      $$ChannelStatisticsTableUpdateCompanionBuilder,
      (ChannelStatistic, $$ChannelStatisticsTableReferences),
      ChannelStatistic,
      PrefetchHooks Function({bool id})
    >;
typedef $$ChannelStatusesTableCreateCompanionBuilder =
    ChannelStatusesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String privacyStatus,
      required bool isLinked,
      required String longUploadsStatus,
      Value<bool?> madeForKids,
      Value<int> rowid,
    });
typedef $$ChannelStatusesTableUpdateCompanionBuilder =
    ChannelStatusesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> privacyStatus,
      Value<bool> isLinked,
      Value<String> longUploadsStatus,
      Value<bool?> madeForKids,
      Value<int> rowid,
    });

final class $$ChannelStatusesTableReferences
    extends BaseReferences<_$Database, $ChannelStatusesTable, ChannelStatuse> {
  $$ChannelStatusesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChannelsTable _idTable(_$Database db) => db.channels.createAlias(
    $_aliasNameGenerator(db.channelStatuses.id, db.channels.id),
  );

  $$ChannelsTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$ChannelsTableTableManager(
      $_db,
      $_db.channels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChannelStatusesTableFilterComposer
    extends Composer<_$Database, $ChannelStatusesTable> {
  $$ChannelStatusesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get privacyStatus => $composableBuilder(
    column: $table.privacyStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLinked => $composableBuilder(
    column: $table.isLinked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get longUploadsStatus => $composableBuilder(
    column: $table.longUploadsStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get madeForKids => $composableBuilder(
    column: $table.madeForKids,
    builder: (column) => ColumnFilters(column),
  );

  $$ChannelsTableFilterComposer get id {
    final $$ChannelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableFilterComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelStatusesTableOrderingComposer
    extends Composer<_$Database, $ChannelStatusesTable> {
  $$ChannelStatusesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get privacyStatus => $composableBuilder(
    column: $table.privacyStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLinked => $composableBuilder(
    column: $table.isLinked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get longUploadsStatus => $composableBuilder(
    column: $table.longUploadsStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get madeForKids => $composableBuilder(
    column: $table.madeForKids,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChannelsTableOrderingComposer get id {
    final $$ChannelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableOrderingComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelStatusesTableAnnotationComposer
    extends Composer<_$Database, $ChannelStatusesTable> {
  $$ChannelStatusesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get privacyStatus => $composableBuilder(
    column: $table.privacyStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isLinked =>
      $composableBuilder(column: $table.isLinked, builder: (column) => column);

  GeneratedColumn<String> get longUploadsStatus => $composableBuilder(
    column: $table.longUploadsStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get madeForKids => $composableBuilder(
    column: $table.madeForKids,
    builder: (column) => column,
  );

  $$ChannelsTableAnnotationComposer get id {
    final $$ChannelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableAnnotationComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelStatusesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ChannelStatusesTable,
          ChannelStatuse,
          $$ChannelStatusesTableFilterComposer,
          $$ChannelStatusesTableOrderingComposer,
          $$ChannelStatusesTableAnnotationComposer,
          $$ChannelStatusesTableCreateCompanionBuilder,
          $$ChannelStatusesTableUpdateCompanionBuilder,
          (ChannelStatuse, $$ChannelStatusesTableReferences),
          ChannelStatuse,
          PrefetchHooks Function({bool id})
        > {
  $$ChannelStatusesTableTableManager(_$Database db, $ChannelStatusesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChannelStatusesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChannelStatusesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChannelStatusesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> privacyStatus = const Value.absent(),
                Value<bool> isLinked = const Value.absent(),
                Value<String> longUploadsStatus = const Value.absent(),
                Value<bool?> madeForKids = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChannelStatusesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                privacyStatus: privacyStatus,
                isLinked: isLinked,
                longUploadsStatus: longUploadsStatus,
                madeForKids: madeForKids,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String privacyStatus,
                required bool isLinked,
                required String longUploadsStatus,
                Value<bool?> madeForKids = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChannelStatusesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                privacyStatus: privacyStatus,
                isLinked: isLinked,
                longUploadsStatus: longUploadsStatus,
                madeForKids: madeForKids,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChannelStatusesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$ChannelStatusesTableReferences._idTable(
                                      db,
                                    ),
                                referencedColumn:
                                    $$ChannelStatusesTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChannelStatusesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ChannelStatusesTable,
      ChannelStatuse,
      $$ChannelStatusesTableFilterComposer,
      $$ChannelStatusesTableOrderingComposer,
      $$ChannelStatusesTableAnnotationComposer,
      $$ChannelStatusesTableCreateCompanionBuilder,
      $$ChannelStatusesTableUpdateCompanionBuilder,
      (ChannelStatuse, $$ChannelStatusesTableReferences),
      ChannelStatuse,
      PrefetchHooks Function({bool id})
    >;
typedef $$VideosTableCreateCompanionBuilder =
    VideosCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      Value<String?> etag,
      Value<String?> setag,
      required String channelId,
      Value<int> rowid,
    });
typedef $$VideosTableUpdateCompanionBuilder =
    VideosCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String?> etag,
      Value<String?> setag,
      Value<String> channelId,
      Value<int> rowid,
    });

final class $$VideosTableReferences
    extends BaseReferences<_$Database, $VideosTable, Video> {
  $$VideosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChannelsTable _channelIdTable(_$Database db) => db.channels
      .createAlias($_aliasNameGenerator(db.videos.channelId, db.channels.id));

  $$ChannelsTableProcessedTableManager get channelId {
    final $_column = $_itemColumn<String>('channel_id')!;

    final manager = $$ChannelsTableTableManager(
      $_db,
      $_db.channels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_channelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$VideoSnippetsTable, List<VideoSnippet>>
  _videoSnippetsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.videoSnippets,
    aliasName: $_aliasNameGenerator(db.videos.id, db.videoSnippets.id),
  );

  $$VideoSnippetsTableProcessedTableManager get videoSnippetsRefs {
    final manager = $$VideoSnippetsTableTableManager(
      $_db,
      $_db.videoSnippets,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_videoSnippetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VideoThumbnailsTable, List<VideoThumbnail>>
  _videoThumbnailsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.videoThumbnails,
    aliasName: $_aliasNameGenerator(db.videos.id, db.videoThumbnails.id),
  );

  $$VideoThumbnailsTableProcessedTableManager get videoThumbnailsRefs {
    final manager = $$VideoThumbnailsTableTableManager(
      $_db,
      $_db.videoThumbnails,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _videoThumbnailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $VideoContentDetailsTable,
    List<VideoContentDetail>
  >
  _videoContentDetailsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.videoContentDetails,
    aliasName: $_aliasNameGenerator(db.videos.id, db.videoContentDetails.id),
  );

  $$VideoContentDetailsTableProcessedTableManager get videoContentDetailsRefs {
    final manager = $$VideoContentDetailsTableTableManager(
      $_db,
      $_db.videoContentDetails,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _videoContentDetailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VideoStatusesTable, List<VideoStatuse>>
  _videoStatusesRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.videoStatuses,
    aliasName: $_aliasNameGenerator(db.videos.id, db.videoStatuses.id),
  );

  $$VideoStatusesTableProcessedTableManager get videoStatusesRefs {
    final manager = $$VideoStatusesTableTableManager(
      $_db,
      $_db.videoStatuses,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_videoStatusesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VideoStatisticsTable, List<VideoStatistic>>
  _videoStatisticsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.videoStatistics,
    aliasName: $_aliasNameGenerator(db.videos.id, db.videoStatistics.id),
  );

  $$VideoStatisticsTableProcessedTableManager get videoStatisticsRefs {
    final manager = $$VideoStatisticsTableTableManager(
      $_db,
      $_db.videoStatistics,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _videoStatisticsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VideoProgressTable, List<VideoProgressData>>
  _videoProgressRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.videoProgress,
    aliasName: $_aliasNameGenerator(db.videos.id, db.videoProgress.id),
  );

  $$VideoProgressTableProcessedTableManager get videoProgressRefs {
    final manager = $$VideoProgressTableTableManager(
      $_db,
      $_db.videoProgress,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_videoProgressRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlaylistVsVideosTable, List<PlaylistVsVideo>>
  _playlistVsVideosRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.playlistVsVideos,
    aliasName: $_aliasNameGenerator(db.videos.id, db.playlistVsVideos.videoId),
  );

  $$PlaylistVsVideosTableProcessedTableManager get playlistVsVideosRefs {
    final manager = $$PlaylistVsVideosTableTableManager(
      $_db,
      $_db.playlistVsVideos,
    ).filter((f) => f.videoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playlistVsVideosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $VideoSearchVsVideosTable,
    List<VideoSearchVsVideo>
  >
  _videoSearchVsVideosRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.videoSearchVsVideos,
    aliasName: $_aliasNameGenerator(
      db.videos.id,
      db.videoSearchVsVideos.videoId,
    ),
  );

  $$VideoSearchVsVideosTableProcessedTableManager get videoSearchVsVideosRefs {
    final manager = $$VideoSearchVsVideosTableTableManager(
      $_db,
      $_db.videoSearchVsVideos,
    ).filter((f) => f.videoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _videoSearchVsVideosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SeriesTable, List<Sery>> _seriesRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.series,
    aliasName: $_aliasNameGenerator(db.videos.id, db.series.coverVideoId),
  );

  $$SeriesTableProcessedTableManager get seriesRefs {
    final manager = $$SeriesTableTableManager(
      $_db,
      $_db.series,
    ).filter((f) => f.coverVideoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_seriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SeriesVsVideosTable, List<SeriesVsVideo>>
  _seriesVsVideosRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.seriesVsVideos,
    aliasName: $_aliasNameGenerator(db.videos.id, db.seriesVsVideos.videoId),
  );

  $$SeriesVsVideosTableProcessedTableManager get seriesVsVideosRefs {
    final manager = $$SeriesVsVideosTableTableManager(
      $_db,
      $_db.seriesVsVideos,
    ).filter((f) => f.videoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_seriesVsVideosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VideosTableFilterComposer extends Composer<_$Database, $VideosTable> {
  $$VideosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setag => $composableBuilder(
    column: $table.setag,
    builder: (column) => ColumnFilters(column),
  );

  $$ChannelsTableFilterComposer get channelId {
    final $$ChannelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableFilterComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> videoSnippetsRefs(
    Expression<bool> Function($$VideoSnippetsTableFilterComposer f) f,
  ) {
    final $$VideoSnippetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoSnippets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoSnippetsTableFilterComposer(
            $db: $db,
            $table: $db.videoSnippets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> videoThumbnailsRefs(
    Expression<bool> Function($$VideoThumbnailsTableFilterComposer f) f,
  ) {
    final $$VideoThumbnailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoThumbnails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoThumbnailsTableFilterComposer(
            $db: $db,
            $table: $db.videoThumbnails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> videoContentDetailsRefs(
    Expression<bool> Function($$VideoContentDetailsTableFilterComposer f) f,
  ) {
    final $$VideoContentDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoContentDetails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoContentDetailsTableFilterComposer(
            $db: $db,
            $table: $db.videoContentDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> videoStatusesRefs(
    Expression<bool> Function($$VideoStatusesTableFilterComposer f) f,
  ) {
    final $$VideoStatusesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoStatuses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoStatusesTableFilterComposer(
            $db: $db,
            $table: $db.videoStatuses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> videoStatisticsRefs(
    Expression<bool> Function($$VideoStatisticsTableFilterComposer f) f,
  ) {
    final $$VideoStatisticsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoStatistics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoStatisticsTableFilterComposer(
            $db: $db,
            $table: $db.videoStatistics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> videoProgressRefs(
    Expression<bool> Function($$VideoProgressTableFilterComposer f) f,
  ) {
    final $$VideoProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoProgress,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoProgressTableFilterComposer(
            $db: $db,
            $table: $db.videoProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> playlistVsVideosRefs(
    Expression<bool> Function($$PlaylistVsVideosTableFilterComposer f) f,
  ) {
    final $$PlaylistVsVideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlistVsVideos,
      getReferencedColumn: (t) => t.videoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistVsVideosTableFilterComposer(
            $db: $db,
            $table: $db.playlistVsVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> videoSearchVsVideosRefs(
    Expression<bool> Function($$VideoSearchVsVideosTableFilterComposer f) f,
  ) {
    final $$VideoSearchVsVideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoSearchVsVideos,
      getReferencedColumn: (t) => t.videoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoSearchVsVideosTableFilterComposer(
            $db: $db,
            $table: $db.videoSearchVsVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> seriesRefs(
    Expression<bool> Function($$SeriesTableFilterComposer f) f,
  ) {
    final $$SeriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.coverVideoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableFilterComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> seriesVsVideosRefs(
    Expression<bool> Function($$SeriesVsVideosTableFilterComposer f) f,
  ) {
    final $$SeriesVsVideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seriesVsVideos,
      getReferencedColumn: (t) => t.videoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesVsVideosTableFilterComposer(
            $db: $db,
            $table: $db.seriesVsVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VideosTableOrderingComposer extends Composer<_$Database, $VideosTable> {
  $$VideosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setag => $composableBuilder(
    column: $table.setag,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChannelsTableOrderingComposer get channelId {
    final $$ChannelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableOrderingComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideosTableAnnotationComposer
    extends Composer<_$Database, $VideosTable> {
  $$VideosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get etag =>
      $composableBuilder(column: $table.etag, builder: (column) => column);

  GeneratedColumn<String> get setag =>
      $composableBuilder(column: $table.setag, builder: (column) => column);

  $$ChannelsTableAnnotationComposer get channelId {
    final $$ChannelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableAnnotationComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> videoSnippetsRefs<T extends Object>(
    Expression<T> Function($$VideoSnippetsTableAnnotationComposer a) f,
  ) {
    final $$VideoSnippetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoSnippets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoSnippetsTableAnnotationComposer(
            $db: $db,
            $table: $db.videoSnippets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> videoThumbnailsRefs<T extends Object>(
    Expression<T> Function($$VideoThumbnailsTableAnnotationComposer a) f,
  ) {
    final $$VideoThumbnailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoThumbnails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoThumbnailsTableAnnotationComposer(
            $db: $db,
            $table: $db.videoThumbnails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> videoContentDetailsRefs<T extends Object>(
    Expression<T> Function($$VideoContentDetailsTableAnnotationComposer a) f,
  ) {
    final $$VideoContentDetailsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.videoContentDetails,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VideoContentDetailsTableAnnotationComposer(
                $db: $db,
                $table: $db.videoContentDetails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> videoStatusesRefs<T extends Object>(
    Expression<T> Function($$VideoStatusesTableAnnotationComposer a) f,
  ) {
    final $$VideoStatusesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoStatuses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoStatusesTableAnnotationComposer(
            $db: $db,
            $table: $db.videoStatuses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> videoStatisticsRefs<T extends Object>(
    Expression<T> Function($$VideoStatisticsTableAnnotationComposer a) f,
  ) {
    final $$VideoStatisticsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoStatistics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoStatisticsTableAnnotationComposer(
            $db: $db,
            $table: $db.videoStatistics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> videoProgressRefs<T extends Object>(
    Expression<T> Function($$VideoProgressTableAnnotationComposer a) f,
  ) {
    final $$VideoProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoProgress,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.videoProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> playlistVsVideosRefs<T extends Object>(
    Expression<T> Function($$PlaylistVsVideosTableAnnotationComposer a) f,
  ) {
    final $$PlaylistVsVideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlistVsVideos,
      getReferencedColumn: (t) => t.videoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistVsVideosTableAnnotationComposer(
            $db: $db,
            $table: $db.playlistVsVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> videoSearchVsVideosRefs<T extends Object>(
    Expression<T> Function($$VideoSearchVsVideosTableAnnotationComposer a) f,
  ) {
    final $$VideoSearchVsVideosTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.videoSearchVsVideos,
          getReferencedColumn: (t) => t.videoId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VideoSearchVsVideosTableAnnotationComposer(
                $db: $db,
                $table: $db.videoSearchVsVideos,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> seriesRefs<T extends Object>(
    Expression<T> Function($$SeriesTableAnnotationComposer a) f,
  ) {
    final $$SeriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.coverVideoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableAnnotationComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> seriesVsVideosRefs<T extends Object>(
    Expression<T> Function($$SeriesVsVideosTableAnnotationComposer a) f,
  ) {
    final $$SeriesVsVideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seriesVsVideos,
      getReferencedColumn: (t) => t.videoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesVsVideosTableAnnotationComposer(
            $db: $db,
            $table: $db.seriesVsVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VideosTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideosTable,
          Video,
          $$VideosTableFilterComposer,
          $$VideosTableOrderingComposer,
          $$VideosTableAnnotationComposer,
          $$VideosTableCreateCompanionBuilder,
          $$VideosTableUpdateCompanionBuilder,
          (Video, $$VideosTableReferences),
          Video,
          PrefetchHooks Function({
            bool channelId,
            bool videoSnippetsRefs,
            bool videoThumbnailsRefs,
            bool videoContentDetailsRefs,
            bool videoStatusesRefs,
            bool videoStatisticsRefs,
            bool videoProgressRefs,
            bool playlistVsVideosRefs,
            bool videoSearchVsVideosRefs,
            bool seriesRefs,
            bool seriesVsVideosRefs,
          })
        > {
  $$VideosTableTableManager(_$Database db, $VideosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String?> etag = const Value.absent(),
                Value<String?> setag = const Value.absent(),
                Value<String> channelId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideosCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                etag: etag,
                setag: setag,
                channelId: channelId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                Value<String?> etag = const Value.absent(),
                Value<String?> setag = const Value.absent(),
                required String channelId,
                Value<int> rowid = const Value.absent(),
              }) => VideosCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                etag: etag,
                setag: setag,
                channelId: channelId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$VideosTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                channelId = false,
                videoSnippetsRefs = false,
                videoThumbnailsRefs = false,
                videoContentDetailsRefs = false,
                videoStatusesRefs = false,
                videoStatisticsRefs = false,
                videoProgressRefs = false,
                playlistVsVideosRefs = false,
                videoSearchVsVideosRefs = false,
                seriesRefs = false,
                seriesVsVideosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (videoSnippetsRefs) db.videoSnippets,
                    if (videoThumbnailsRefs) db.videoThumbnails,
                    if (videoContentDetailsRefs) db.videoContentDetails,
                    if (videoStatusesRefs) db.videoStatuses,
                    if (videoStatisticsRefs) db.videoStatistics,
                    if (videoProgressRefs) db.videoProgress,
                    if (playlistVsVideosRefs) db.playlistVsVideos,
                    if (videoSearchVsVideosRefs) db.videoSearchVsVideos,
                    if (seriesRefs) db.series,
                    if (seriesVsVideosRefs) db.seriesVsVideos,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (channelId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.channelId,
                                    referencedTable: $$VideosTableReferences
                                        ._channelIdTable(db),
                                    referencedColumn: $$VideosTableReferences
                                        ._channelIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (videoSnippetsRefs)
                        await $_getPrefetchedData<
                          Video,
                          $VideosTable,
                          VideoSnippet
                        >(
                          currentTable: table,
                          referencedTable: $$VideosTableReferences
                              ._videoSnippetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideosTableReferences(
                                db,
                                table,
                                p0,
                              ).videoSnippetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (videoThumbnailsRefs)
                        await $_getPrefetchedData<
                          Video,
                          $VideosTable,
                          VideoThumbnail
                        >(
                          currentTable: table,
                          referencedTable: $$VideosTableReferences
                              ._videoThumbnailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideosTableReferences(
                                db,
                                table,
                                p0,
                              ).videoThumbnailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (videoContentDetailsRefs)
                        await $_getPrefetchedData<
                          Video,
                          $VideosTable,
                          VideoContentDetail
                        >(
                          currentTable: table,
                          referencedTable: $$VideosTableReferences
                              ._videoContentDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideosTableReferences(
                                db,
                                table,
                                p0,
                              ).videoContentDetailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (videoStatusesRefs)
                        await $_getPrefetchedData<
                          Video,
                          $VideosTable,
                          VideoStatuse
                        >(
                          currentTable: table,
                          referencedTable: $$VideosTableReferences
                              ._videoStatusesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideosTableReferences(
                                db,
                                table,
                                p0,
                              ).videoStatusesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (videoStatisticsRefs)
                        await $_getPrefetchedData<
                          Video,
                          $VideosTable,
                          VideoStatistic
                        >(
                          currentTable: table,
                          referencedTable: $$VideosTableReferences
                              ._videoStatisticsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideosTableReferences(
                                db,
                                table,
                                p0,
                              ).videoStatisticsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (videoProgressRefs)
                        await $_getPrefetchedData<
                          Video,
                          $VideosTable,
                          VideoProgressData
                        >(
                          currentTable: table,
                          referencedTable: $$VideosTableReferences
                              ._videoProgressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideosTableReferences(
                                db,
                                table,
                                p0,
                              ).videoProgressRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (playlistVsVideosRefs)
                        await $_getPrefetchedData<
                          Video,
                          $VideosTable,
                          PlaylistVsVideo
                        >(
                          currentTable: table,
                          referencedTable: $$VideosTableReferences
                              ._playlistVsVideosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideosTableReferences(
                                db,
                                table,
                                p0,
                              ).playlistVsVideosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.videoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (videoSearchVsVideosRefs)
                        await $_getPrefetchedData<
                          Video,
                          $VideosTable,
                          VideoSearchVsVideo
                        >(
                          currentTable: table,
                          referencedTable: $$VideosTableReferences
                              ._videoSearchVsVideosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideosTableReferences(
                                db,
                                table,
                                p0,
                              ).videoSearchVsVideosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.videoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (seriesRefs)
                        await $_getPrefetchedData<Video, $VideosTable, Sery>(
                          currentTable: table,
                          referencedTable: $$VideosTableReferences
                              ._seriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideosTableReferences(db, table, p0).seriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coverVideoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (seriesVsVideosRefs)
                        await $_getPrefetchedData<
                          Video,
                          $VideosTable,
                          SeriesVsVideo
                        >(
                          currentTable: table,
                          referencedTable: $$VideosTableReferences
                              ._seriesVsVideosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideosTableReferences(
                                db,
                                table,
                                p0,
                              ).seriesVsVideosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.videoId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VideosTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideosTable,
      Video,
      $$VideosTableFilterComposer,
      $$VideosTableOrderingComposer,
      $$VideosTableAnnotationComposer,
      $$VideosTableCreateCompanionBuilder,
      $$VideosTableUpdateCompanionBuilder,
      (Video, $$VideosTableReferences),
      Video,
      PrefetchHooks Function({
        bool channelId,
        bool videoSnippetsRefs,
        bool videoThumbnailsRefs,
        bool videoContentDetailsRefs,
        bool videoStatusesRefs,
        bool videoStatisticsRefs,
        bool videoProgressRefs,
        bool playlistVsVideosRefs,
        bool videoSearchVsVideosRefs,
        bool seriesRefs,
        bool seriesVsVideosRefs,
      })
    >;
typedef $$VideoSnippetsTableCreateCompanionBuilder =
    VideoSnippetsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required DateTime publishedAt,
      required String title,
      required String description,
      required String channelTitle,
      Value<int> rowid,
    });
typedef $$VideoSnippetsTableUpdateCompanionBuilder =
    VideoSnippetsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<DateTime> publishedAt,
      Value<String> title,
      Value<String> description,
      Value<String> channelTitle,
      Value<int> rowid,
    });

final class $$VideoSnippetsTableReferences
    extends BaseReferences<_$Database, $VideoSnippetsTable, VideoSnippet> {
  $$VideoSnippetsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VideosTable _idTable(_$Database db) => db.videos.createAlias(
    $_aliasNameGenerator(db.videoSnippets.id, db.videos.id),
  );

  $$VideosTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VideoSnippetsTableFilterComposer
    extends Composer<_$Database, $VideoSnippetsTable> {
  $$VideoSnippetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channelTitle => $composableBuilder(
    column: $table.channelTitle,
    builder: (column) => ColumnFilters(column),
  );

  $$VideosTableFilterComposer get id {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoSnippetsTableOrderingComposer
    extends Composer<_$Database, $VideoSnippetsTable> {
  $$VideoSnippetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channelTitle => $composableBuilder(
    column: $table.channelTitle,
    builder: (column) => ColumnOrderings(column),
  );

  $$VideosTableOrderingComposer get id {
    final $$VideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableOrderingComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoSnippetsTableAnnotationComposer
    extends Composer<_$Database, $VideoSnippetsTable> {
  $$VideoSnippetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get channelTitle => $composableBuilder(
    column: $table.channelTitle,
    builder: (column) => column,
  );

  $$VideosTableAnnotationComposer get id {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoSnippetsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoSnippetsTable,
          VideoSnippet,
          $$VideoSnippetsTableFilterComposer,
          $$VideoSnippetsTableOrderingComposer,
          $$VideoSnippetsTableAnnotationComposer,
          $$VideoSnippetsTableCreateCompanionBuilder,
          $$VideoSnippetsTableUpdateCompanionBuilder,
          (VideoSnippet, $$VideoSnippetsTableReferences),
          VideoSnippet,
          PrefetchHooks Function({bool id})
        > {
  $$VideoSnippetsTableTableManager(_$Database db, $VideoSnippetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoSnippetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoSnippetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoSnippetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<DateTime> publishedAt = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> channelTitle = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoSnippetsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                publishedAt: publishedAt,
                title: title,
                description: description,
                channelTitle: channelTitle,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required DateTime publishedAt,
                required String title,
                required String description,
                required String channelTitle,
                Value<int> rowid = const Value.absent(),
              }) => VideoSnippetsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                publishedAt: publishedAt,
                title: title,
                description: description,
                channelTitle: channelTitle,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VideoSnippetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable: $$VideoSnippetsTableReferences
                                    ._idTable(db),
                                referencedColumn: $$VideoSnippetsTableReferences
                                    ._idTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VideoSnippetsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoSnippetsTable,
      VideoSnippet,
      $$VideoSnippetsTableFilterComposer,
      $$VideoSnippetsTableOrderingComposer,
      $$VideoSnippetsTableAnnotationComposer,
      $$VideoSnippetsTableCreateCompanionBuilder,
      $$VideoSnippetsTableUpdateCompanionBuilder,
      (VideoSnippet, $$VideoSnippetsTableReferences),
      VideoSnippet,
      PrefetchHooks Function({bool id})
    >;
typedef $$VideoThumbnailsTableCreateCompanionBuilder =
    VideoThumbnailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String defaultUrl,
      required String mediumUrl,
      required String highUrl,
      Value<String?> standardUrl,
      Value<String?> maxresUrl,
      Value<int> rowid,
    });
typedef $$VideoThumbnailsTableUpdateCompanionBuilder =
    VideoThumbnailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> defaultUrl,
      Value<String> mediumUrl,
      Value<String> highUrl,
      Value<String?> standardUrl,
      Value<String?> maxresUrl,
      Value<int> rowid,
    });

final class $$VideoThumbnailsTableReferences
    extends BaseReferences<_$Database, $VideoThumbnailsTable, VideoThumbnail> {
  $$VideoThumbnailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VideosTable _idTable(_$Database db) => db.videos.createAlias(
    $_aliasNameGenerator(db.videoThumbnails.id, db.videos.id),
  );

  $$VideosTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VideoThumbnailsTableFilterComposer
    extends Composer<_$Database, $VideoThumbnailsTable> {
  $$VideoThumbnailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultUrl => $composableBuilder(
    column: $table.defaultUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediumUrl => $composableBuilder(
    column: $table.mediumUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get highUrl => $composableBuilder(
    column: $table.highUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get standardUrl => $composableBuilder(
    column: $table.standardUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maxresUrl => $composableBuilder(
    column: $table.maxresUrl,
    builder: (column) => ColumnFilters(column),
  );

  $$VideosTableFilterComposer get id {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoThumbnailsTableOrderingComposer
    extends Composer<_$Database, $VideoThumbnailsTable> {
  $$VideoThumbnailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultUrl => $composableBuilder(
    column: $table.defaultUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediumUrl => $composableBuilder(
    column: $table.mediumUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get highUrl => $composableBuilder(
    column: $table.highUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get standardUrl => $composableBuilder(
    column: $table.standardUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maxresUrl => $composableBuilder(
    column: $table.maxresUrl,
    builder: (column) => ColumnOrderings(column),
  );

  $$VideosTableOrderingComposer get id {
    final $$VideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableOrderingComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoThumbnailsTableAnnotationComposer
    extends Composer<_$Database, $VideoThumbnailsTable> {
  $$VideoThumbnailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get defaultUrl => $composableBuilder(
    column: $table.defaultUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mediumUrl =>
      $composableBuilder(column: $table.mediumUrl, builder: (column) => column);

  GeneratedColumn<String> get highUrl =>
      $composableBuilder(column: $table.highUrl, builder: (column) => column);

  GeneratedColumn<String> get standardUrl => $composableBuilder(
    column: $table.standardUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get maxresUrl =>
      $composableBuilder(column: $table.maxresUrl, builder: (column) => column);

  $$VideosTableAnnotationComposer get id {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoThumbnailsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoThumbnailsTable,
          VideoThumbnail,
          $$VideoThumbnailsTableFilterComposer,
          $$VideoThumbnailsTableOrderingComposer,
          $$VideoThumbnailsTableAnnotationComposer,
          $$VideoThumbnailsTableCreateCompanionBuilder,
          $$VideoThumbnailsTableUpdateCompanionBuilder,
          (VideoThumbnail, $$VideoThumbnailsTableReferences),
          VideoThumbnail,
          PrefetchHooks Function({bool id})
        > {
  $$VideoThumbnailsTableTableManager(_$Database db, $VideoThumbnailsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoThumbnailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoThumbnailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoThumbnailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> defaultUrl = const Value.absent(),
                Value<String> mediumUrl = const Value.absent(),
                Value<String> highUrl = const Value.absent(),
                Value<String?> standardUrl = const Value.absent(),
                Value<String?> maxresUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoThumbnailsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                defaultUrl: defaultUrl,
                mediumUrl: mediumUrl,
                highUrl: highUrl,
                standardUrl: standardUrl,
                maxresUrl: maxresUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String defaultUrl,
                required String mediumUrl,
                required String highUrl,
                Value<String?> standardUrl = const Value.absent(),
                Value<String?> maxresUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoThumbnailsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                defaultUrl: defaultUrl,
                mediumUrl: mediumUrl,
                highUrl: highUrl,
                standardUrl: standardUrl,
                maxresUrl: maxresUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VideoThumbnailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$VideoThumbnailsTableReferences._idTable(
                                      db,
                                    ),
                                referencedColumn:
                                    $$VideoThumbnailsTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VideoThumbnailsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoThumbnailsTable,
      VideoThumbnail,
      $$VideoThumbnailsTableFilterComposer,
      $$VideoThumbnailsTableOrderingComposer,
      $$VideoThumbnailsTableAnnotationComposer,
      $$VideoThumbnailsTableCreateCompanionBuilder,
      $$VideoThumbnailsTableUpdateCompanionBuilder,
      (VideoThumbnail, $$VideoThumbnailsTableReferences),
      VideoThumbnail,
      PrefetchHooks Function({bool id})
    >;
typedef $$VideoContentDetailsTableCreateCompanionBuilder =
    VideoContentDetailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String duration,
      required String dimension,
      required String definition,
      required String caption,
      required bool licensedContent,
      required String projection,
      Value<int> rowid,
    });
typedef $$VideoContentDetailsTableUpdateCompanionBuilder =
    VideoContentDetailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> duration,
      Value<String> dimension,
      Value<String> definition,
      Value<String> caption,
      Value<bool> licensedContent,
      Value<String> projection,
      Value<int> rowid,
    });

final class $$VideoContentDetailsTableReferences
    extends
        BaseReferences<
          _$Database,
          $VideoContentDetailsTable,
          VideoContentDetail
        > {
  $$VideoContentDetailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VideosTable _idTable(_$Database db) => db.videos.createAlias(
    $_aliasNameGenerator(db.videoContentDetails.id, db.videos.id),
  );

  $$VideosTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VideoContentDetailsTableFilterComposer
    extends Composer<_$Database, $VideoContentDetailsTable> {
  $$VideoContentDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dimension => $composableBuilder(
    column: $table.dimension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get licensedContent => $composableBuilder(
    column: $table.licensedContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projection => $composableBuilder(
    column: $table.projection,
    builder: (column) => ColumnFilters(column),
  );

  $$VideosTableFilterComposer get id {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoContentDetailsTableOrderingComposer
    extends Composer<_$Database, $VideoContentDetailsTable> {
  $$VideoContentDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dimension => $composableBuilder(
    column: $table.dimension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get licensedContent => $composableBuilder(
    column: $table.licensedContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projection => $composableBuilder(
    column: $table.projection,
    builder: (column) => ColumnOrderings(column),
  );

  $$VideosTableOrderingComposer get id {
    final $$VideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableOrderingComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoContentDetailsTableAnnotationComposer
    extends Composer<_$Database, $VideoContentDetailsTable> {
  $$VideoContentDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get dimension =>
      $composableBuilder(column: $table.dimension, builder: (column) => column);

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<bool> get licensedContent => $composableBuilder(
    column: $table.licensedContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get projection => $composableBuilder(
    column: $table.projection,
    builder: (column) => column,
  );

  $$VideosTableAnnotationComposer get id {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoContentDetailsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoContentDetailsTable,
          VideoContentDetail,
          $$VideoContentDetailsTableFilterComposer,
          $$VideoContentDetailsTableOrderingComposer,
          $$VideoContentDetailsTableAnnotationComposer,
          $$VideoContentDetailsTableCreateCompanionBuilder,
          $$VideoContentDetailsTableUpdateCompanionBuilder,
          (VideoContentDetail, $$VideoContentDetailsTableReferences),
          VideoContentDetail,
          PrefetchHooks Function({bool id})
        > {
  $$VideoContentDetailsTableTableManager(
    _$Database db,
    $VideoContentDetailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoContentDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoContentDetailsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$VideoContentDetailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> duration = const Value.absent(),
                Value<String> dimension = const Value.absent(),
                Value<String> definition = const Value.absent(),
                Value<String> caption = const Value.absent(),
                Value<bool> licensedContent = const Value.absent(),
                Value<String> projection = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoContentDetailsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                duration: duration,
                dimension: dimension,
                definition: definition,
                caption: caption,
                licensedContent: licensedContent,
                projection: projection,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String duration,
                required String dimension,
                required String definition,
                required String caption,
                required bool licensedContent,
                required String projection,
                Value<int> rowid = const Value.absent(),
              }) => VideoContentDetailsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                duration: duration,
                dimension: dimension,
                definition: definition,
                caption: caption,
                licensedContent: licensedContent,
                projection: projection,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VideoContentDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$VideoContentDetailsTableReferences
                                        ._idTable(db),
                                referencedColumn:
                                    $$VideoContentDetailsTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VideoContentDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoContentDetailsTable,
      VideoContentDetail,
      $$VideoContentDetailsTableFilterComposer,
      $$VideoContentDetailsTableOrderingComposer,
      $$VideoContentDetailsTableAnnotationComposer,
      $$VideoContentDetailsTableCreateCompanionBuilder,
      $$VideoContentDetailsTableUpdateCompanionBuilder,
      (VideoContentDetail, $$VideoContentDetailsTableReferences),
      VideoContentDetail,
      PrefetchHooks Function({bool id})
    >;
typedef $$VideoStatusesTableCreateCompanionBuilder =
    VideoStatusesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String uploadStatus,
      required String privacyStatus,
      required String license,
      required bool embeddable,
      required bool publicStatsViewable,
      required bool madeForKids,
      Value<int> rowid,
    });
typedef $$VideoStatusesTableUpdateCompanionBuilder =
    VideoStatusesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> uploadStatus,
      Value<String> privacyStatus,
      Value<String> license,
      Value<bool> embeddable,
      Value<bool> publicStatsViewable,
      Value<bool> madeForKids,
      Value<int> rowid,
    });

final class $$VideoStatusesTableReferences
    extends BaseReferences<_$Database, $VideoStatusesTable, VideoStatuse> {
  $$VideoStatusesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VideosTable _idTable(_$Database db) => db.videos.createAlias(
    $_aliasNameGenerator(db.videoStatuses.id, db.videos.id),
  );

  $$VideosTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VideoStatusesTableFilterComposer
    extends Composer<_$Database, $VideoStatusesTable> {
  $$VideoStatusesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get privacyStatus => $composableBuilder(
    column: $table.privacyStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get license => $composableBuilder(
    column: $table.license,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get embeddable => $composableBuilder(
    column: $table.embeddable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get publicStatsViewable => $composableBuilder(
    column: $table.publicStatsViewable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get madeForKids => $composableBuilder(
    column: $table.madeForKids,
    builder: (column) => ColumnFilters(column),
  );

  $$VideosTableFilterComposer get id {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoStatusesTableOrderingComposer
    extends Composer<_$Database, $VideoStatusesTable> {
  $$VideoStatusesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get privacyStatus => $composableBuilder(
    column: $table.privacyStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get license => $composableBuilder(
    column: $table.license,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get embeddable => $composableBuilder(
    column: $table.embeddable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get publicStatsViewable => $composableBuilder(
    column: $table.publicStatsViewable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get madeForKids => $composableBuilder(
    column: $table.madeForKids,
    builder: (column) => ColumnOrderings(column),
  );

  $$VideosTableOrderingComposer get id {
    final $$VideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableOrderingComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoStatusesTableAnnotationComposer
    extends Composer<_$Database, $VideoStatusesTable> {
  $$VideoStatusesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get privacyStatus => $composableBuilder(
    column: $table.privacyStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get license =>
      $composableBuilder(column: $table.license, builder: (column) => column);

  GeneratedColumn<bool> get embeddable => $composableBuilder(
    column: $table.embeddable,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get publicStatsViewable => $composableBuilder(
    column: $table.publicStatsViewable,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get madeForKids => $composableBuilder(
    column: $table.madeForKids,
    builder: (column) => column,
  );

  $$VideosTableAnnotationComposer get id {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoStatusesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoStatusesTable,
          VideoStatuse,
          $$VideoStatusesTableFilterComposer,
          $$VideoStatusesTableOrderingComposer,
          $$VideoStatusesTableAnnotationComposer,
          $$VideoStatusesTableCreateCompanionBuilder,
          $$VideoStatusesTableUpdateCompanionBuilder,
          (VideoStatuse, $$VideoStatusesTableReferences),
          VideoStatuse,
          PrefetchHooks Function({bool id})
        > {
  $$VideoStatusesTableTableManager(_$Database db, $VideoStatusesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoStatusesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoStatusesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoStatusesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> uploadStatus = const Value.absent(),
                Value<String> privacyStatus = const Value.absent(),
                Value<String> license = const Value.absent(),
                Value<bool> embeddable = const Value.absent(),
                Value<bool> publicStatsViewable = const Value.absent(),
                Value<bool> madeForKids = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoStatusesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                uploadStatus: uploadStatus,
                privacyStatus: privacyStatus,
                license: license,
                embeddable: embeddable,
                publicStatsViewable: publicStatsViewable,
                madeForKids: madeForKids,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String uploadStatus,
                required String privacyStatus,
                required String license,
                required bool embeddable,
                required bool publicStatsViewable,
                required bool madeForKids,
                Value<int> rowid = const Value.absent(),
              }) => VideoStatusesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                uploadStatus: uploadStatus,
                privacyStatus: privacyStatus,
                license: license,
                embeddable: embeddable,
                publicStatsViewable: publicStatsViewable,
                madeForKids: madeForKids,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VideoStatusesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable: $$VideoStatusesTableReferences
                                    ._idTable(db),
                                referencedColumn: $$VideoStatusesTableReferences
                                    ._idTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VideoStatusesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoStatusesTable,
      VideoStatuse,
      $$VideoStatusesTableFilterComposer,
      $$VideoStatusesTableOrderingComposer,
      $$VideoStatusesTableAnnotationComposer,
      $$VideoStatusesTableCreateCompanionBuilder,
      $$VideoStatusesTableUpdateCompanionBuilder,
      (VideoStatuse, $$VideoStatusesTableReferences),
      VideoStatuse,
      PrefetchHooks Function({bool id})
    >;
typedef $$VideoStatisticsTableCreateCompanionBuilder =
    VideoStatisticsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required int viewCount,
      Value<int?> likeCount,
      Value<int?> dislikeCount,
      required int favoriteCount,
      Value<int?> commentCount,
      Value<int> rowid,
    });
typedef $$VideoStatisticsTableUpdateCompanionBuilder =
    VideoStatisticsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<int> viewCount,
      Value<int?> likeCount,
      Value<int?> dislikeCount,
      Value<int> favoriteCount,
      Value<int?> commentCount,
      Value<int> rowid,
    });

final class $$VideoStatisticsTableReferences
    extends BaseReferences<_$Database, $VideoStatisticsTable, VideoStatistic> {
  $$VideoStatisticsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VideosTable _idTable(_$Database db) => db.videos.createAlias(
    $_aliasNameGenerator(db.videoStatistics.id, db.videos.id),
  );

  $$VideosTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VideoStatisticsTableFilterComposer
    extends Composer<_$Database, $VideoStatisticsTable> {
  $$VideoStatisticsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get viewCount => $composableBuilder(
    column: $table.viewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get likeCount => $composableBuilder(
    column: $table.likeCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dislikeCount => $composableBuilder(
    column: $table.dislikeCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get favoriteCount => $composableBuilder(
    column: $table.favoriteCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get commentCount => $composableBuilder(
    column: $table.commentCount,
    builder: (column) => ColumnFilters(column),
  );

  $$VideosTableFilterComposer get id {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoStatisticsTableOrderingComposer
    extends Composer<_$Database, $VideoStatisticsTable> {
  $$VideoStatisticsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get viewCount => $composableBuilder(
    column: $table.viewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get likeCount => $composableBuilder(
    column: $table.likeCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dislikeCount => $composableBuilder(
    column: $table.dislikeCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get favoriteCount => $composableBuilder(
    column: $table.favoriteCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get commentCount => $composableBuilder(
    column: $table.commentCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$VideosTableOrderingComposer get id {
    final $$VideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableOrderingComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoStatisticsTableAnnotationComposer
    extends Composer<_$Database, $VideoStatisticsTable> {
  $$VideoStatisticsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get viewCount =>
      $composableBuilder(column: $table.viewCount, builder: (column) => column);

  GeneratedColumn<int> get likeCount =>
      $composableBuilder(column: $table.likeCount, builder: (column) => column);

  GeneratedColumn<int> get dislikeCount => $composableBuilder(
    column: $table.dislikeCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get favoriteCount => $composableBuilder(
    column: $table.favoriteCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get commentCount => $composableBuilder(
    column: $table.commentCount,
    builder: (column) => column,
  );

  $$VideosTableAnnotationComposer get id {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoStatisticsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoStatisticsTable,
          VideoStatistic,
          $$VideoStatisticsTableFilterComposer,
          $$VideoStatisticsTableOrderingComposer,
          $$VideoStatisticsTableAnnotationComposer,
          $$VideoStatisticsTableCreateCompanionBuilder,
          $$VideoStatisticsTableUpdateCompanionBuilder,
          (VideoStatistic, $$VideoStatisticsTableReferences),
          VideoStatistic,
          PrefetchHooks Function({bool id})
        > {
  $$VideoStatisticsTableTableManager(_$Database db, $VideoStatisticsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoStatisticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoStatisticsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoStatisticsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<int> viewCount = const Value.absent(),
                Value<int?> likeCount = const Value.absent(),
                Value<int?> dislikeCount = const Value.absent(),
                Value<int> favoriteCount = const Value.absent(),
                Value<int?> commentCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoStatisticsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                viewCount: viewCount,
                likeCount: likeCount,
                dislikeCount: dislikeCount,
                favoriteCount: favoriteCount,
                commentCount: commentCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required int viewCount,
                Value<int?> likeCount = const Value.absent(),
                Value<int?> dislikeCount = const Value.absent(),
                required int favoriteCount,
                Value<int?> commentCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoStatisticsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                viewCount: viewCount,
                likeCount: likeCount,
                dislikeCount: dislikeCount,
                favoriteCount: favoriteCount,
                commentCount: commentCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VideoStatisticsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$VideoStatisticsTableReferences._idTable(
                                      db,
                                    ),
                                referencedColumn:
                                    $$VideoStatisticsTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VideoStatisticsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoStatisticsTable,
      VideoStatistic,
      $$VideoStatisticsTableFilterComposer,
      $$VideoStatisticsTableOrderingComposer,
      $$VideoStatisticsTableAnnotationComposer,
      $$VideoStatisticsTableCreateCompanionBuilder,
      $$VideoStatisticsTableUpdateCompanionBuilder,
      (VideoStatistic, $$VideoStatisticsTableReferences),
      VideoStatistic,
      PrefetchHooks Function({bool id})
    >;
typedef $$VideoProgressTableCreateCompanionBuilder =
    VideoProgressCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      Value<int> watchPosition,
      Value<bool> isFinished,
      Value<int> rowid,
    });
typedef $$VideoProgressTableUpdateCompanionBuilder =
    VideoProgressCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<int> watchPosition,
      Value<bool> isFinished,
      Value<int> rowid,
    });

final class $$VideoProgressTableReferences
    extends BaseReferences<_$Database, $VideoProgressTable, VideoProgressData> {
  $$VideoProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VideosTable _idTable(_$Database db) => db.videos.createAlias(
    $_aliasNameGenerator(db.videoProgress.id, db.videos.id),
  );

  $$VideosTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VideoProgressTableFilterComposer
    extends Composer<_$Database, $VideoProgressTable> {
  $$VideoProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get watchPosition => $composableBuilder(
    column: $table.watchPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFinished => $composableBuilder(
    column: $table.isFinished,
    builder: (column) => ColumnFilters(column),
  );

  $$VideosTableFilterComposer get id {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoProgressTableOrderingComposer
    extends Composer<_$Database, $VideoProgressTable> {
  $$VideoProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get watchPosition => $composableBuilder(
    column: $table.watchPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFinished => $composableBuilder(
    column: $table.isFinished,
    builder: (column) => ColumnOrderings(column),
  );

  $$VideosTableOrderingComposer get id {
    final $$VideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableOrderingComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoProgressTableAnnotationComposer
    extends Composer<_$Database, $VideoProgressTable> {
  $$VideoProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get watchPosition => $composableBuilder(
    column: $table.watchPosition,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFinished => $composableBuilder(
    column: $table.isFinished,
    builder: (column) => column,
  );

  $$VideosTableAnnotationComposer get id {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoProgressTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoProgressTable,
          VideoProgressData,
          $$VideoProgressTableFilterComposer,
          $$VideoProgressTableOrderingComposer,
          $$VideoProgressTableAnnotationComposer,
          $$VideoProgressTableCreateCompanionBuilder,
          $$VideoProgressTableUpdateCompanionBuilder,
          (VideoProgressData, $$VideoProgressTableReferences),
          VideoProgressData,
          PrefetchHooks Function({bool id})
        > {
  $$VideoProgressTableTableManager(_$Database db, $VideoProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<int> watchPosition = const Value.absent(),
                Value<bool> isFinished = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoProgressCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                watchPosition: watchPosition,
                isFinished: isFinished,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                Value<int> watchPosition = const Value.absent(),
                Value<bool> isFinished = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoProgressCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                watchPosition: watchPosition,
                isFinished: isFinished,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VideoProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable: $$VideoProgressTableReferences
                                    ._idTable(db),
                                referencedColumn: $$VideoProgressTableReferences
                                    ._idTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VideoProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoProgressTable,
      VideoProgressData,
      $$VideoProgressTableFilterComposer,
      $$VideoProgressTableOrderingComposer,
      $$VideoProgressTableAnnotationComposer,
      $$VideoProgressTableCreateCompanionBuilder,
      $$VideoProgressTableUpdateCompanionBuilder,
      (VideoProgressData, $$VideoProgressTableReferences),
      VideoProgressData,
      PrefetchHooks Function({bool id})
    >;
typedef $$PlaylistsTableCreateCompanionBuilder =
    PlaylistsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String channelId,
      required PlaylistType type,
      required int priority,
      required String etag,
      Value<int> rowid,
    });
typedef $$PlaylistsTableUpdateCompanionBuilder =
    PlaylistsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> channelId,
      Value<PlaylistType> type,
      Value<int> priority,
      Value<String> etag,
      Value<int> rowid,
    });

final class $$PlaylistsTableReferences
    extends BaseReferences<_$Database, $PlaylistsTable, Playlist> {
  $$PlaylistsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChannelsTable _channelIdTable(_$Database db) =>
      db.channels.createAlias(
        $_aliasNameGenerator(db.playlists.channelId, db.channels.id),
      );

  $$ChannelsTableProcessedTableManager get channelId {
    final $_column = $_itemColumn<String>('channel_id')!;

    final manager = $$ChannelsTableTableManager(
      $_db,
      $_db.channels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_channelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlaylistSnippetsTable, List<PlaylistSnippet>>
  _playlistSnippetsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.playlistSnippets,
    aliasName: $_aliasNameGenerator(db.playlists.id, db.playlistSnippets.id),
  );

  $$PlaylistSnippetsTableProcessedTableManager get playlistSnippetsRefs {
    final manager = $$PlaylistSnippetsTableTableManager(
      $_db,
      $_db.playlistSnippets,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playlistSnippetsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlaylistThumbnailsTable, List<PlaylistThumbnail>>
  _playlistThumbnailsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.playlistThumbnails,
    aliasName: $_aliasNameGenerator(db.playlists.id, db.playlistThumbnails.id),
  );

  $$PlaylistThumbnailsTableProcessedTableManager get playlistThumbnailsRefs {
    final manager = $$PlaylistThumbnailsTableTableManager(
      $_db,
      $_db.playlistThumbnails,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playlistThumbnailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PlaylistContentDetailsTable,
    List<PlaylistContentDetail>
  >
  _playlistContentDetailsRefsTable(_$Database db) =>
      MultiTypedResultKey.fromTable(
        db.playlistContentDetails,
        aliasName: $_aliasNameGenerator(
          db.playlists.id,
          db.playlistContentDetails.id,
        ),
      );

  $$PlaylistContentDetailsTableProcessedTableManager
  get playlistContentDetailsRefs {
    final manager = $$PlaylistContentDetailsTableTableManager(
      $_db,
      $_db.playlistContentDetails,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playlistContentDetailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlaylistVsVideosTable, List<PlaylistVsVideo>>
  _playlistVsVideosRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.playlistVsVideos,
    aliasName: $_aliasNameGenerator(
      db.playlists.id,
      db.playlistVsVideos.playlistId,
    ),
  );

  $$PlaylistVsVideosTableProcessedTableManager get playlistVsVideosRefs {
    final manager = $$PlaylistVsVideosTableTableManager(
      $_db,
      $_db.playlistVsVideos,
    ).filter((f) => f.playlistId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playlistVsVideosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlaylistsTableFilterComposer
    extends Composer<_$Database, $PlaylistsTable> {
  $$PlaylistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlaylistType, PlaylistType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnFilters(column),
  );

  $$ChannelsTableFilterComposer get channelId {
    final $$ChannelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableFilterComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> playlistSnippetsRefs(
    Expression<bool> Function($$PlaylistSnippetsTableFilterComposer f) f,
  ) {
    final $$PlaylistSnippetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlistSnippets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistSnippetsTableFilterComposer(
            $db: $db,
            $table: $db.playlistSnippets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> playlistThumbnailsRefs(
    Expression<bool> Function($$PlaylistThumbnailsTableFilterComposer f) f,
  ) {
    final $$PlaylistThumbnailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlistThumbnails,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistThumbnailsTableFilterComposer(
            $db: $db,
            $table: $db.playlistThumbnails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> playlistContentDetailsRefs(
    Expression<bool> Function($$PlaylistContentDetailsTableFilterComposer f) f,
  ) {
    final $$PlaylistContentDetailsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.playlistContentDetails,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PlaylistContentDetailsTableFilterComposer(
                $db: $db,
                $table: $db.playlistContentDetails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> playlistVsVideosRefs(
    Expression<bool> Function($$PlaylistVsVideosTableFilterComposer f) f,
  ) {
    final $$PlaylistVsVideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlistVsVideos,
      getReferencedColumn: (t) => t.playlistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistVsVideosTableFilterComposer(
            $db: $db,
            $table: $db.playlistVsVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlaylistsTableOrderingComposer
    extends Composer<_$Database, $PlaylistsTable> {
  $$PlaylistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChannelsTableOrderingComposer get channelId {
    final $$ChannelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableOrderingComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistsTableAnnotationComposer
    extends Composer<_$Database, $PlaylistsTable> {
  $$PlaylistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PlaylistType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get etag =>
      $composableBuilder(column: $table.etag, builder: (column) => column);

  $$ChannelsTableAnnotationComposer get channelId {
    final $$ChannelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableAnnotationComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> playlistSnippetsRefs<T extends Object>(
    Expression<T> Function($$PlaylistSnippetsTableAnnotationComposer a) f,
  ) {
    final $$PlaylistSnippetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlistSnippets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistSnippetsTableAnnotationComposer(
            $db: $db,
            $table: $db.playlistSnippets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> playlistThumbnailsRefs<T extends Object>(
    Expression<T> Function($$PlaylistThumbnailsTableAnnotationComposer a) f,
  ) {
    final $$PlaylistThumbnailsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.playlistThumbnails,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PlaylistThumbnailsTableAnnotationComposer(
                $db: $db,
                $table: $db.playlistThumbnails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> playlistContentDetailsRefs<T extends Object>(
    Expression<T> Function($$PlaylistContentDetailsTableAnnotationComposer a) f,
  ) {
    final $$PlaylistContentDetailsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.playlistContentDetails,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PlaylistContentDetailsTableAnnotationComposer(
                $db: $db,
                $table: $db.playlistContentDetails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> playlistVsVideosRefs<T extends Object>(
    Expression<T> Function($$PlaylistVsVideosTableAnnotationComposer a) f,
  ) {
    final $$PlaylistVsVideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlistVsVideos,
      getReferencedColumn: (t) => t.playlistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistVsVideosTableAnnotationComposer(
            $db: $db,
            $table: $db.playlistVsVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlaylistsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $PlaylistsTable,
          Playlist,
          $$PlaylistsTableFilterComposer,
          $$PlaylistsTableOrderingComposer,
          $$PlaylistsTableAnnotationComposer,
          $$PlaylistsTableCreateCompanionBuilder,
          $$PlaylistsTableUpdateCompanionBuilder,
          (Playlist, $$PlaylistsTableReferences),
          Playlist,
          PrefetchHooks Function({
            bool channelId,
            bool playlistSnippetsRefs,
            bool playlistThumbnailsRefs,
            bool playlistContentDetailsRefs,
            bool playlistVsVideosRefs,
          })
        > {
  $$PlaylistsTableTableManager(_$Database db, $PlaylistsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> channelId = const Value.absent(),
                Value<PlaylistType> type = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> etag = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaylistsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                channelId: channelId,
                type: type,
                priority: priority,
                etag: etag,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String channelId,
                required PlaylistType type,
                required int priority,
                required String etag,
                Value<int> rowid = const Value.absent(),
              }) => PlaylistsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                channelId: channelId,
                type: type,
                priority: priority,
                etag: etag,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlaylistsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                channelId = false,
                playlistSnippetsRefs = false,
                playlistThumbnailsRefs = false,
                playlistContentDetailsRefs = false,
                playlistVsVideosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (playlistSnippetsRefs) db.playlistSnippets,
                    if (playlistThumbnailsRefs) db.playlistThumbnails,
                    if (playlistContentDetailsRefs) db.playlistContentDetails,
                    if (playlistVsVideosRefs) db.playlistVsVideos,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (channelId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.channelId,
                                    referencedTable: $$PlaylistsTableReferences
                                        ._channelIdTable(db),
                                    referencedColumn: $$PlaylistsTableReferences
                                        ._channelIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (playlistSnippetsRefs)
                        await $_getPrefetchedData<
                          Playlist,
                          $PlaylistsTable,
                          PlaylistSnippet
                        >(
                          currentTable: table,
                          referencedTable: $$PlaylistsTableReferences
                              ._playlistSnippetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlaylistsTableReferences(
                                db,
                                table,
                                p0,
                              ).playlistSnippetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (playlistThumbnailsRefs)
                        await $_getPrefetchedData<
                          Playlist,
                          $PlaylistsTable,
                          PlaylistThumbnail
                        >(
                          currentTable: table,
                          referencedTable: $$PlaylistsTableReferences
                              ._playlistThumbnailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlaylistsTableReferences(
                                db,
                                table,
                                p0,
                              ).playlistThumbnailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (playlistContentDetailsRefs)
                        await $_getPrefetchedData<
                          Playlist,
                          $PlaylistsTable,
                          PlaylistContentDetail
                        >(
                          currentTable: table,
                          referencedTable: $$PlaylistsTableReferences
                              ._playlistContentDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlaylistsTableReferences(
                                db,
                                table,
                                p0,
                              ).playlistContentDetailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (playlistVsVideosRefs)
                        await $_getPrefetchedData<
                          Playlist,
                          $PlaylistsTable,
                          PlaylistVsVideo
                        >(
                          currentTable: table,
                          referencedTable: $$PlaylistsTableReferences
                              ._playlistVsVideosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlaylistsTableReferences(
                                db,
                                table,
                                p0,
                              ).playlistVsVideosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playlistId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlaylistsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $PlaylistsTable,
      Playlist,
      $$PlaylistsTableFilterComposer,
      $$PlaylistsTableOrderingComposer,
      $$PlaylistsTableAnnotationComposer,
      $$PlaylistsTableCreateCompanionBuilder,
      $$PlaylistsTableUpdateCompanionBuilder,
      (Playlist, $$PlaylistsTableReferences),
      Playlist,
      PrefetchHooks Function({
        bool channelId,
        bool playlistSnippetsRefs,
        bool playlistThumbnailsRefs,
        bool playlistContentDetailsRefs,
        bool playlistVsVideosRefs,
      })
    >;
typedef $$PlaylistSnippetsTableCreateCompanionBuilder =
    PlaylistSnippetsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required DateTime publishedAt,
      required String title,
      required String description,
      required String channelTitle,
      Value<int> rowid,
    });
typedef $$PlaylistSnippetsTableUpdateCompanionBuilder =
    PlaylistSnippetsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<DateTime> publishedAt,
      Value<String> title,
      Value<String> description,
      Value<String> channelTitle,
      Value<int> rowid,
    });

final class $$PlaylistSnippetsTableReferences
    extends
        BaseReferences<_$Database, $PlaylistSnippetsTable, PlaylistSnippet> {
  $$PlaylistSnippetsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlaylistsTable _idTable(_$Database db) => db.playlists.createAlias(
    $_aliasNameGenerator(db.playlistSnippets.id, db.playlists.id),
  );

  $$PlaylistsTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$PlaylistsTableTableManager(
      $_db,
      $_db.playlists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlaylistSnippetsTableFilterComposer
    extends Composer<_$Database, $PlaylistSnippetsTable> {
  $$PlaylistSnippetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channelTitle => $composableBuilder(
    column: $table.channelTitle,
    builder: (column) => ColumnFilters(column),
  );

  $$PlaylistsTableFilterComposer get id {
    final $$PlaylistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableFilterComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistSnippetsTableOrderingComposer
    extends Composer<_$Database, $PlaylistSnippetsTable> {
  $$PlaylistSnippetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channelTitle => $composableBuilder(
    column: $table.channelTitle,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlaylistsTableOrderingComposer get id {
    final $$PlaylistsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableOrderingComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistSnippetsTableAnnotationComposer
    extends Composer<_$Database, $PlaylistSnippetsTable> {
  $$PlaylistSnippetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get channelTitle => $composableBuilder(
    column: $table.channelTitle,
    builder: (column) => column,
  );

  $$PlaylistsTableAnnotationComposer get id {
    final $$PlaylistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableAnnotationComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistSnippetsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $PlaylistSnippetsTable,
          PlaylistSnippet,
          $$PlaylistSnippetsTableFilterComposer,
          $$PlaylistSnippetsTableOrderingComposer,
          $$PlaylistSnippetsTableAnnotationComposer,
          $$PlaylistSnippetsTableCreateCompanionBuilder,
          $$PlaylistSnippetsTableUpdateCompanionBuilder,
          (PlaylistSnippet, $$PlaylistSnippetsTableReferences),
          PlaylistSnippet,
          PrefetchHooks Function({bool id})
        > {
  $$PlaylistSnippetsTableTableManager(
    _$Database db,
    $PlaylistSnippetsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistSnippetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistSnippetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistSnippetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<DateTime> publishedAt = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> channelTitle = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaylistSnippetsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                publishedAt: publishedAt,
                title: title,
                description: description,
                channelTitle: channelTitle,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required DateTime publishedAt,
                required String title,
                required String description,
                required String channelTitle,
                Value<int> rowid = const Value.absent(),
              }) => PlaylistSnippetsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                publishedAt: publishedAt,
                title: title,
                description: description,
                channelTitle: channelTitle,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlaylistSnippetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$PlaylistSnippetsTableReferences._idTable(
                                      db,
                                    ),
                                referencedColumn:
                                    $$PlaylistSnippetsTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlaylistSnippetsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $PlaylistSnippetsTable,
      PlaylistSnippet,
      $$PlaylistSnippetsTableFilterComposer,
      $$PlaylistSnippetsTableOrderingComposer,
      $$PlaylistSnippetsTableAnnotationComposer,
      $$PlaylistSnippetsTableCreateCompanionBuilder,
      $$PlaylistSnippetsTableUpdateCompanionBuilder,
      (PlaylistSnippet, $$PlaylistSnippetsTableReferences),
      PlaylistSnippet,
      PrefetchHooks Function({bool id})
    >;
typedef $$PlaylistThumbnailsTableCreateCompanionBuilder =
    PlaylistThumbnailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String defaultUrl,
      required String mediumUrl,
      required String highUrl,
      Value<String?> standardUrl,
      Value<String?> maxresUrl,
      Value<int> rowid,
    });
typedef $$PlaylistThumbnailsTableUpdateCompanionBuilder =
    PlaylistThumbnailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> defaultUrl,
      Value<String> mediumUrl,
      Value<String> highUrl,
      Value<String?> standardUrl,
      Value<String?> maxresUrl,
      Value<int> rowid,
    });

final class $$PlaylistThumbnailsTableReferences
    extends
        BaseReferences<
          _$Database,
          $PlaylistThumbnailsTable,
          PlaylistThumbnail
        > {
  $$PlaylistThumbnailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlaylistsTable _idTable(_$Database db) => db.playlists.createAlias(
    $_aliasNameGenerator(db.playlistThumbnails.id, db.playlists.id),
  );

  $$PlaylistsTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$PlaylistsTableTableManager(
      $_db,
      $_db.playlists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlaylistThumbnailsTableFilterComposer
    extends Composer<_$Database, $PlaylistThumbnailsTable> {
  $$PlaylistThumbnailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultUrl => $composableBuilder(
    column: $table.defaultUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediumUrl => $composableBuilder(
    column: $table.mediumUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get highUrl => $composableBuilder(
    column: $table.highUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get standardUrl => $composableBuilder(
    column: $table.standardUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maxresUrl => $composableBuilder(
    column: $table.maxresUrl,
    builder: (column) => ColumnFilters(column),
  );

  $$PlaylistsTableFilterComposer get id {
    final $$PlaylistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableFilterComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistThumbnailsTableOrderingComposer
    extends Composer<_$Database, $PlaylistThumbnailsTable> {
  $$PlaylistThumbnailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultUrl => $composableBuilder(
    column: $table.defaultUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediumUrl => $composableBuilder(
    column: $table.mediumUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get highUrl => $composableBuilder(
    column: $table.highUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get standardUrl => $composableBuilder(
    column: $table.standardUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maxresUrl => $composableBuilder(
    column: $table.maxresUrl,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlaylistsTableOrderingComposer get id {
    final $$PlaylistsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableOrderingComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistThumbnailsTableAnnotationComposer
    extends Composer<_$Database, $PlaylistThumbnailsTable> {
  $$PlaylistThumbnailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get defaultUrl => $composableBuilder(
    column: $table.defaultUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mediumUrl =>
      $composableBuilder(column: $table.mediumUrl, builder: (column) => column);

  GeneratedColumn<String> get highUrl =>
      $composableBuilder(column: $table.highUrl, builder: (column) => column);

  GeneratedColumn<String> get standardUrl => $composableBuilder(
    column: $table.standardUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get maxresUrl =>
      $composableBuilder(column: $table.maxresUrl, builder: (column) => column);

  $$PlaylistsTableAnnotationComposer get id {
    final $$PlaylistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableAnnotationComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistThumbnailsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $PlaylistThumbnailsTable,
          PlaylistThumbnail,
          $$PlaylistThumbnailsTableFilterComposer,
          $$PlaylistThumbnailsTableOrderingComposer,
          $$PlaylistThumbnailsTableAnnotationComposer,
          $$PlaylistThumbnailsTableCreateCompanionBuilder,
          $$PlaylistThumbnailsTableUpdateCompanionBuilder,
          (PlaylistThumbnail, $$PlaylistThumbnailsTableReferences),
          PlaylistThumbnail,
          PrefetchHooks Function({bool id})
        > {
  $$PlaylistThumbnailsTableTableManager(
    _$Database db,
    $PlaylistThumbnailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistThumbnailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistThumbnailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistThumbnailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> defaultUrl = const Value.absent(),
                Value<String> mediumUrl = const Value.absent(),
                Value<String> highUrl = const Value.absent(),
                Value<String?> standardUrl = const Value.absent(),
                Value<String?> maxresUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaylistThumbnailsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                defaultUrl: defaultUrl,
                mediumUrl: mediumUrl,
                highUrl: highUrl,
                standardUrl: standardUrl,
                maxresUrl: maxresUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String defaultUrl,
                required String mediumUrl,
                required String highUrl,
                Value<String?> standardUrl = const Value.absent(),
                Value<String?> maxresUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaylistThumbnailsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                defaultUrl: defaultUrl,
                mediumUrl: mediumUrl,
                highUrl: highUrl,
                standardUrl: standardUrl,
                maxresUrl: maxresUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlaylistThumbnailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$PlaylistThumbnailsTableReferences
                                        ._idTable(db),
                                referencedColumn:
                                    $$PlaylistThumbnailsTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlaylistThumbnailsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $PlaylistThumbnailsTable,
      PlaylistThumbnail,
      $$PlaylistThumbnailsTableFilterComposer,
      $$PlaylistThumbnailsTableOrderingComposer,
      $$PlaylistThumbnailsTableAnnotationComposer,
      $$PlaylistThumbnailsTableCreateCompanionBuilder,
      $$PlaylistThumbnailsTableUpdateCompanionBuilder,
      (PlaylistThumbnail, $$PlaylistThumbnailsTableReferences),
      PlaylistThumbnail,
      PrefetchHooks Function({bool id})
    >;
typedef $$PlaylistContentDetailsTableCreateCompanionBuilder =
    PlaylistContentDetailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required int itemCount,
      Value<int> rowid,
    });
typedef $$PlaylistContentDetailsTableUpdateCompanionBuilder =
    PlaylistContentDetailsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<int> itemCount,
      Value<int> rowid,
    });

final class $$PlaylistContentDetailsTableReferences
    extends
        BaseReferences<
          _$Database,
          $PlaylistContentDetailsTable,
          PlaylistContentDetail
        > {
  $$PlaylistContentDetailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlaylistsTable _idTable(_$Database db) => db.playlists.createAlias(
    $_aliasNameGenerator(db.playlistContentDetails.id, db.playlists.id),
  );

  $$PlaylistsTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$PlaylistsTableTableManager(
      $_db,
      $_db.playlists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlaylistContentDetailsTableFilterComposer
    extends Composer<_$Database, $PlaylistContentDetailsTable> {
  $$PlaylistContentDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itemCount => $composableBuilder(
    column: $table.itemCount,
    builder: (column) => ColumnFilters(column),
  );

  $$PlaylistsTableFilterComposer get id {
    final $$PlaylistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableFilterComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistContentDetailsTableOrderingComposer
    extends Composer<_$Database, $PlaylistContentDetailsTable> {
  $$PlaylistContentDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itemCount => $composableBuilder(
    column: $table.itemCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlaylistsTableOrderingComposer get id {
    final $$PlaylistsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableOrderingComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistContentDetailsTableAnnotationComposer
    extends Composer<_$Database, $PlaylistContentDetailsTable> {
  $$PlaylistContentDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get itemCount =>
      $composableBuilder(column: $table.itemCount, builder: (column) => column);

  $$PlaylistsTableAnnotationComposer get id {
    final $$PlaylistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableAnnotationComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistContentDetailsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $PlaylistContentDetailsTable,
          PlaylistContentDetail,
          $$PlaylistContentDetailsTableFilterComposer,
          $$PlaylistContentDetailsTableOrderingComposer,
          $$PlaylistContentDetailsTableAnnotationComposer,
          $$PlaylistContentDetailsTableCreateCompanionBuilder,
          $$PlaylistContentDetailsTableUpdateCompanionBuilder,
          (PlaylistContentDetail, $$PlaylistContentDetailsTableReferences),
          PlaylistContentDetail,
          PrefetchHooks Function({bool id})
        > {
  $$PlaylistContentDetailsTableTableManager(
    _$Database db,
    $PlaylistContentDetailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistContentDetailsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PlaylistContentDetailsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PlaylistContentDetailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<int> itemCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaylistContentDetailsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                itemCount: itemCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required int itemCount,
                Value<int> rowid = const Value.absent(),
              }) => PlaylistContentDetailsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                itemCount: itemCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlaylistContentDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable:
                                    $$PlaylistContentDetailsTableReferences
                                        ._idTable(db),
                                referencedColumn:
                                    $$PlaylistContentDetailsTableReferences
                                        ._idTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlaylistContentDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $PlaylistContentDetailsTable,
      PlaylistContentDetail,
      $$PlaylistContentDetailsTableFilterComposer,
      $$PlaylistContentDetailsTableOrderingComposer,
      $$PlaylistContentDetailsTableAnnotationComposer,
      $$PlaylistContentDetailsTableCreateCompanionBuilder,
      $$PlaylistContentDetailsTableUpdateCompanionBuilder,
      (PlaylistContentDetail, $$PlaylistContentDetailsTableReferences),
      PlaylistContentDetail,
      PrefetchHooks Function({bool id})
    >;
typedef $$PlaylistVsVideosTableCreateCompanionBuilder =
    PlaylistVsVideosCompanion Function({
      required String playlistId,
      required String videoId,
      required int priority,
      Value<int> rowid,
    });
typedef $$PlaylistVsVideosTableUpdateCompanionBuilder =
    PlaylistVsVideosCompanion Function({
      Value<String> playlistId,
      Value<String> videoId,
      Value<int> priority,
      Value<int> rowid,
    });

final class $$PlaylistVsVideosTableReferences
    extends
        BaseReferences<_$Database, $PlaylistVsVideosTable, PlaylistVsVideo> {
  $$PlaylistVsVideosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlaylistsTable _playlistIdTable(_$Database db) =>
      db.playlists.createAlias(
        $_aliasNameGenerator(db.playlistVsVideos.playlistId, db.playlists.id),
      );

  $$PlaylistsTableProcessedTableManager get playlistId {
    final $_column = $_itemColumn<String>('playlist_id')!;

    final manager = $$PlaylistsTableTableManager(
      $_db,
      $_db.playlists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playlistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VideosTable _videoIdTable(_$Database db) => db.videos.createAlias(
    $_aliasNameGenerator(db.playlistVsVideos.videoId, db.videos.id),
  );

  $$VideosTableProcessedTableManager get videoId {
    final $_column = $_itemColumn<String>('video_id')!;

    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_videoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlaylistVsVideosTableFilterComposer
    extends Composer<_$Database, $PlaylistVsVideosTable> {
  $$PlaylistVsVideosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  $$PlaylistsTableFilterComposer get playlistId {
    final $$PlaylistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playlistId,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableFilterComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableFilterComposer get videoId {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.videoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistVsVideosTableOrderingComposer
    extends Composer<_$Database, $PlaylistVsVideosTable> {
  $$PlaylistVsVideosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlaylistsTableOrderingComposer get playlistId {
    final $$PlaylistsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playlistId,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableOrderingComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableOrderingComposer get videoId {
    final $$VideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.videoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableOrderingComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistVsVideosTableAnnotationComposer
    extends Composer<_$Database, $PlaylistVsVideosTable> {
  $$PlaylistVsVideosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  $$PlaylistsTableAnnotationComposer get playlistId {
    final $$PlaylistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playlistId,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableAnnotationComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableAnnotationComposer get videoId {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.videoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistVsVideosTableTableManager
    extends
        RootTableManager<
          _$Database,
          $PlaylistVsVideosTable,
          PlaylistVsVideo,
          $$PlaylistVsVideosTableFilterComposer,
          $$PlaylistVsVideosTableOrderingComposer,
          $$PlaylistVsVideosTableAnnotationComposer,
          $$PlaylistVsVideosTableCreateCompanionBuilder,
          $$PlaylistVsVideosTableUpdateCompanionBuilder,
          (PlaylistVsVideo, $$PlaylistVsVideosTableReferences),
          PlaylistVsVideo,
          PrefetchHooks Function({bool playlistId, bool videoId})
        > {
  $$PlaylistVsVideosTableTableManager(
    _$Database db,
    $PlaylistVsVideosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistVsVideosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistVsVideosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistVsVideosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> playlistId = const Value.absent(),
                Value<String> videoId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaylistVsVideosCompanion(
                playlistId: playlistId,
                videoId: videoId,
                priority: priority,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String playlistId,
                required String videoId,
                required int priority,
                Value<int> rowid = const Value.absent(),
              }) => PlaylistVsVideosCompanion.insert(
                playlistId: playlistId,
                videoId: videoId,
                priority: priority,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlaylistVsVideosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({playlistId = false, videoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (playlistId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playlistId,
                                referencedTable:
                                    $$PlaylistVsVideosTableReferences
                                        ._playlistIdTable(db),
                                referencedColumn:
                                    $$PlaylistVsVideosTableReferences
                                        ._playlistIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (videoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.videoId,
                                referencedTable:
                                    $$PlaylistVsVideosTableReferences
                                        ._videoIdTable(db),
                                referencedColumn:
                                    $$PlaylistVsVideosTableReferences
                                        ._videoIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlaylistVsVideosTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $PlaylistVsVideosTable,
      PlaylistVsVideo,
      $$PlaylistVsVideosTableFilterComposer,
      $$PlaylistVsVideosTableOrderingComposer,
      $$PlaylistVsVideosTableAnnotationComposer,
      $$PlaylistVsVideosTableCreateCompanionBuilder,
      $$PlaylistVsVideosTableUpdateCompanionBuilder,
      (PlaylistVsVideo, $$PlaylistVsVideosTableReferences),
      PlaylistVsVideo,
      PrefetchHooks Function({bool playlistId, bool videoId})
    >;
typedef $$ChannelSearchesTableCreateCompanionBuilder =
    ChannelSearchesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> id,
      required String query,
    });
typedef $$ChannelSearchesTableUpdateCompanionBuilder =
    ChannelSearchesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> id,
      Value<String> query,
    });

final class $$ChannelSearchesTableReferences
    extends BaseReferences<_$Database, $ChannelSearchesTable, ChannelSearche> {
  $$ChannelSearchesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ChannelSearchVsChannelsTable,
    List<ChannelSearchVsChannel>
  >
  _channelSearchVsChannelsRefsTable(_$Database db) =>
      MultiTypedResultKey.fromTable(
        db.channelSearchVsChannels,
        aliasName: $_aliasNameGenerator(
          db.channelSearches.id,
          db.channelSearchVsChannels.searchId,
        ),
      );

  $$ChannelSearchVsChannelsTableProcessedTableManager
  get channelSearchVsChannelsRefs {
    final manager = $$ChannelSearchVsChannelsTableTableManager(
      $_db,
      $_db.channelSearchVsChannels,
    ).filter((f) => f.searchId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _channelSearchVsChannelsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChannelSearchesTableFilterComposer
    extends Composer<_$Database, $ChannelSearchesTable> {
  $$ChannelSearchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> channelSearchVsChannelsRefs(
    Expression<bool> Function($$ChannelSearchVsChannelsTableFilterComposer f) f,
  ) {
    final $$ChannelSearchVsChannelsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.channelSearchVsChannels,
          getReferencedColumn: (t) => t.searchId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChannelSearchVsChannelsTableFilterComposer(
                $db: $db,
                $table: $db.channelSearchVsChannels,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ChannelSearchesTableOrderingComposer
    extends Composer<_$Database, $ChannelSearchesTable> {
  $$ChannelSearchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChannelSearchesTableAnnotationComposer
    extends Composer<_$Database, $ChannelSearchesTable> {
  $$ChannelSearchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get query =>
      $composableBuilder(column: $table.query, builder: (column) => column);

  Expression<T> channelSearchVsChannelsRefs<T extends Object>(
    Expression<T> Function($$ChannelSearchVsChannelsTableAnnotationComposer a)
    f,
  ) {
    final $$ChannelSearchVsChannelsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.channelSearchVsChannels,
          getReferencedColumn: (t) => t.searchId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChannelSearchVsChannelsTableAnnotationComposer(
                $db: $db,
                $table: $db.channelSearchVsChannels,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ChannelSearchesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ChannelSearchesTable,
          ChannelSearche,
          $$ChannelSearchesTableFilterComposer,
          $$ChannelSearchesTableOrderingComposer,
          $$ChannelSearchesTableAnnotationComposer,
          $$ChannelSearchesTableCreateCompanionBuilder,
          $$ChannelSearchesTableUpdateCompanionBuilder,
          (ChannelSearche, $$ChannelSearchesTableReferences),
          ChannelSearche,
          PrefetchHooks Function({bool channelSearchVsChannelsRefs})
        > {
  $$ChannelSearchesTableTableManager(_$Database db, $ChannelSearchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChannelSearchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChannelSearchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChannelSearchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> query = const Value.absent(),
              }) => ChannelSearchesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                query: query,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String query,
              }) => ChannelSearchesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                query: query,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChannelSearchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({channelSearchVsChannelsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (channelSearchVsChannelsRefs) db.channelSearchVsChannels,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (channelSearchVsChannelsRefs)
                    await $_getPrefetchedData<
                      ChannelSearche,
                      $ChannelSearchesTable,
                      ChannelSearchVsChannel
                    >(
                      currentTable: table,
                      referencedTable: $$ChannelSearchesTableReferences
                          ._channelSearchVsChannelsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ChannelSearchesTableReferences(
                            db,
                            table,
                            p0,
                          ).channelSearchVsChannelsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.searchId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ChannelSearchesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ChannelSearchesTable,
      ChannelSearche,
      $$ChannelSearchesTableFilterComposer,
      $$ChannelSearchesTableOrderingComposer,
      $$ChannelSearchesTableAnnotationComposer,
      $$ChannelSearchesTableCreateCompanionBuilder,
      $$ChannelSearchesTableUpdateCompanionBuilder,
      (ChannelSearche, $$ChannelSearchesTableReferences),
      ChannelSearche,
      PrefetchHooks Function({bool channelSearchVsChannelsRefs})
    >;
typedef $$ChannelSearchVsChannelsTableCreateCompanionBuilder =
    ChannelSearchVsChannelsCompanion Function({
      required int searchId,
      required String channelId,
      required int priority,
      Value<int> rowid,
    });
typedef $$ChannelSearchVsChannelsTableUpdateCompanionBuilder =
    ChannelSearchVsChannelsCompanion Function({
      Value<int> searchId,
      Value<String> channelId,
      Value<int> priority,
      Value<int> rowid,
    });

final class $$ChannelSearchVsChannelsTableReferences
    extends
        BaseReferences<
          _$Database,
          $ChannelSearchVsChannelsTable,
          ChannelSearchVsChannel
        > {
  $$ChannelSearchVsChannelsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChannelSearchesTable _searchIdTable(_$Database db) =>
      db.channelSearches.createAlias(
        $_aliasNameGenerator(
          db.channelSearchVsChannels.searchId,
          db.channelSearches.id,
        ),
      );

  $$ChannelSearchesTableProcessedTableManager get searchId {
    final $_column = $_itemColumn<int>('search_id')!;

    final manager = $$ChannelSearchesTableTableManager(
      $_db,
      $_db.channelSearches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_searchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ChannelsTable _channelIdTable(_$Database db) =>
      db.channels.createAlias(
        $_aliasNameGenerator(
          db.channelSearchVsChannels.channelId,
          db.channels.id,
        ),
      );

  $$ChannelsTableProcessedTableManager get channelId {
    final $_column = $_itemColumn<String>('channel_id')!;

    final manager = $$ChannelsTableTableManager(
      $_db,
      $_db.channels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_channelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChannelSearchVsChannelsTableFilterComposer
    extends Composer<_$Database, $ChannelSearchVsChannelsTable> {
  $$ChannelSearchVsChannelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  $$ChannelSearchesTableFilterComposer get searchId {
    final $$ChannelSearchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.searchId,
      referencedTable: $db.channelSearches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelSearchesTableFilterComposer(
            $db: $db,
            $table: $db.channelSearches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChannelsTableFilterComposer get channelId {
    final $$ChannelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableFilterComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelSearchVsChannelsTableOrderingComposer
    extends Composer<_$Database, $ChannelSearchVsChannelsTable> {
  $$ChannelSearchVsChannelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChannelSearchesTableOrderingComposer get searchId {
    final $$ChannelSearchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.searchId,
      referencedTable: $db.channelSearches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelSearchesTableOrderingComposer(
            $db: $db,
            $table: $db.channelSearches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChannelsTableOrderingComposer get channelId {
    final $$ChannelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableOrderingComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelSearchVsChannelsTableAnnotationComposer
    extends Composer<_$Database, $ChannelSearchVsChannelsTable> {
  $$ChannelSearchVsChannelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  $$ChannelSearchesTableAnnotationComposer get searchId {
    final $$ChannelSearchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.searchId,
      referencedTable: $db.channelSearches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelSearchesTableAnnotationComposer(
            $db: $db,
            $table: $db.channelSearches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChannelsTableAnnotationComposer get channelId {
    final $$ChannelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.channels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChannelsTableAnnotationComposer(
            $db: $db,
            $table: $db.channels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChannelSearchVsChannelsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ChannelSearchVsChannelsTable,
          ChannelSearchVsChannel,
          $$ChannelSearchVsChannelsTableFilterComposer,
          $$ChannelSearchVsChannelsTableOrderingComposer,
          $$ChannelSearchVsChannelsTableAnnotationComposer,
          $$ChannelSearchVsChannelsTableCreateCompanionBuilder,
          $$ChannelSearchVsChannelsTableUpdateCompanionBuilder,
          (ChannelSearchVsChannel, $$ChannelSearchVsChannelsTableReferences),
          ChannelSearchVsChannel,
          PrefetchHooks Function({bool searchId, bool channelId})
        > {
  $$ChannelSearchVsChannelsTableTableManager(
    _$Database db,
    $ChannelSearchVsChannelsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChannelSearchVsChannelsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ChannelSearchVsChannelsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ChannelSearchVsChannelsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> searchId = const Value.absent(),
                Value<String> channelId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChannelSearchVsChannelsCompanion(
                searchId: searchId,
                channelId: channelId,
                priority: priority,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int searchId,
                required String channelId,
                required int priority,
                Value<int> rowid = const Value.absent(),
              }) => ChannelSearchVsChannelsCompanion.insert(
                searchId: searchId,
                channelId: channelId,
                priority: priority,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChannelSearchVsChannelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({searchId = false, channelId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (searchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.searchId,
                                referencedTable:
                                    $$ChannelSearchVsChannelsTableReferences
                                        ._searchIdTable(db),
                                referencedColumn:
                                    $$ChannelSearchVsChannelsTableReferences
                                        ._searchIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (channelId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.channelId,
                                referencedTable:
                                    $$ChannelSearchVsChannelsTableReferences
                                        ._channelIdTable(db),
                                referencedColumn:
                                    $$ChannelSearchVsChannelsTableReferences
                                        ._channelIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChannelSearchVsChannelsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ChannelSearchVsChannelsTable,
      ChannelSearchVsChannel,
      $$ChannelSearchVsChannelsTableFilterComposer,
      $$ChannelSearchVsChannelsTableOrderingComposer,
      $$ChannelSearchVsChannelsTableAnnotationComposer,
      $$ChannelSearchVsChannelsTableCreateCompanionBuilder,
      $$ChannelSearchVsChannelsTableUpdateCompanionBuilder,
      (ChannelSearchVsChannel, $$ChannelSearchVsChannelsTableReferences),
      ChannelSearchVsChannel,
      PrefetchHooks Function({bool searchId, bool channelId})
    >;
typedef $$VideoSearchesTableCreateCompanionBuilder =
    VideoSearchesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> id,
      required String query,
    });
typedef $$VideoSearchesTableUpdateCompanionBuilder =
    VideoSearchesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> id,
      Value<String> query,
    });

final class $$VideoSearchesTableReferences
    extends BaseReferences<_$Database, $VideoSearchesTable, VideoSearche> {
  $$VideoSearchesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $VideoSearchVsVideosTable,
    List<VideoSearchVsVideo>
  >
  _videoSearchVsVideosRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.videoSearchVsVideos,
    aliasName: $_aliasNameGenerator(
      db.videoSearches.id,
      db.videoSearchVsVideos.searchId,
    ),
  );

  $$VideoSearchVsVideosTableProcessedTableManager get videoSearchVsVideosRefs {
    final manager = $$VideoSearchVsVideosTableTableManager(
      $_db,
      $_db.videoSearchVsVideos,
    ).filter((f) => f.searchId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _videoSearchVsVideosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VideoSearchesTableFilterComposer
    extends Composer<_$Database, $VideoSearchesTable> {
  $$VideoSearchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> videoSearchVsVideosRefs(
    Expression<bool> Function($$VideoSearchVsVideosTableFilterComposer f) f,
  ) {
    final $$VideoSearchVsVideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoSearchVsVideos,
      getReferencedColumn: (t) => t.searchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoSearchVsVideosTableFilterComposer(
            $db: $db,
            $table: $db.videoSearchVsVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VideoSearchesTableOrderingComposer
    extends Composer<_$Database, $VideoSearchesTable> {
  $$VideoSearchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VideoSearchesTableAnnotationComposer
    extends Composer<_$Database, $VideoSearchesTable> {
  $$VideoSearchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get query =>
      $composableBuilder(column: $table.query, builder: (column) => column);

  Expression<T> videoSearchVsVideosRefs<T extends Object>(
    Expression<T> Function($$VideoSearchVsVideosTableAnnotationComposer a) f,
  ) {
    final $$VideoSearchVsVideosTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.videoSearchVsVideos,
          getReferencedColumn: (t) => t.searchId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VideoSearchVsVideosTableAnnotationComposer(
                $db: $db,
                $table: $db.videoSearchVsVideos,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$VideoSearchesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoSearchesTable,
          VideoSearche,
          $$VideoSearchesTableFilterComposer,
          $$VideoSearchesTableOrderingComposer,
          $$VideoSearchesTableAnnotationComposer,
          $$VideoSearchesTableCreateCompanionBuilder,
          $$VideoSearchesTableUpdateCompanionBuilder,
          (VideoSearche, $$VideoSearchesTableReferences),
          VideoSearche,
          PrefetchHooks Function({bool videoSearchVsVideosRefs})
        > {
  $$VideoSearchesTableTableManager(_$Database db, $VideoSearchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoSearchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoSearchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoSearchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> query = const Value.absent(),
              }) => VideoSearchesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                query: query,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String query,
              }) => VideoSearchesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                query: query,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VideoSearchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({videoSearchVsVideosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (videoSearchVsVideosRefs) db.videoSearchVsVideos,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (videoSearchVsVideosRefs)
                    await $_getPrefetchedData<
                      VideoSearche,
                      $VideoSearchesTable,
                      VideoSearchVsVideo
                    >(
                      currentTable: table,
                      referencedTable: $$VideoSearchesTableReferences
                          ._videoSearchVsVideosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VideoSearchesTableReferences(
                            db,
                            table,
                            p0,
                          ).videoSearchVsVideosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.searchId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VideoSearchesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoSearchesTable,
      VideoSearche,
      $$VideoSearchesTableFilterComposer,
      $$VideoSearchesTableOrderingComposer,
      $$VideoSearchesTableAnnotationComposer,
      $$VideoSearchesTableCreateCompanionBuilder,
      $$VideoSearchesTableUpdateCompanionBuilder,
      (VideoSearche, $$VideoSearchesTableReferences),
      VideoSearche,
      PrefetchHooks Function({bool videoSearchVsVideosRefs})
    >;
typedef $$VideoSearchVsVideosTableCreateCompanionBuilder =
    VideoSearchVsVideosCompanion Function({
      required int searchId,
      required String videoId,
      required int priority,
      Value<int> rowid,
    });
typedef $$VideoSearchVsVideosTableUpdateCompanionBuilder =
    VideoSearchVsVideosCompanion Function({
      Value<int> searchId,
      Value<String> videoId,
      Value<int> priority,
      Value<int> rowid,
    });

final class $$VideoSearchVsVideosTableReferences
    extends
        BaseReferences<
          _$Database,
          $VideoSearchVsVideosTable,
          VideoSearchVsVideo
        > {
  $$VideoSearchVsVideosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VideoSearchesTable _searchIdTable(_$Database db) =>
      db.videoSearches.createAlias(
        $_aliasNameGenerator(
          db.videoSearchVsVideos.searchId,
          db.videoSearches.id,
        ),
      );

  $$VideoSearchesTableProcessedTableManager get searchId {
    final $_column = $_itemColumn<int>('search_id')!;

    final manager = $$VideoSearchesTableTableManager(
      $_db,
      $_db.videoSearches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_searchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VideosTable _videoIdTable(_$Database db) => db.videos.createAlias(
    $_aliasNameGenerator(db.videoSearchVsVideos.videoId, db.videos.id),
  );

  $$VideosTableProcessedTableManager get videoId {
    final $_column = $_itemColumn<String>('video_id')!;

    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_videoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VideoSearchVsVideosTableFilterComposer
    extends Composer<_$Database, $VideoSearchVsVideosTable> {
  $$VideoSearchVsVideosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  $$VideoSearchesTableFilterComposer get searchId {
    final $$VideoSearchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.searchId,
      referencedTable: $db.videoSearches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoSearchesTableFilterComposer(
            $db: $db,
            $table: $db.videoSearches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableFilterComposer get videoId {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.videoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoSearchVsVideosTableOrderingComposer
    extends Composer<_$Database, $VideoSearchVsVideosTable> {
  $$VideoSearchVsVideosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  $$VideoSearchesTableOrderingComposer get searchId {
    final $$VideoSearchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.searchId,
      referencedTable: $db.videoSearches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoSearchesTableOrderingComposer(
            $db: $db,
            $table: $db.videoSearches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableOrderingComposer get videoId {
    final $$VideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.videoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableOrderingComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoSearchVsVideosTableAnnotationComposer
    extends Composer<_$Database, $VideoSearchVsVideosTable> {
  $$VideoSearchVsVideosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  $$VideoSearchesTableAnnotationComposer get searchId {
    final $$VideoSearchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.searchId,
      referencedTable: $db.videoSearches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoSearchesTableAnnotationComposer(
            $db: $db,
            $table: $db.videoSearches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableAnnotationComposer get videoId {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.videoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoSearchVsVideosTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoSearchVsVideosTable,
          VideoSearchVsVideo,
          $$VideoSearchVsVideosTableFilterComposer,
          $$VideoSearchVsVideosTableOrderingComposer,
          $$VideoSearchVsVideosTableAnnotationComposer,
          $$VideoSearchVsVideosTableCreateCompanionBuilder,
          $$VideoSearchVsVideosTableUpdateCompanionBuilder,
          (VideoSearchVsVideo, $$VideoSearchVsVideosTableReferences),
          VideoSearchVsVideo,
          PrefetchHooks Function({bool searchId, bool videoId})
        > {
  $$VideoSearchVsVideosTableTableManager(
    _$Database db,
    $VideoSearchVsVideosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoSearchVsVideosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoSearchVsVideosTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$VideoSearchVsVideosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> searchId = const Value.absent(),
                Value<String> videoId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoSearchVsVideosCompanion(
                searchId: searchId,
                videoId: videoId,
                priority: priority,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int searchId,
                required String videoId,
                required int priority,
                Value<int> rowid = const Value.absent(),
              }) => VideoSearchVsVideosCompanion.insert(
                searchId: searchId,
                videoId: videoId,
                priority: priority,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VideoSearchVsVideosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({searchId = false, videoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (searchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.searchId,
                                referencedTable:
                                    $$VideoSearchVsVideosTableReferences
                                        ._searchIdTable(db),
                                referencedColumn:
                                    $$VideoSearchVsVideosTableReferences
                                        ._searchIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (videoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.videoId,
                                referencedTable:
                                    $$VideoSearchVsVideosTableReferences
                                        ._videoIdTable(db),
                                referencedColumn:
                                    $$VideoSearchVsVideosTableReferences
                                        ._videoIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VideoSearchVsVideosTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoSearchVsVideosTable,
      VideoSearchVsVideo,
      $$VideoSearchVsVideosTableFilterComposer,
      $$VideoSearchVsVideosTableOrderingComposer,
      $$VideoSearchVsVideosTableAnnotationComposer,
      $$VideoSearchVsVideosTableCreateCompanionBuilder,
      $$VideoSearchVsVideosTableUpdateCompanionBuilder,
      (VideoSearchVsVideo, $$VideoSearchVsVideosTableReferences),
      VideoSearchVsVideo,
      PrefetchHooks Function({bool searchId, bool videoId})
    >;
typedef $$CollectionsTableCreateCompanionBuilder =
    CollectionsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> id,
      required bool isSystem,
      required int priority,
      required String name,
      required String description,
    });
typedef $$CollectionsTableUpdateCompanionBuilder =
    CollectionsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> id,
      Value<bool> isSystem,
      Value<int> priority,
      Value<String> name,
      Value<String> description,
    });

final class $$CollectionsTableReferences
    extends BaseReferences<_$Database, $CollectionsTable, Collection> {
  $$CollectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SeriesTable, List<Sery>> _seriesRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.series,
    aliasName: $_aliasNameGenerator(db.collections.id, db.series.collectionId),
  );

  $$SeriesTableProcessedTableManager get seriesRefs {
    final manager = $$SeriesTableTableManager(
      $_db,
      $_db.series,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_seriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CollectionsTableFilterComposer
    extends Composer<_$Database, $CollectionsTable> {
  $$CollectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> seriesRefs(
    Expression<bool> Function($$SeriesTableFilterComposer f) f,
  ) {
    final $$SeriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableFilterComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CollectionsTableOrderingComposer
    extends Composer<_$Database, $CollectionsTable> {
  $$CollectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CollectionsTableAnnotationComposer
    extends Composer<_$Database, $CollectionsTable> {
  $$CollectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> seriesRefs<T extends Object>(
    Expression<T> Function($$SeriesTableAnnotationComposer a) f,
  ) {
    final $$SeriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableAnnotationComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CollectionsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $CollectionsTable,
          Collection,
          $$CollectionsTableFilterComposer,
          $$CollectionsTableOrderingComposer,
          $$CollectionsTableAnnotationComposer,
          $$CollectionsTableCreateCompanionBuilder,
          $$CollectionsTableUpdateCompanionBuilder,
          (Collection, $$CollectionsTableReferences),
          Collection,
          PrefetchHooks Function({bool seriesRefs})
        > {
  $$CollectionsTableTableManager(_$Database db, $CollectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
              }) => CollectionsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                isSystem: isSystem,
                priority: priority,
                name: name,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                required bool isSystem,
                required int priority,
                required String name,
                required String description,
              }) => CollectionsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                isSystem: isSystem,
                priority: priority,
                name: name,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({seriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (seriesRefs) db.series],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (seriesRefs)
                    await $_getPrefetchedData<
                      Collection,
                      $CollectionsTable,
                      Sery
                    >(
                      currentTable: table,
                      referencedTable: $$CollectionsTableReferences
                          ._seriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CollectionsTableReferences(
                            db,
                            table,
                            p0,
                          ).seriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.collectionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CollectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $CollectionsTable,
      Collection,
      $$CollectionsTableFilterComposer,
      $$CollectionsTableOrderingComposer,
      $$CollectionsTableAnnotationComposer,
      $$CollectionsTableCreateCompanionBuilder,
      $$CollectionsTableUpdateCompanionBuilder,
      (Collection, $$CollectionsTableReferences),
      Collection,
      PrefetchHooks Function({bool seriesRefs})
    >;
typedef $$SeriesTableCreateCompanionBuilder =
    SeriesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> id,
      required int collectionId,
      required String coverVideoId,
      required String name,
      required String description,
      required int priority,
    });
typedef $$SeriesTableUpdateCompanionBuilder =
    SeriesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> id,
      Value<int> collectionId,
      Value<String> coverVideoId,
      Value<String> name,
      Value<String> description,
      Value<int> priority,
    });

final class $$SeriesTableReferences
    extends BaseReferences<_$Database, $SeriesTable, Sery> {
  $$SeriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CollectionsTable _collectionIdTable(_$Database db) =>
      db.collections.createAlias(
        $_aliasNameGenerator(db.series.collectionId, db.collections.id),
      );

  $$CollectionsTableProcessedTableManager get collectionId {
    final $_column = $_itemColumn<int>('collection_id')!;

    final manager = $$CollectionsTableTableManager(
      $_db,
      $_db.collections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VideosTable _coverVideoIdTable(_$Database db) => db.videos
      .createAlias($_aliasNameGenerator(db.series.coverVideoId, db.videos.id));

  $$VideosTableProcessedTableManager get coverVideoId {
    final $_column = $_itemColumn<String>('cover_video_id')!;

    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coverVideoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SeriesVsVideosTable, List<SeriesVsVideo>>
  _seriesVsVideosRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.seriesVsVideos,
    aliasName: $_aliasNameGenerator(db.series.id, db.seriesVsVideos.seriesId),
  );

  $$SeriesVsVideosTableProcessedTableManager get seriesVsVideosRefs {
    final manager = $$SeriesVsVideosTableTableManager(
      $_db,
      $_db.seriesVsVideos,
    ).filter((f) => f.seriesId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_seriesVsVideosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SeriesTableFilterComposer extends Composer<_$Database, $SeriesTable> {
  $$SeriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  $$CollectionsTableFilterComposer get collectionId {
    final $$CollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableFilterComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableFilterComposer get coverVideoId {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coverVideoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> seriesVsVideosRefs(
    Expression<bool> Function($$SeriesVsVideosTableFilterComposer f) f,
  ) {
    final $$SeriesVsVideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seriesVsVideos,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesVsVideosTableFilterComposer(
            $db: $db,
            $table: $db.seriesVsVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SeriesTableOrderingComposer extends Composer<_$Database, $SeriesTable> {
  $$SeriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  $$CollectionsTableOrderingComposer get collectionId {
    final $$CollectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableOrderingComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableOrderingComposer get coverVideoId {
    final $$VideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coverVideoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableOrderingComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeriesTableAnnotationComposer
    extends Composer<_$Database, $SeriesTable> {
  $$SeriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  $$CollectionsTableAnnotationComposer get collectionId {
    final $$CollectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableAnnotationComposer get coverVideoId {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coverVideoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> seriesVsVideosRefs<T extends Object>(
    Expression<T> Function($$SeriesVsVideosTableAnnotationComposer a) f,
  ) {
    final $$SeriesVsVideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seriesVsVideos,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesVsVideosTableAnnotationComposer(
            $db: $db,
            $table: $db.seriesVsVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SeriesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $SeriesTable,
          Sery,
          $$SeriesTableFilterComposer,
          $$SeriesTableOrderingComposer,
          $$SeriesTableAnnotationComposer,
          $$SeriesTableCreateCompanionBuilder,
          $$SeriesTableUpdateCompanionBuilder,
          (Sery, $$SeriesTableReferences),
          Sery,
          PrefetchHooks Function({
            bool collectionId,
            bool coverVideoId,
            bool seriesVsVideosRefs,
          })
        > {
  $$SeriesTableTableManager(_$Database db, $SeriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int> collectionId = const Value.absent(),
                Value<String> coverVideoId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> priority = const Value.absent(),
              }) => SeriesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                collectionId: collectionId,
                coverVideoId: coverVideoId,
                name: name,
                description: description,
                priority: priority,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                required int collectionId,
                required String coverVideoId,
                required String name,
                required String description,
                required int priority,
              }) => SeriesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                collectionId: collectionId,
                coverVideoId: coverVideoId,
                name: name,
                description: description,
                priority: priority,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SeriesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                collectionId = false,
                coverVideoId = false,
                seriesVsVideosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (seriesVsVideosRefs) db.seriesVsVideos,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (collectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.collectionId,
                                    referencedTable: $$SeriesTableReferences
                                        ._collectionIdTable(db),
                                    referencedColumn: $$SeriesTableReferences
                                        ._collectionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (coverVideoId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.coverVideoId,
                                    referencedTable: $$SeriesTableReferences
                                        ._coverVideoIdTable(db),
                                    referencedColumn: $$SeriesTableReferences
                                        ._coverVideoIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (seriesVsVideosRefs)
                        await $_getPrefetchedData<
                          Sery,
                          $SeriesTable,
                          SeriesVsVideo
                        >(
                          currentTable: table,
                          referencedTable: $$SeriesTableReferences
                              ._seriesVsVideosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SeriesTableReferences(
                                db,
                                table,
                                p0,
                              ).seriesVsVideosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.seriesId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SeriesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $SeriesTable,
      Sery,
      $$SeriesTableFilterComposer,
      $$SeriesTableOrderingComposer,
      $$SeriesTableAnnotationComposer,
      $$SeriesTableCreateCompanionBuilder,
      $$SeriesTableUpdateCompanionBuilder,
      (Sery, $$SeriesTableReferences),
      Sery,
      PrefetchHooks Function({
        bool collectionId,
        bool coverVideoId,
        bool seriesVsVideosRefs,
      })
    >;
typedef $$SeriesVsVideosTableCreateCompanionBuilder =
    SeriesVsVideosCompanion Function({
      required int seriesId,
      required String videoId,
      required int priority,
      Value<int> rowid,
    });
typedef $$SeriesVsVideosTableUpdateCompanionBuilder =
    SeriesVsVideosCompanion Function({
      Value<int> seriesId,
      Value<String> videoId,
      Value<int> priority,
      Value<int> rowid,
    });

final class $$SeriesVsVideosTableReferences
    extends BaseReferences<_$Database, $SeriesVsVideosTable, SeriesVsVideo> {
  $$SeriesVsVideosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SeriesTable _seriesIdTable(_$Database db) => db.series.createAlias(
    $_aliasNameGenerator(db.seriesVsVideos.seriesId, db.series.id),
  );

  $$SeriesTableProcessedTableManager get seriesId {
    final $_column = $_itemColumn<int>('series_id')!;

    final manager = $$SeriesTableTableManager(
      $_db,
      $_db.series,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_seriesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VideosTable _videoIdTable(_$Database db) => db.videos.createAlias(
    $_aliasNameGenerator(db.seriesVsVideos.videoId, db.videos.id),
  );

  $$VideosTableProcessedTableManager get videoId {
    final $_column = $_itemColumn<String>('video_id')!;

    final manager = $$VideosTableTableManager(
      $_db,
      $_db.videos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_videoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SeriesVsVideosTableFilterComposer
    extends Composer<_$Database, $SeriesVsVideosTable> {
  $$SeriesVsVideosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  $$SeriesTableFilterComposer get seriesId {
    final $$SeriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableFilterComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableFilterComposer get videoId {
    final $$VideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.videoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableFilterComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeriesVsVideosTableOrderingComposer
    extends Composer<_$Database, $SeriesVsVideosTable> {
  $$SeriesVsVideosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  $$SeriesTableOrderingComposer get seriesId {
    final $$SeriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableOrderingComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableOrderingComposer get videoId {
    final $$VideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.videoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableOrderingComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeriesVsVideosTableAnnotationComposer
    extends Composer<_$Database, $SeriesVsVideosTable> {
  $$SeriesVsVideosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  $$SeriesTableAnnotationComposer get seriesId {
    final $$SeriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableAnnotationComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VideosTableAnnotationComposer get videoId {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.videoId,
      referencedTable: $db.videos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideosTableAnnotationComposer(
            $db: $db,
            $table: $db.videos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeriesVsVideosTableTableManager
    extends
        RootTableManager<
          _$Database,
          $SeriesVsVideosTable,
          SeriesVsVideo,
          $$SeriesVsVideosTableFilterComposer,
          $$SeriesVsVideosTableOrderingComposer,
          $$SeriesVsVideosTableAnnotationComposer,
          $$SeriesVsVideosTableCreateCompanionBuilder,
          $$SeriesVsVideosTableUpdateCompanionBuilder,
          (SeriesVsVideo, $$SeriesVsVideosTableReferences),
          SeriesVsVideo,
          PrefetchHooks Function({bool seriesId, bool videoId})
        > {
  $$SeriesVsVideosTableTableManager(_$Database db, $SeriesVsVideosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeriesVsVideosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeriesVsVideosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeriesVsVideosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> seriesId = const Value.absent(),
                Value<String> videoId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SeriesVsVideosCompanion(
                seriesId: seriesId,
                videoId: videoId,
                priority: priority,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int seriesId,
                required String videoId,
                required int priority,
                Value<int> rowid = const Value.absent(),
              }) => SeriesVsVideosCompanion.insert(
                seriesId: seriesId,
                videoId: videoId,
                priority: priority,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SeriesVsVideosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({seriesId = false, videoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (seriesId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.seriesId,
                                referencedTable: $$SeriesVsVideosTableReferences
                                    ._seriesIdTable(db),
                                referencedColumn:
                                    $$SeriesVsVideosTableReferences
                                        ._seriesIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (videoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.videoId,
                                referencedTable: $$SeriesVsVideosTableReferences
                                    ._videoIdTable(db),
                                referencedColumn:
                                    $$SeriesVsVideosTableReferences
                                        ._videoIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SeriesVsVideosTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $SeriesVsVideosTable,
      SeriesVsVideo,
      $$SeriesVsVideosTableFilterComposer,
      $$SeriesVsVideosTableOrderingComposer,
      $$SeriesVsVideosTableAnnotationComposer,
      $$SeriesVsVideosTableCreateCompanionBuilder,
      $$SeriesVsVideosTableUpdateCompanionBuilder,
      (SeriesVsVideo, $$SeriesVsVideosTableReferences),
      SeriesVsVideo,
      PrefetchHooks Function({bool seriesId, bool videoId})
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$ChannelsTableTableManager get channels =>
      $$ChannelsTableTableManager(_db, _db.channels);
  $$ChannelSnippetsTableTableManager get channelSnippets =>
      $$ChannelSnippetsTableTableManager(_db, _db.channelSnippets);
  $$ChannelThumbnailsTableTableManager get channelThumbnails =>
      $$ChannelThumbnailsTableTableManager(_db, _db.channelThumbnails);
  $$ChannelContentDetailsTableTableManager get channelContentDetails =>
      $$ChannelContentDetailsTableTableManager(_db, _db.channelContentDetails);
  $$ChannelStatisticsTableTableManager get channelStatistics =>
      $$ChannelStatisticsTableTableManager(_db, _db.channelStatistics);
  $$ChannelStatusesTableTableManager get channelStatuses =>
      $$ChannelStatusesTableTableManager(_db, _db.channelStatuses);
  $$VideosTableTableManager get videos =>
      $$VideosTableTableManager(_db, _db.videos);
  $$VideoSnippetsTableTableManager get videoSnippets =>
      $$VideoSnippetsTableTableManager(_db, _db.videoSnippets);
  $$VideoThumbnailsTableTableManager get videoThumbnails =>
      $$VideoThumbnailsTableTableManager(_db, _db.videoThumbnails);
  $$VideoContentDetailsTableTableManager get videoContentDetails =>
      $$VideoContentDetailsTableTableManager(_db, _db.videoContentDetails);
  $$VideoStatusesTableTableManager get videoStatuses =>
      $$VideoStatusesTableTableManager(_db, _db.videoStatuses);
  $$VideoStatisticsTableTableManager get videoStatistics =>
      $$VideoStatisticsTableTableManager(_db, _db.videoStatistics);
  $$VideoProgressTableTableManager get videoProgress =>
      $$VideoProgressTableTableManager(_db, _db.videoProgress);
  $$PlaylistsTableTableManager get playlists =>
      $$PlaylistsTableTableManager(_db, _db.playlists);
  $$PlaylistSnippetsTableTableManager get playlistSnippets =>
      $$PlaylistSnippetsTableTableManager(_db, _db.playlistSnippets);
  $$PlaylistThumbnailsTableTableManager get playlistThumbnails =>
      $$PlaylistThumbnailsTableTableManager(_db, _db.playlistThumbnails);
  $$PlaylistContentDetailsTableTableManager get playlistContentDetails =>
      $$PlaylistContentDetailsTableTableManager(
        _db,
        _db.playlistContentDetails,
      );
  $$PlaylistVsVideosTableTableManager get playlistVsVideos =>
      $$PlaylistVsVideosTableTableManager(_db, _db.playlistVsVideos);
  $$ChannelSearchesTableTableManager get channelSearches =>
      $$ChannelSearchesTableTableManager(_db, _db.channelSearches);
  $$ChannelSearchVsChannelsTableTableManager get channelSearchVsChannels =>
      $$ChannelSearchVsChannelsTableTableManager(
        _db,
        _db.channelSearchVsChannels,
      );
  $$VideoSearchesTableTableManager get videoSearches =>
      $$VideoSearchesTableTableManager(_db, _db.videoSearches);
  $$VideoSearchVsVideosTableTableManager get videoSearchVsVideos =>
      $$VideoSearchVsVideosTableTableManager(_db, _db.videoSearchVsVideos);
  $$CollectionsTableTableManager get collections =>
      $$CollectionsTableTableManager(_db, _db.collections);
  $$SeriesTableTableManager get series =>
      $$SeriesTableTableManager(_db, _db.series);
  $$SeriesVsVideosTableTableManager get seriesVsVideos =>
      $$SeriesVsVideosTableTableManager(_db, _db.seriesVsVideos);
}
