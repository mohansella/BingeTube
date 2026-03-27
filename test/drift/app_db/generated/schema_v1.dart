// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class Channels extends Table with TableInfo<Channels, ChannelsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Channels(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<String> setag = GeneratedColumn<String>(
    'setag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [createdAt, updatedAt, id, etag, setag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channels';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelsData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
  Channels createAlias(String alias) {
    return Channels(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ChannelsData extends DataClass implements Insertable<ChannelsData> {
  final int createdAt;
  final int updatedAt;
  final String id;
  final String? etag;
  final String? setag;
  const ChannelsData({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.etag,
    this.setag,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
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

  factory ChannelsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelsData(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      etag: serializer.fromJson<String?>(json['etag']),
      setag: serializer.fromJson<String?>(json['setag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'id': serializer.toJson<String>(id),
      'etag': serializer.toJson<String?>(etag),
      'setag': serializer.toJson<String?>(setag),
    };
  }

  ChannelsData copyWith({
    int? createdAt,
    int? updatedAt,
    String? id,
    Value<String?> etag = const Value.absent(),
    Value<String?> setag = const Value.absent(),
  }) => ChannelsData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    etag: etag.present ? etag.value : this.etag,
    setag: setag.present ? setag.value : this.setag,
  );
  ChannelsData copyWithCompanion(ChannelsCompanion data) {
    return ChannelsData(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      etag: data.etag.present ? data.etag.value : this.etag,
      setag: data.setag.present ? data.setag.value : this.setag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelsData(')
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
      (other is ChannelsData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.etag == this.etag &&
          other.setag == this.setag);
}

class ChannelsCompanion extends UpdateCompanion<ChannelsData> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
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
  static Insertable<ChannelsData> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
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
    Value<int>? createdAt,
    Value<int>? updatedAt,
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
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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

class ChannelSnippets extends Table
    with TableInfo<ChannelSnippets, ChannelSnippetsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChannelSnippets(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES channels(id)',
  );
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_snippets';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelSnippetsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelSnippetsData(
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
  ChannelSnippets createAlias(String alias) {
    return ChannelSnippets(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ChannelSnippetsData extends DataClass
    implements Insertable<ChannelSnippetsData> {
  final String id;
  final String title;
  final String description;
  const ChannelSnippetsData({
    required this.id,
    required this.title,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    return map;
  }

  ChannelSnippetsCompanion toCompanion(bool nullToAbsent) {
    return ChannelSnippetsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
    );
  }

  factory ChannelSnippetsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelSnippetsData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
    };
  }

  ChannelSnippetsData copyWith({
    String? id,
    String? title,
    String? description,
  }) => ChannelSnippetsData(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
  );
  ChannelSnippetsData copyWithCompanion(ChannelSnippetsCompanion data) {
    return ChannelSnippetsData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelSnippetsData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelSnippetsData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description);
}

class ChannelSnippetsCompanion extends UpdateCompanion<ChannelSnippetsData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<int> rowid;
  const ChannelSnippetsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelSnippetsCompanion.insert({
    required String id,
    required String title,
    required String description,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description);
  static Insertable<ChannelSnippetsData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelSnippetsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return ChannelSnippetsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
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
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ChannelThumbnails extends Table
    with TableInfo<ChannelThumbnails, ChannelThumbnailsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChannelThumbnails(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES channels(id)',
  );
  late final GeneratedColumn<String> defaultUrl = GeneratedColumn<String>(
    'default_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> mediumUrl = GeneratedColumn<String>(
    'medium_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> highUrl = GeneratedColumn<String>(
    'high_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, defaultUrl, mediumUrl, highUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_thumbnails';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelThumbnailsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelThumbnailsData(
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
  ChannelThumbnails createAlias(String alias) {
    return ChannelThumbnails(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ChannelThumbnailsData extends DataClass
    implements Insertable<ChannelThumbnailsData> {
  final String id;
  final String defaultUrl;
  final String mediumUrl;
  final String highUrl;
  const ChannelThumbnailsData({
    required this.id,
    required this.defaultUrl,
    required this.mediumUrl,
    required this.highUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['default_url'] = Variable<String>(defaultUrl);
    map['medium_url'] = Variable<String>(mediumUrl);
    map['high_url'] = Variable<String>(highUrl);
    return map;
  }

  ChannelThumbnailsCompanion toCompanion(bool nullToAbsent) {
    return ChannelThumbnailsCompanion(
      id: Value(id),
      defaultUrl: Value(defaultUrl),
      mediumUrl: Value(mediumUrl),
      highUrl: Value(highUrl),
    );
  }

  factory ChannelThumbnailsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelThumbnailsData(
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
      'id': serializer.toJson<String>(id),
      'defaultUrl': serializer.toJson<String>(defaultUrl),
      'mediumUrl': serializer.toJson<String>(mediumUrl),
      'highUrl': serializer.toJson<String>(highUrl),
    };
  }

  ChannelThumbnailsData copyWith({
    String? id,
    String? defaultUrl,
    String? mediumUrl,
    String? highUrl,
  }) => ChannelThumbnailsData(
    id: id ?? this.id,
    defaultUrl: defaultUrl ?? this.defaultUrl,
    mediumUrl: mediumUrl ?? this.mediumUrl,
    highUrl: highUrl ?? this.highUrl,
  );
  ChannelThumbnailsData copyWithCompanion(ChannelThumbnailsCompanion data) {
    return ChannelThumbnailsData(
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
    return (StringBuffer('ChannelThumbnailsData(')
          ..write('id: $id, ')
          ..write('defaultUrl: $defaultUrl, ')
          ..write('mediumUrl: $mediumUrl, ')
          ..write('highUrl: $highUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, defaultUrl, mediumUrl, highUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelThumbnailsData &&
          other.id == this.id &&
          other.defaultUrl == this.defaultUrl &&
          other.mediumUrl == this.mediumUrl &&
          other.highUrl == this.highUrl);
}

class ChannelThumbnailsCompanion
    extends UpdateCompanion<ChannelThumbnailsData> {
  final Value<String> id;
  final Value<String> defaultUrl;
  final Value<String> mediumUrl;
  final Value<String> highUrl;
  final Value<int> rowid;
  const ChannelThumbnailsCompanion({
    this.id = const Value.absent(),
    this.defaultUrl = const Value.absent(),
    this.mediumUrl = const Value.absent(),
    this.highUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelThumbnailsCompanion.insert({
    required String id,
    required String defaultUrl,
    required String mediumUrl,
    required String highUrl,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       defaultUrl = Value(defaultUrl),
       mediumUrl = Value(mediumUrl),
       highUrl = Value(highUrl);
  static Insertable<ChannelThumbnailsData> custom({
    Expression<String>? id,
    Expression<String>? defaultUrl,
    Expression<String>? mediumUrl,
    Expression<String>? highUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (defaultUrl != null) 'default_url': defaultUrl,
      if (mediumUrl != null) 'medium_url': mediumUrl,
      if (highUrl != null) 'high_url': highUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelThumbnailsCompanion copyWith({
    Value<String>? id,
    Value<String>? defaultUrl,
    Value<String>? mediumUrl,
    Value<String>? highUrl,
    Value<int>? rowid,
  }) {
    return ChannelThumbnailsCompanion(
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
          ..write('id: $id, ')
          ..write('defaultUrl: $defaultUrl, ')
          ..write('mediumUrl: $mediumUrl, ')
          ..write('highUrl: $highUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ChannelContentDetails extends Table
    with TableInfo<ChannelContentDetails, ChannelContentDetailsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChannelContentDetails(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES channels(id)',
  );
  late final GeneratedColumn<String> likesPlaylist = GeneratedColumn<String>(
    'likes_playlist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<String> uploadPlaylist = GeneratedColumn<String>(
    'upload_playlist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, likesPlaylist, uploadPlaylist];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_content_details';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelContentDetailsData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelContentDetailsData(
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
  ChannelContentDetails createAlias(String alias) {
    return ChannelContentDetails(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ChannelContentDetailsData extends DataClass
    implements Insertable<ChannelContentDetailsData> {
  final String id;
  final String? likesPlaylist;
  final String? uploadPlaylist;
  const ChannelContentDetailsData({
    required this.id,
    this.likesPlaylist,
    this.uploadPlaylist,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
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
      id: Value(id),
      likesPlaylist: likesPlaylist == null && nullToAbsent
          ? const Value.absent()
          : Value(likesPlaylist),
      uploadPlaylist: uploadPlaylist == null && nullToAbsent
          ? const Value.absent()
          : Value(uploadPlaylist),
    );
  }

  factory ChannelContentDetailsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelContentDetailsData(
      id: serializer.fromJson<String>(json['id']),
      likesPlaylist: serializer.fromJson<String?>(json['likesPlaylist']),
      uploadPlaylist: serializer.fromJson<String?>(json['uploadPlaylist']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'likesPlaylist': serializer.toJson<String?>(likesPlaylist),
      'uploadPlaylist': serializer.toJson<String?>(uploadPlaylist),
    };
  }

  ChannelContentDetailsData copyWith({
    String? id,
    Value<String?> likesPlaylist = const Value.absent(),
    Value<String?> uploadPlaylist = const Value.absent(),
  }) => ChannelContentDetailsData(
    id: id ?? this.id,
    likesPlaylist: likesPlaylist.present
        ? likesPlaylist.value
        : this.likesPlaylist,
    uploadPlaylist: uploadPlaylist.present
        ? uploadPlaylist.value
        : this.uploadPlaylist,
  );
  ChannelContentDetailsData copyWithCompanion(
    ChannelContentDetailsCompanion data,
  ) {
    return ChannelContentDetailsData(
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
    return (StringBuffer('ChannelContentDetailsData(')
          ..write('id: $id, ')
          ..write('likesPlaylist: $likesPlaylist, ')
          ..write('uploadPlaylist: $uploadPlaylist')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, likesPlaylist, uploadPlaylist);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelContentDetailsData &&
          other.id == this.id &&
          other.likesPlaylist == this.likesPlaylist &&
          other.uploadPlaylist == this.uploadPlaylist);
}

class ChannelContentDetailsCompanion
    extends UpdateCompanion<ChannelContentDetailsData> {
  final Value<String> id;
  final Value<String?> likesPlaylist;
  final Value<String?> uploadPlaylist;
  final Value<int> rowid;
  const ChannelContentDetailsCompanion({
    this.id = const Value.absent(),
    this.likesPlaylist = const Value.absent(),
    this.uploadPlaylist = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelContentDetailsCompanion.insert({
    required String id,
    this.likesPlaylist = const Value.absent(),
    this.uploadPlaylist = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<ChannelContentDetailsData> custom({
    Expression<String>? id,
    Expression<String>? likesPlaylist,
    Expression<String>? uploadPlaylist,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (likesPlaylist != null) 'likes_playlist': likesPlaylist,
      if (uploadPlaylist != null) 'upload_playlist': uploadPlaylist,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelContentDetailsCompanion copyWith({
    Value<String>? id,
    Value<String?>? likesPlaylist,
    Value<String?>? uploadPlaylist,
    Value<int>? rowid,
  }) {
    return ChannelContentDetailsCompanion(
      id: id ?? this.id,
      likesPlaylist: likesPlaylist ?? this.likesPlaylist,
      uploadPlaylist: uploadPlaylist ?? this.uploadPlaylist,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
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
          ..write('id: $id, ')
          ..write('likesPlaylist: $likesPlaylist, ')
          ..write('uploadPlaylist: $uploadPlaylist, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ChannelStatistics extends Table
    with TableInfo<ChannelStatistics, ChannelStatisticsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChannelStatistics(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES channels(id)',
  );
  late final GeneratedColumn<int> viewCount = GeneratedColumn<int>(
    'view_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> subscriberCount = GeneratedColumn<int>(
    'subscriber_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> hiddenSubscriberCount = GeneratedColumn<int>(
    'hidden_subscriber_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (hidden_subscriber_count IN (0, 1))',
  );
  late final GeneratedColumn<int> videoCount = GeneratedColumn<int>(
    'video_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelStatisticsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelStatisticsData(
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
        DriftSqlType.int,
        data['${effectivePrefix}hidden_subscriber_count'],
      )!,
      videoCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}video_count'],
      )!,
    );
  }

  @override
  ChannelStatistics createAlias(String alias) {
    return ChannelStatistics(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ChannelStatisticsData extends DataClass
    implements Insertable<ChannelStatisticsData> {
  final String id;
  final int viewCount;
  final int subscriberCount;
  final int hiddenSubscriberCount;
  final int videoCount;
  const ChannelStatisticsData({
    required this.id,
    required this.viewCount,
    required this.subscriberCount,
    required this.hiddenSubscriberCount,
    required this.videoCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['view_count'] = Variable<int>(viewCount);
    map['subscriber_count'] = Variable<int>(subscriberCount);
    map['hidden_subscriber_count'] = Variable<int>(hiddenSubscriberCount);
    map['video_count'] = Variable<int>(videoCount);
    return map;
  }

  ChannelStatisticsCompanion toCompanion(bool nullToAbsent) {
    return ChannelStatisticsCompanion(
      id: Value(id),
      viewCount: Value(viewCount),
      subscriberCount: Value(subscriberCount),
      hiddenSubscriberCount: Value(hiddenSubscriberCount),
      videoCount: Value(videoCount),
    );
  }

  factory ChannelStatisticsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelStatisticsData(
      id: serializer.fromJson<String>(json['id']),
      viewCount: serializer.fromJson<int>(json['viewCount']),
      subscriberCount: serializer.fromJson<int>(json['subscriberCount']),
      hiddenSubscriberCount: serializer.fromJson<int>(
        json['hiddenSubscriberCount'],
      ),
      videoCount: serializer.fromJson<int>(json['videoCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'viewCount': serializer.toJson<int>(viewCount),
      'subscriberCount': serializer.toJson<int>(subscriberCount),
      'hiddenSubscriberCount': serializer.toJson<int>(hiddenSubscriberCount),
      'videoCount': serializer.toJson<int>(videoCount),
    };
  }

  ChannelStatisticsData copyWith({
    String? id,
    int? viewCount,
    int? subscriberCount,
    int? hiddenSubscriberCount,
    int? videoCount,
  }) => ChannelStatisticsData(
    id: id ?? this.id,
    viewCount: viewCount ?? this.viewCount,
    subscriberCount: subscriberCount ?? this.subscriberCount,
    hiddenSubscriberCount: hiddenSubscriberCount ?? this.hiddenSubscriberCount,
    videoCount: videoCount ?? this.videoCount,
  );
  ChannelStatisticsData copyWithCompanion(ChannelStatisticsCompanion data) {
    return ChannelStatisticsData(
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
    return (StringBuffer('ChannelStatisticsData(')
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
    id,
    viewCount,
    subscriberCount,
    hiddenSubscriberCount,
    videoCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelStatisticsData &&
          other.id == this.id &&
          other.viewCount == this.viewCount &&
          other.subscriberCount == this.subscriberCount &&
          other.hiddenSubscriberCount == this.hiddenSubscriberCount &&
          other.videoCount == this.videoCount);
}

class ChannelStatisticsCompanion
    extends UpdateCompanion<ChannelStatisticsData> {
  final Value<String> id;
  final Value<int> viewCount;
  final Value<int> subscriberCount;
  final Value<int> hiddenSubscriberCount;
  final Value<int> videoCount;
  final Value<int> rowid;
  const ChannelStatisticsCompanion({
    this.id = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.subscriberCount = const Value.absent(),
    this.hiddenSubscriberCount = const Value.absent(),
    this.videoCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelStatisticsCompanion.insert({
    required String id,
    required int viewCount,
    required int subscriberCount,
    required int hiddenSubscriberCount,
    required int videoCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       viewCount = Value(viewCount),
       subscriberCount = Value(subscriberCount),
       hiddenSubscriberCount = Value(hiddenSubscriberCount),
       videoCount = Value(videoCount);
  static Insertable<ChannelStatisticsData> custom({
    Expression<String>? id,
    Expression<int>? viewCount,
    Expression<int>? subscriberCount,
    Expression<int>? hiddenSubscriberCount,
    Expression<int>? videoCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
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
    Value<String>? id,
    Value<int>? viewCount,
    Value<int>? subscriberCount,
    Value<int>? hiddenSubscriberCount,
    Value<int>? videoCount,
    Value<int>? rowid,
  }) {
    return ChannelStatisticsCompanion(
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
      map['hidden_subscriber_count'] = Variable<int>(
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

class ChannelStatuses extends Table
    with TableInfo<ChannelStatuses, ChannelStatusesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChannelStatuses(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES channels(id)',
  );
  late final GeneratedColumn<String> privacyStatus = GeneratedColumn<String>(
    'privacy_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> isLinked = GeneratedColumn<int>(
    'is_linked',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (is_linked IN (0, 1))',
  );
  late final GeneratedColumn<String> longUploadsStatus =
      GeneratedColumn<String>(
        'long_uploads_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  late final GeneratedColumn<int> madeForKids = GeneratedColumn<int>(
    'made_for_kids',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NULL CHECK (made_for_kids IN (0, 1))',
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelStatusesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelStatusesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      privacyStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}privacy_status'],
      )!,
      isLinked: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_linked'],
      )!,
      longUploadsStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}long_uploads_status'],
      )!,
      madeForKids: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}made_for_kids'],
      ),
    );
  }

  @override
  ChannelStatuses createAlias(String alias) {
    return ChannelStatuses(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class ChannelStatusesData extends DataClass
    implements Insertable<ChannelStatusesData> {
  final String id;
  final String privacyStatus;
  final int isLinked;
  final String longUploadsStatus;
  final int? madeForKids;
  const ChannelStatusesData({
    required this.id,
    required this.privacyStatus,
    required this.isLinked,
    required this.longUploadsStatus,
    this.madeForKids,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['privacy_status'] = Variable<String>(privacyStatus);
    map['is_linked'] = Variable<int>(isLinked);
    map['long_uploads_status'] = Variable<String>(longUploadsStatus);
    if (!nullToAbsent || madeForKids != null) {
      map['made_for_kids'] = Variable<int>(madeForKids);
    }
    return map;
  }

  ChannelStatusesCompanion toCompanion(bool nullToAbsent) {
    return ChannelStatusesCompanion(
      id: Value(id),
      privacyStatus: Value(privacyStatus),
      isLinked: Value(isLinked),
      longUploadsStatus: Value(longUploadsStatus),
      madeForKids: madeForKids == null && nullToAbsent
          ? const Value.absent()
          : Value(madeForKids),
    );
  }

  factory ChannelStatusesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelStatusesData(
      id: serializer.fromJson<String>(json['id']),
      privacyStatus: serializer.fromJson<String>(json['privacyStatus']),
      isLinked: serializer.fromJson<int>(json['isLinked']),
      longUploadsStatus: serializer.fromJson<String>(json['longUploadsStatus']),
      madeForKids: serializer.fromJson<int?>(json['madeForKids']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'privacyStatus': serializer.toJson<String>(privacyStatus),
      'isLinked': serializer.toJson<int>(isLinked),
      'longUploadsStatus': serializer.toJson<String>(longUploadsStatus),
      'madeForKids': serializer.toJson<int?>(madeForKids),
    };
  }

  ChannelStatusesData copyWith({
    String? id,
    String? privacyStatus,
    int? isLinked,
    String? longUploadsStatus,
    Value<int?> madeForKids = const Value.absent(),
  }) => ChannelStatusesData(
    id: id ?? this.id,
    privacyStatus: privacyStatus ?? this.privacyStatus,
    isLinked: isLinked ?? this.isLinked,
    longUploadsStatus: longUploadsStatus ?? this.longUploadsStatus,
    madeForKids: madeForKids.present ? madeForKids.value : this.madeForKids,
  );
  ChannelStatusesData copyWithCompanion(ChannelStatusesCompanion data) {
    return ChannelStatusesData(
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
    return (StringBuffer('ChannelStatusesData(')
          ..write('id: $id, ')
          ..write('privacyStatus: $privacyStatus, ')
          ..write('isLinked: $isLinked, ')
          ..write('longUploadsStatus: $longUploadsStatus, ')
          ..write('madeForKids: $madeForKids')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, privacyStatus, isLinked, longUploadsStatus, madeForKids);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChannelStatusesData &&
          other.id == this.id &&
          other.privacyStatus == this.privacyStatus &&
          other.isLinked == this.isLinked &&
          other.longUploadsStatus == this.longUploadsStatus &&
          other.madeForKids == this.madeForKids);
}

class ChannelStatusesCompanion extends UpdateCompanion<ChannelStatusesData> {
  final Value<String> id;
  final Value<String> privacyStatus;
  final Value<int> isLinked;
  final Value<String> longUploadsStatus;
  final Value<int?> madeForKids;
  final Value<int> rowid;
  const ChannelStatusesCompanion({
    this.id = const Value.absent(),
    this.privacyStatus = const Value.absent(),
    this.isLinked = const Value.absent(),
    this.longUploadsStatus = const Value.absent(),
    this.madeForKids = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChannelStatusesCompanion.insert({
    required String id,
    required String privacyStatus,
    required int isLinked,
    required String longUploadsStatus,
    this.madeForKids = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       privacyStatus = Value(privacyStatus),
       isLinked = Value(isLinked),
       longUploadsStatus = Value(longUploadsStatus);
  static Insertable<ChannelStatusesData> custom({
    Expression<String>? id,
    Expression<String>? privacyStatus,
    Expression<int>? isLinked,
    Expression<String>? longUploadsStatus,
    Expression<int>? madeForKids,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (privacyStatus != null) 'privacy_status': privacyStatus,
      if (isLinked != null) 'is_linked': isLinked,
      if (longUploadsStatus != null) 'long_uploads_status': longUploadsStatus,
      if (madeForKids != null) 'made_for_kids': madeForKids,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChannelStatusesCompanion copyWith({
    Value<String>? id,
    Value<String>? privacyStatus,
    Value<int>? isLinked,
    Value<String>? longUploadsStatus,
    Value<int?>? madeForKids,
    Value<int>? rowid,
  }) {
    return ChannelStatusesCompanion(
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
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (privacyStatus.present) {
      map['privacy_status'] = Variable<String>(privacyStatus.value);
    }
    if (isLinked.present) {
      map['is_linked'] = Variable<int>(isLinked.value);
    }
    if (longUploadsStatus.present) {
      map['long_uploads_status'] = Variable<String>(longUploadsStatus.value);
    }
    if (madeForKids.present) {
      map['made_for_kids'] = Variable<int>(madeForKids.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelStatusesCompanion(')
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

class Videos extends Table with TableInfo<Videos, VideosData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Videos(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<String> setag = GeneratedColumn<String>(
    'setag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
    'channel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES channels(id)',
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideosData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideosData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
  Videos createAlias(String alias) {
    return Videos(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class VideosData extends DataClass implements Insertable<VideosData> {
  final int createdAt;
  final int updatedAt;
  final String id;
  final String? etag;
  final String? setag;
  final String channelId;
  const VideosData({
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
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
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

  factory VideosData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideosData(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
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
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'id': serializer.toJson<String>(id),
      'etag': serializer.toJson<String?>(etag),
      'setag': serializer.toJson<String?>(setag),
      'channelId': serializer.toJson<String>(channelId),
    };
  }

  VideosData copyWith({
    int? createdAt,
    int? updatedAt,
    String? id,
    Value<String?> etag = const Value.absent(),
    Value<String?> setag = const Value.absent(),
    String? channelId,
  }) => VideosData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    etag: etag.present ? etag.value : this.etag,
    setag: setag.present ? setag.value : this.setag,
    channelId: channelId ?? this.channelId,
  );
  VideosData copyWithCompanion(VideosCompanion data) {
    return VideosData(
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
    return (StringBuffer('VideosData(')
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
      (other is VideosData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.etag == this.etag &&
          other.setag == this.setag &&
          other.channelId == this.channelId);
}

class VideosCompanion extends UpdateCompanion<VideosData> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
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
  static Insertable<VideosData> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
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
    Value<int>? createdAt,
    Value<int>? updatedAt,
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
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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

class VideoSnippets extends Table
    with TableInfo<VideoSnippets, VideoSnippetsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  VideoSnippets(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES videos(id)',
  );
  late final GeneratedColumn<int> publishedAt = GeneratedColumn<int>(
    'published_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> channelTitle = GeneratedColumn<String>(
    'channel_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoSnippetsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoSnippetsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
  VideoSnippets createAlias(String alias) {
    return VideoSnippets(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class VideoSnippetsData extends DataClass
    implements Insertable<VideoSnippetsData> {
  final String id;
  final int publishedAt;
  final String title;
  final String description;
  final String channelTitle;
  const VideoSnippetsData({
    required this.id,
    required this.publishedAt,
    required this.title,
    required this.description,
    required this.channelTitle,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['published_at'] = Variable<int>(publishedAt);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['channel_title'] = Variable<String>(channelTitle);
    return map;
  }

  VideoSnippetsCompanion toCompanion(bool nullToAbsent) {
    return VideoSnippetsCompanion(
      id: Value(id),
      publishedAt: Value(publishedAt),
      title: Value(title),
      description: Value(description),
      channelTitle: Value(channelTitle),
    );
  }

  factory VideoSnippetsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoSnippetsData(
      id: serializer.fromJson<String>(json['id']),
      publishedAt: serializer.fromJson<int>(json['publishedAt']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      channelTitle: serializer.fromJson<String>(json['channelTitle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'publishedAt': serializer.toJson<int>(publishedAt),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'channelTitle': serializer.toJson<String>(channelTitle),
    };
  }

  VideoSnippetsData copyWith({
    String? id,
    int? publishedAt,
    String? title,
    String? description,
    String? channelTitle,
  }) => VideoSnippetsData(
    id: id ?? this.id,
    publishedAt: publishedAt ?? this.publishedAt,
    title: title ?? this.title,
    description: description ?? this.description,
    channelTitle: channelTitle ?? this.channelTitle,
  );
  VideoSnippetsData copyWithCompanion(VideoSnippetsCompanion data) {
    return VideoSnippetsData(
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
    return (StringBuffer('VideoSnippetsData(')
          ..write('id: $id, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('channelTitle: $channelTitle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, publishedAt, title, description, channelTitle);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoSnippetsData &&
          other.id == this.id &&
          other.publishedAt == this.publishedAt &&
          other.title == this.title &&
          other.description == this.description &&
          other.channelTitle == this.channelTitle);
}

class VideoSnippetsCompanion extends UpdateCompanion<VideoSnippetsData> {
  final Value<String> id;
  final Value<int> publishedAt;
  final Value<String> title;
  final Value<String> description;
  final Value<String> channelTitle;
  final Value<int> rowid;
  const VideoSnippetsCompanion({
    this.id = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.channelTitle = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoSnippetsCompanion.insert({
    required String id,
    required int publishedAt,
    required String title,
    required String description,
    required String channelTitle,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       publishedAt = Value(publishedAt),
       title = Value(title),
       description = Value(description),
       channelTitle = Value(channelTitle);
  static Insertable<VideoSnippetsData> custom({
    Expression<String>? id,
    Expression<int>? publishedAt,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? channelTitle,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (publishedAt != null) 'published_at': publishedAt,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (channelTitle != null) 'channel_title': channelTitle,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoSnippetsCompanion copyWith({
    Value<String>? id,
    Value<int>? publishedAt,
    Value<String>? title,
    Value<String>? description,
    Value<String>? channelTitle,
    Value<int>? rowid,
  }) {
    return VideoSnippetsCompanion(
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
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<int>(publishedAt.value);
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

class VideoThumbnails extends Table
    with TableInfo<VideoThumbnails, VideoThumbnailsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  VideoThumbnails(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES videos(id)',
  );
  late final GeneratedColumn<String> defaultUrl = GeneratedColumn<String>(
    'default_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> mediumUrl = GeneratedColumn<String>(
    'medium_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> highUrl = GeneratedColumn<String>(
    'high_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> standardUrl = GeneratedColumn<String>(
    'standard_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<String> maxresUrl = GeneratedColumn<String>(
    'maxres_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoThumbnailsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoThumbnailsData(
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
  VideoThumbnails createAlias(String alias) {
    return VideoThumbnails(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class VideoThumbnailsData extends DataClass
    implements Insertable<VideoThumbnailsData> {
  final String id;
  final String defaultUrl;
  final String mediumUrl;
  final String highUrl;
  final String? standardUrl;
  final String? maxresUrl;
  const VideoThumbnailsData({
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

  factory VideoThumbnailsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoThumbnailsData(
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
      'id': serializer.toJson<String>(id),
      'defaultUrl': serializer.toJson<String>(defaultUrl),
      'mediumUrl': serializer.toJson<String>(mediumUrl),
      'highUrl': serializer.toJson<String>(highUrl),
      'standardUrl': serializer.toJson<String?>(standardUrl),
      'maxresUrl': serializer.toJson<String?>(maxresUrl),
    };
  }

  VideoThumbnailsData copyWith({
    String? id,
    String? defaultUrl,
    String? mediumUrl,
    String? highUrl,
    Value<String?> standardUrl = const Value.absent(),
    Value<String?> maxresUrl = const Value.absent(),
  }) => VideoThumbnailsData(
    id: id ?? this.id,
    defaultUrl: defaultUrl ?? this.defaultUrl,
    mediumUrl: mediumUrl ?? this.mediumUrl,
    highUrl: highUrl ?? this.highUrl,
    standardUrl: standardUrl.present ? standardUrl.value : this.standardUrl,
    maxresUrl: maxresUrl.present ? maxresUrl.value : this.maxresUrl,
  );
  VideoThumbnailsData copyWithCompanion(VideoThumbnailsCompanion data) {
    return VideoThumbnailsData(
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
    return (StringBuffer('VideoThumbnailsData(')
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
  int get hashCode =>
      Object.hash(id, defaultUrl, mediumUrl, highUrl, standardUrl, maxresUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoThumbnailsData &&
          other.id == this.id &&
          other.defaultUrl == this.defaultUrl &&
          other.mediumUrl == this.mediumUrl &&
          other.highUrl == this.highUrl &&
          other.standardUrl == this.standardUrl &&
          other.maxresUrl == this.maxresUrl);
}

class VideoThumbnailsCompanion extends UpdateCompanion<VideoThumbnailsData> {
  final Value<String> id;
  final Value<String> defaultUrl;
  final Value<String> mediumUrl;
  final Value<String> highUrl;
  final Value<String?> standardUrl;
  final Value<String?> maxresUrl;
  final Value<int> rowid;
  const VideoThumbnailsCompanion({
    this.id = const Value.absent(),
    this.defaultUrl = const Value.absent(),
    this.mediumUrl = const Value.absent(),
    this.highUrl = const Value.absent(),
    this.standardUrl = const Value.absent(),
    this.maxresUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoThumbnailsCompanion.insert({
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
  static Insertable<VideoThumbnailsData> custom({
    Expression<String>? id,
    Expression<String>? defaultUrl,
    Expression<String>? mediumUrl,
    Expression<String>? highUrl,
    Expression<String>? standardUrl,
    Expression<String>? maxresUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
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
    Value<String>? id,
    Value<String>? defaultUrl,
    Value<String>? mediumUrl,
    Value<String>? highUrl,
    Value<String?>? standardUrl,
    Value<String?>? maxresUrl,
    Value<int>? rowid,
  }) {
    return VideoThumbnailsCompanion(
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

class VideoContentDetails extends Table
    with TableInfo<VideoContentDetails, VideoContentDetailsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  VideoContentDetails(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES videos(id)',
  );
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> dimension = GeneratedColumn<String>(
    'dimension',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> licensedContent = GeneratedColumn<int>(
    'licensed_content',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (licensed_content IN (0, 1))',
  );
  late final GeneratedColumn<String> projection = GeneratedColumn<String>(
    'projection',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoContentDetailsData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoContentDetailsData(
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
        DriftSqlType.int,
        data['${effectivePrefix}licensed_content'],
      )!,
      projection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}projection'],
      )!,
    );
  }

  @override
  VideoContentDetails createAlias(String alias) {
    return VideoContentDetails(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class VideoContentDetailsData extends DataClass
    implements Insertable<VideoContentDetailsData> {
  final String id;
  final String duration;
  final String dimension;
  final String definition;
  final String caption;
  final int licensedContent;
  final String projection;
  const VideoContentDetailsData({
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
    map['id'] = Variable<String>(id);
    map['duration'] = Variable<String>(duration);
    map['dimension'] = Variable<String>(dimension);
    map['definition'] = Variable<String>(definition);
    map['caption'] = Variable<String>(caption);
    map['licensed_content'] = Variable<int>(licensedContent);
    map['projection'] = Variable<String>(projection);
    return map;
  }

  VideoContentDetailsCompanion toCompanion(bool nullToAbsent) {
    return VideoContentDetailsCompanion(
      id: Value(id),
      duration: Value(duration),
      dimension: Value(dimension),
      definition: Value(definition),
      caption: Value(caption),
      licensedContent: Value(licensedContent),
      projection: Value(projection),
    );
  }

  factory VideoContentDetailsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoContentDetailsData(
      id: serializer.fromJson<String>(json['id']),
      duration: serializer.fromJson<String>(json['duration']),
      dimension: serializer.fromJson<String>(json['dimension']),
      definition: serializer.fromJson<String>(json['definition']),
      caption: serializer.fromJson<String>(json['caption']),
      licensedContent: serializer.fromJson<int>(json['licensedContent']),
      projection: serializer.fromJson<String>(json['projection']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'duration': serializer.toJson<String>(duration),
      'dimension': serializer.toJson<String>(dimension),
      'definition': serializer.toJson<String>(definition),
      'caption': serializer.toJson<String>(caption),
      'licensedContent': serializer.toJson<int>(licensedContent),
      'projection': serializer.toJson<String>(projection),
    };
  }

  VideoContentDetailsData copyWith({
    String? id,
    String? duration,
    String? dimension,
    String? definition,
    String? caption,
    int? licensedContent,
    String? projection,
  }) => VideoContentDetailsData(
    id: id ?? this.id,
    duration: duration ?? this.duration,
    dimension: dimension ?? this.dimension,
    definition: definition ?? this.definition,
    caption: caption ?? this.caption,
    licensedContent: licensedContent ?? this.licensedContent,
    projection: projection ?? this.projection,
  );
  VideoContentDetailsData copyWithCompanion(VideoContentDetailsCompanion data) {
    return VideoContentDetailsData(
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
    return (StringBuffer('VideoContentDetailsData(')
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
      (other is VideoContentDetailsData &&
          other.id == this.id &&
          other.duration == this.duration &&
          other.dimension == this.dimension &&
          other.definition == this.definition &&
          other.caption == this.caption &&
          other.licensedContent == this.licensedContent &&
          other.projection == this.projection);
}

class VideoContentDetailsCompanion
    extends UpdateCompanion<VideoContentDetailsData> {
  final Value<String> id;
  final Value<String> duration;
  final Value<String> dimension;
  final Value<String> definition;
  final Value<String> caption;
  final Value<int> licensedContent;
  final Value<String> projection;
  final Value<int> rowid;
  const VideoContentDetailsCompanion({
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
    required String id,
    required String duration,
    required String dimension,
    required String definition,
    required String caption,
    required int licensedContent,
    required String projection,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       duration = Value(duration),
       dimension = Value(dimension),
       definition = Value(definition),
       caption = Value(caption),
       licensedContent = Value(licensedContent),
       projection = Value(projection);
  static Insertable<VideoContentDetailsData> custom({
    Expression<String>? id,
    Expression<String>? duration,
    Expression<String>? dimension,
    Expression<String>? definition,
    Expression<String>? caption,
    Expression<int>? licensedContent,
    Expression<String>? projection,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
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
    Value<String>? id,
    Value<String>? duration,
    Value<String>? dimension,
    Value<String>? definition,
    Value<String>? caption,
    Value<int>? licensedContent,
    Value<String>? projection,
    Value<int>? rowid,
  }) {
    return VideoContentDetailsCompanion(
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
      map['licensed_content'] = Variable<int>(licensedContent.value);
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

class VideoStatuses extends Table
    with TableInfo<VideoStatuses, VideoStatusesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  VideoStatuses(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES videos(id)',
  );
  late final GeneratedColumn<String> uploadStatus = GeneratedColumn<String>(
    'upload_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> privacyStatus = GeneratedColumn<String>(
    'privacy_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> license = GeneratedColumn<String>(
    'license',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> embeddable = GeneratedColumn<int>(
    'embeddable',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (embeddable IN (0, 1))',
  );
  late final GeneratedColumn<int> publicStatsViewable = GeneratedColumn<int>(
    'public_stats_viewable',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (public_stats_viewable IN (0, 1))',
  );
  late final GeneratedColumn<int> madeForKids = GeneratedColumn<int>(
    'made_for_kids',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (made_for_kids IN (0, 1))',
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoStatusesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoStatusesData(
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
        DriftSqlType.int,
        data['${effectivePrefix}embeddable'],
      )!,
      publicStatsViewable: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}public_stats_viewable'],
      )!,
      madeForKids: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}made_for_kids'],
      )!,
    );
  }

  @override
  VideoStatuses createAlias(String alias) {
    return VideoStatuses(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class VideoStatusesData extends DataClass
    implements Insertable<VideoStatusesData> {
  final String id;
  final String uploadStatus;
  final String privacyStatus;
  final String license;
  final int embeddable;
  final int publicStatsViewable;
  final int madeForKids;
  const VideoStatusesData({
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
    map['id'] = Variable<String>(id);
    map['upload_status'] = Variable<String>(uploadStatus);
    map['privacy_status'] = Variable<String>(privacyStatus);
    map['license'] = Variable<String>(license);
    map['embeddable'] = Variable<int>(embeddable);
    map['public_stats_viewable'] = Variable<int>(publicStatsViewable);
    map['made_for_kids'] = Variable<int>(madeForKids);
    return map;
  }

  VideoStatusesCompanion toCompanion(bool nullToAbsent) {
    return VideoStatusesCompanion(
      id: Value(id),
      uploadStatus: Value(uploadStatus),
      privacyStatus: Value(privacyStatus),
      license: Value(license),
      embeddable: Value(embeddable),
      publicStatsViewable: Value(publicStatsViewable),
      madeForKids: Value(madeForKids),
    );
  }

  factory VideoStatusesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoStatusesData(
      id: serializer.fromJson<String>(json['id']),
      uploadStatus: serializer.fromJson<String>(json['uploadStatus']),
      privacyStatus: serializer.fromJson<String>(json['privacyStatus']),
      license: serializer.fromJson<String>(json['license']),
      embeddable: serializer.fromJson<int>(json['embeddable']),
      publicStatsViewable: serializer.fromJson<int>(
        json['publicStatsViewable'],
      ),
      madeForKids: serializer.fromJson<int>(json['madeForKids']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uploadStatus': serializer.toJson<String>(uploadStatus),
      'privacyStatus': serializer.toJson<String>(privacyStatus),
      'license': serializer.toJson<String>(license),
      'embeddable': serializer.toJson<int>(embeddable),
      'publicStatsViewable': serializer.toJson<int>(publicStatsViewable),
      'madeForKids': serializer.toJson<int>(madeForKids),
    };
  }

  VideoStatusesData copyWith({
    String? id,
    String? uploadStatus,
    String? privacyStatus,
    String? license,
    int? embeddable,
    int? publicStatsViewable,
    int? madeForKids,
  }) => VideoStatusesData(
    id: id ?? this.id,
    uploadStatus: uploadStatus ?? this.uploadStatus,
    privacyStatus: privacyStatus ?? this.privacyStatus,
    license: license ?? this.license,
    embeddable: embeddable ?? this.embeddable,
    publicStatsViewable: publicStatsViewable ?? this.publicStatsViewable,
    madeForKids: madeForKids ?? this.madeForKids,
  );
  VideoStatusesData copyWithCompanion(VideoStatusesCompanion data) {
    return VideoStatusesData(
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
    return (StringBuffer('VideoStatusesData(')
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
      (other is VideoStatusesData &&
          other.id == this.id &&
          other.uploadStatus == this.uploadStatus &&
          other.privacyStatus == this.privacyStatus &&
          other.license == this.license &&
          other.embeddable == this.embeddable &&
          other.publicStatsViewable == this.publicStatsViewable &&
          other.madeForKids == this.madeForKids);
}

class VideoStatusesCompanion extends UpdateCompanion<VideoStatusesData> {
  final Value<String> id;
  final Value<String> uploadStatus;
  final Value<String> privacyStatus;
  final Value<String> license;
  final Value<int> embeddable;
  final Value<int> publicStatsViewable;
  final Value<int> madeForKids;
  final Value<int> rowid;
  const VideoStatusesCompanion({
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
    required String id,
    required String uploadStatus,
    required String privacyStatus,
    required String license,
    required int embeddable,
    required int publicStatsViewable,
    required int madeForKids,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       uploadStatus = Value(uploadStatus),
       privacyStatus = Value(privacyStatus),
       license = Value(license),
       embeddable = Value(embeddable),
       publicStatsViewable = Value(publicStatsViewable),
       madeForKids = Value(madeForKids);
  static Insertable<VideoStatusesData> custom({
    Expression<String>? id,
    Expression<String>? uploadStatus,
    Expression<String>? privacyStatus,
    Expression<String>? license,
    Expression<int>? embeddable,
    Expression<int>? publicStatsViewable,
    Expression<int>? madeForKids,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
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
    Value<String>? id,
    Value<String>? uploadStatus,
    Value<String>? privacyStatus,
    Value<String>? license,
    Value<int>? embeddable,
    Value<int>? publicStatsViewable,
    Value<int>? madeForKids,
    Value<int>? rowid,
  }) {
    return VideoStatusesCompanion(
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
      map['embeddable'] = Variable<int>(embeddable.value);
    }
    if (publicStatsViewable.present) {
      map['public_stats_viewable'] = Variable<int>(publicStatsViewable.value);
    }
    if (madeForKids.present) {
      map['made_for_kids'] = Variable<int>(madeForKids.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoStatusesCompanion(')
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

class VideoStatistics extends Table
    with TableInfo<VideoStatistics, VideoStatisticsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  VideoStatistics(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES videos(id)',
  );
  late final GeneratedColumn<int> viewCount = GeneratedColumn<int>(
    'view_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> likeCount = GeneratedColumn<int>(
    'like_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<int> dislikeCount = GeneratedColumn<int>(
    'dislike_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<int> favoriteCount = GeneratedColumn<int>(
    'favorite_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> commentCount = GeneratedColumn<int>(
    'comment_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoStatisticsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoStatisticsData(
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
  VideoStatistics createAlias(String alias) {
    return VideoStatistics(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class VideoStatisticsData extends DataClass
    implements Insertable<VideoStatisticsData> {
  final String id;
  final int viewCount;
  final int? likeCount;
  final int? dislikeCount;
  final int favoriteCount;
  final int? commentCount;
  const VideoStatisticsData({
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

  factory VideoStatisticsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoStatisticsData(
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
      'id': serializer.toJson<String>(id),
      'viewCount': serializer.toJson<int>(viewCount),
      'likeCount': serializer.toJson<int?>(likeCount),
      'dislikeCount': serializer.toJson<int?>(dislikeCount),
      'favoriteCount': serializer.toJson<int>(favoriteCount),
      'commentCount': serializer.toJson<int?>(commentCount),
    };
  }

  VideoStatisticsData copyWith({
    String? id,
    int? viewCount,
    Value<int?> likeCount = const Value.absent(),
    Value<int?> dislikeCount = const Value.absent(),
    int? favoriteCount,
    Value<int?> commentCount = const Value.absent(),
  }) => VideoStatisticsData(
    id: id ?? this.id,
    viewCount: viewCount ?? this.viewCount,
    likeCount: likeCount.present ? likeCount.value : this.likeCount,
    dislikeCount: dislikeCount.present ? dislikeCount.value : this.dislikeCount,
    favoriteCount: favoriteCount ?? this.favoriteCount,
    commentCount: commentCount.present ? commentCount.value : this.commentCount,
  );
  VideoStatisticsData copyWithCompanion(VideoStatisticsCompanion data) {
    return VideoStatisticsData(
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
    return (StringBuffer('VideoStatisticsData(')
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
      (other is VideoStatisticsData &&
          other.id == this.id &&
          other.viewCount == this.viewCount &&
          other.likeCount == this.likeCount &&
          other.dislikeCount == this.dislikeCount &&
          other.favoriteCount == this.favoriteCount &&
          other.commentCount == this.commentCount);
}

class VideoStatisticsCompanion extends UpdateCompanion<VideoStatisticsData> {
  final Value<String> id;
  final Value<int> viewCount;
  final Value<int?> likeCount;
  final Value<int?> dislikeCount;
  final Value<int> favoriteCount;
  final Value<int?> commentCount;
  final Value<int> rowid;
  const VideoStatisticsCompanion({
    this.id = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.dislikeCount = const Value.absent(),
    this.favoriteCount = const Value.absent(),
    this.commentCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoStatisticsCompanion.insert({
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
  static Insertable<VideoStatisticsData> custom({
    Expression<String>? id,
    Expression<int>? viewCount,
    Expression<int>? likeCount,
    Expression<int>? dislikeCount,
    Expression<int>? favoriteCount,
    Expression<int>? commentCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
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
    Value<String>? id,
    Value<int>? viewCount,
    Value<int?>? likeCount,
    Value<int?>? dislikeCount,
    Value<int>? favoriteCount,
    Value<int?>? commentCount,
    Value<int>? rowid,
  }) {
    return VideoStatisticsCompanion(
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

class VideoProgress extends Table
    with TableInfo<VideoProgress, VideoProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  VideoProgress(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES videos(id)',
  );
  late final GeneratedColumn<int> watchPosition = GeneratedColumn<int>(
    'watch_position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> isFinished = GeneratedColumn<int>(
    'is_finished',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (is_finished IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, watchPosition, isFinished];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_progress';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      watchPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}watch_position'],
      )!,
      isFinished: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_finished'],
      )!,
    );
  }

  @override
  VideoProgress createAlias(String alias) {
    return VideoProgress(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class VideoProgressData extends DataClass
    implements Insertable<VideoProgressData> {
  final String id;
  final int watchPosition;
  final int isFinished;
  const VideoProgressData({
    required this.id,
    required this.watchPosition,
    required this.isFinished,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['watch_position'] = Variable<int>(watchPosition);
    map['is_finished'] = Variable<int>(isFinished);
    return map;
  }

  VideoProgressCompanion toCompanion(bool nullToAbsent) {
    return VideoProgressCompanion(
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
      id: serializer.fromJson<String>(json['id']),
      watchPosition: serializer.fromJson<int>(json['watchPosition']),
      isFinished: serializer.fromJson<int>(json['isFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'watchPosition': serializer.toJson<int>(watchPosition),
      'isFinished': serializer.toJson<int>(isFinished),
    };
  }

  VideoProgressData copyWith({
    String? id,
    int? watchPosition,
    int? isFinished,
  }) => VideoProgressData(
    id: id ?? this.id,
    watchPosition: watchPosition ?? this.watchPosition,
    isFinished: isFinished ?? this.isFinished,
  );
  VideoProgressData copyWithCompanion(VideoProgressCompanion data) {
    return VideoProgressData(
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
          ..write('id: $id, ')
          ..write('watchPosition: $watchPosition, ')
          ..write('isFinished: $isFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, watchPosition, isFinished);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoProgressData &&
          other.id == this.id &&
          other.watchPosition == this.watchPosition &&
          other.isFinished == this.isFinished);
}

class VideoProgressCompanion extends UpdateCompanion<VideoProgressData> {
  final Value<String> id;
  final Value<int> watchPosition;
  final Value<int> isFinished;
  final Value<int> rowid;
  const VideoProgressCompanion({
    this.id = const Value.absent(),
    this.watchPosition = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoProgressCompanion.insert({
    required String id,
    this.watchPosition = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<VideoProgressData> custom({
    Expression<String>? id,
    Expression<int>? watchPosition,
    Expression<int>? isFinished,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (watchPosition != null) 'watch_position': watchPosition,
      if (isFinished != null) 'is_finished': isFinished,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoProgressCompanion copyWith({
    Value<String>? id,
    Value<int>? watchPosition,
    Value<int>? isFinished,
    Value<int>? rowid,
  }) {
    return VideoProgressCompanion(
      id: id ?? this.id,
      watchPosition: watchPosition ?? this.watchPosition,
      isFinished: isFinished ?? this.isFinished,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (watchPosition.present) {
      map['watch_position'] = Variable<int>(watchPosition.value);
    }
    if (isFinished.present) {
      map['is_finished'] = Variable<int>(isFinished.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoProgressCompanion(')
          ..write('id: $id, ')
          ..write('watchPosition: $watchPosition, ')
          ..write('isFinished: $isFinished, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Playlists extends Table with TableInfo<Playlists, PlaylistsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Playlists(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
    'channel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES channels(id)',
  );
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistsData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
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
  Playlists createAlias(String alias) {
    return Playlists(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class PlaylistsData extends DataClass implements Insertable<PlaylistsData> {
  final int createdAt;
  final int updatedAt;
  final String id;
  final String channelId;
  final int type;
  final int priority;
  final String etag;
  const PlaylistsData({
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
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['id'] = Variable<String>(id);
    map['channel_id'] = Variable<String>(channelId);
    map['type'] = Variable<int>(type);
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

  factory PlaylistsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistsData(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      channelId: serializer.fromJson<String>(json['channelId']),
      type: serializer.fromJson<int>(json['type']),
      priority: serializer.fromJson<int>(json['priority']),
      etag: serializer.fromJson<String>(json['etag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'id': serializer.toJson<String>(id),
      'channelId': serializer.toJson<String>(channelId),
      'type': serializer.toJson<int>(type),
      'priority': serializer.toJson<int>(priority),
      'etag': serializer.toJson<String>(etag),
    };
  }

  PlaylistsData copyWith({
    int? createdAt,
    int? updatedAt,
    String? id,
    String? channelId,
    int? type,
    int? priority,
    String? etag,
  }) => PlaylistsData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    channelId: channelId ?? this.channelId,
    type: type ?? this.type,
    priority: priority ?? this.priority,
    etag: etag ?? this.etag,
  );
  PlaylistsData copyWithCompanion(PlaylistsCompanion data) {
    return PlaylistsData(
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
    return (StringBuffer('PlaylistsData(')
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
      (other is PlaylistsData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.channelId == this.channelId &&
          other.type == this.type &&
          other.priority == this.priority &&
          other.etag == this.etag);
}

class PlaylistsCompanion extends UpdateCompanion<PlaylistsData> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String> id;
  final Value<String> channelId;
  final Value<int> type;
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
    required int type,
    required int priority,
    required String etag,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       channelId = Value(channelId),
       type = Value(type),
       priority = Value(priority),
       etag = Value(etag);
  static Insertable<PlaylistsData> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
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
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<String>? id,
    Value<String>? channelId,
    Value<int>? type,
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
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
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

class PlaylistSnippets extends Table
    with TableInfo<PlaylistSnippets, PlaylistSnippetsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PlaylistSnippets(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES playlists(id)',
  );
  late final GeneratedColumn<int> publishedAt = GeneratedColumn<int>(
    'published_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> channelTitle = GeneratedColumn<String>(
    'channel_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistSnippetsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistSnippetsData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
  PlaylistSnippets createAlias(String alias) {
    return PlaylistSnippets(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class PlaylistSnippetsData extends DataClass
    implements Insertable<PlaylistSnippetsData> {
  final int createdAt;
  final int updatedAt;
  final String id;
  final int publishedAt;
  final String title;
  final String description;
  final String channelTitle;
  const PlaylistSnippetsData({
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
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['id'] = Variable<String>(id);
    map['published_at'] = Variable<int>(publishedAt);
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

  factory PlaylistSnippetsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistSnippetsData(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      publishedAt: serializer.fromJson<int>(json['publishedAt']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      channelTitle: serializer.fromJson<String>(json['channelTitle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'id': serializer.toJson<String>(id),
      'publishedAt': serializer.toJson<int>(publishedAt),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'channelTitle': serializer.toJson<String>(channelTitle),
    };
  }

  PlaylistSnippetsData copyWith({
    int? createdAt,
    int? updatedAt,
    String? id,
    int? publishedAt,
    String? title,
    String? description,
    String? channelTitle,
  }) => PlaylistSnippetsData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    publishedAt: publishedAt ?? this.publishedAt,
    title: title ?? this.title,
    description: description ?? this.description,
    channelTitle: channelTitle ?? this.channelTitle,
  );
  PlaylistSnippetsData copyWithCompanion(PlaylistSnippetsCompanion data) {
    return PlaylistSnippetsData(
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
    return (StringBuffer('PlaylistSnippetsData(')
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
      (other is PlaylistSnippetsData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.publishedAt == this.publishedAt &&
          other.title == this.title &&
          other.description == this.description &&
          other.channelTitle == this.channelTitle);
}

class PlaylistSnippetsCompanion extends UpdateCompanion<PlaylistSnippetsData> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String> id;
  final Value<int> publishedAt;
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
    required int publishedAt,
    required String title,
    required String description,
    required String channelTitle,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       publishedAt = Value(publishedAt),
       title = Value(title),
       description = Value(description),
       channelTitle = Value(channelTitle);
  static Insertable<PlaylistSnippetsData> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? id,
    Expression<int>? publishedAt,
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
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<String>? id,
    Value<int>? publishedAt,
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
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<int>(publishedAt.value);
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

class PlaylistThumbnails extends Table
    with TableInfo<PlaylistThumbnails, PlaylistThumbnailsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PlaylistThumbnails(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES playlists(id)',
  );
  late final GeneratedColumn<String> defaultUrl = GeneratedColumn<String>(
    'default_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> mediumUrl = GeneratedColumn<String>(
    'medium_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> highUrl = GeneratedColumn<String>(
    'high_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> standardUrl = GeneratedColumn<String>(
    'standard_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<String> maxresUrl = GeneratedColumn<String>(
    'maxres_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistThumbnailsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistThumbnailsData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
  PlaylistThumbnails createAlias(String alias) {
    return PlaylistThumbnails(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class PlaylistThumbnailsData extends DataClass
    implements Insertable<PlaylistThumbnailsData> {
  final int createdAt;
  final int updatedAt;
  final String id;
  final String defaultUrl;
  final String mediumUrl;
  final String highUrl;
  final String? standardUrl;
  final String? maxresUrl;
  const PlaylistThumbnailsData({
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
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
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

  factory PlaylistThumbnailsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistThumbnailsData(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
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
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'id': serializer.toJson<String>(id),
      'defaultUrl': serializer.toJson<String>(defaultUrl),
      'mediumUrl': serializer.toJson<String>(mediumUrl),
      'highUrl': serializer.toJson<String>(highUrl),
      'standardUrl': serializer.toJson<String?>(standardUrl),
      'maxresUrl': serializer.toJson<String?>(maxresUrl),
    };
  }

  PlaylistThumbnailsData copyWith({
    int? createdAt,
    int? updatedAt,
    String? id,
    String? defaultUrl,
    String? mediumUrl,
    String? highUrl,
    Value<String?> standardUrl = const Value.absent(),
    Value<String?> maxresUrl = const Value.absent(),
  }) => PlaylistThumbnailsData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    defaultUrl: defaultUrl ?? this.defaultUrl,
    mediumUrl: mediumUrl ?? this.mediumUrl,
    highUrl: highUrl ?? this.highUrl,
    standardUrl: standardUrl.present ? standardUrl.value : this.standardUrl,
    maxresUrl: maxresUrl.present ? maxresUrl.value : this.maxresUrl,
  );
  PlaylistThumbnailsData copyWithCompanion(PlaylistThumbnailsCompanion data) {
    return PlaylistThumbnailsData(
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
    return (StringBuffer('PlaylistThumbnailsData(')
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
      (other is PlaylistThumbnailsData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.defaultUrl == this.defaultUrl &&
          other.mediumUrl == this.mediumUrl &&
          other.highUrl == this.highUrl &&
          other.standardUrl == this.standardUrl &&
          other.maxresUrl == this.maxresUrl);
}

class PlaylistThumbnailsCompanion
    extends UpdateCompanion<PlaylistThumbnailsData> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
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
  static Insertable<PlaylistThumbnailsData> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
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
    Value<int>? createdAt,
    Value<int>? updatedAt,
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
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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

class PlaylistContentDetails extends Table
    with TableInfo<PlaylistContentDetails, PlaylistContentDetailsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PlaylistContentDetails(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES playlists(id)',
  );
  late final GeneratedColumn<int> itemCount = GeneratedColumn<int>(
    'item_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [createdAt, updatedAt, id, itemCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_content_details';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistContentDetailsData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistContentDetailsData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
  PlaylistContentDetails createAlias(String alias) {
    return PlaylistContentDetails(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class PlaylistContentDetailsData extends DataClass
    implements Insertable<PlaylistContentDetailsData> {
  final int createdAt;
  final int updatedAt;
  final String id;
  final int itemCount;
  const PlaylistContentDetailsData({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.itemCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
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

  factory PlaylistContentDetailsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistContentDetailsData(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      itemCount: serializer.fromJson<int>(json['itemCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'id': serializer.toJson<String>(id),
      'itemCount': serializer.toJson<int>(itemCount),
    };
  }

  PlaylistContentDetailsData copyWith({
    int? createdAt,
    int? updatedAt,
    String? id,
    int? itemCount,
  }) => PlaylistContentDetailsData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    itemCount: itemCount ?? this.itemCount,
  );
  PlaylistContentDetailsData copyWithCompanion(
    PlaylistContentDetailsCompanion data,
  ) {
    return PlaylistContentDetailsData(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      itemCount: data.itemCount.present ? data.itemCount.value : this.itemCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistContentDetailsData(')
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
      (other is PlaylistContentDetailsData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.itemCount == this.itemCount);
}

class PlaylistContentDetailsCompanion
    extends UpdateCompanion<PlaylistContentDetailsData> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
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
  static Insertable<PlaylistContentDetailsData> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
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
    Value<int>? createdAt,
    Value<int>? updatedAt,
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
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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

class PlaylistVsVideos extends Table
    with TableInfo<PlaylistVsVideos, PlaylistVsVideosData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PlaylistVsVideos(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> playlistId = GeneratedColumn<String>(
    'playlist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES playlists(id)',
  );
  late final GeneratedColumn<String> videoId = GeneratedColumn<String>(
    'video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES videos(id)',
  );
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [playlistId, videoId, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_vs_videos';
  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, videoId};
  @override
  PlaylistVsVideosData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistVsVideosData(
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
  PlaylistVsVideos createAlias(String alias) {
    return PlaylistVsVideos(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(playlist_id, video_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class PlaylistVsVideosData extends DataClass
    implements Insertable<PlaylistVsVideosData> {
  final String playlistId;
  final String videoId;
  final int priority;
  const PlaylistVsVideosData({
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

  factory PlaylistVsVideosData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistVsVideosData(
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

  PlaylistVsVideosData copyWith({
    String? playlistId,
    String? videoId,
    int? priority,
  }) => PlaylistVsVideosData(
    playlistId: playlistId ?? this.playlistId,
    videoId: videoId ?? this.videoId,
    priority: priority ?? this.priority,
  );
  PlaylistVsVideosData copyWithCompanion(PlaylistVsVideosCompanion data) {
    return PlaylistVsVideosData(
      playlistId: data.playlistId.present
          ? data.playlistId.value
          : this.playlistId,
      videoId: data.videoId.present ? data.videoId.value : this.videoId,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistVsVideosData(')
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
      (other is PlaylistVsVideosData &&
          other.playlistId == this.playlistId &&
          other.videoId == this.videoId &&
          other.priority == this.priority);
}

class PlaylistVsVideosCompanion extends UpdateCompanion<PlaylistVsVideosData> {
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
  static Insertable<PlaylistVsVideosData> custom({
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

class ChannelSearches extends Table
    with TableInfo<ChannelSearches, ChannelSearchesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChannelSearches(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
    'query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [createdAt, updatedAt, id, query];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_searches';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChannelSearchesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelSearchesData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
  ChannelSearches createAlias(String alias) {
    return ChannelSearches(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ChannelSearchesData extends DataClass
    implements Insertable<ChannelSearchesData> {
  final int createdAt;
  final int updatedAt;
  final int id;
  final String query;
  const ChannelSearchesData({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.query,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
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

  factory ChannelSearchesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelSearchesData(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      id: serializer.fromJson<int>(json['id']),
      query: serializer.fromJson<String>(json['query']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'id': serializer.toJson<int>(id),
      'query': serializer.toJson<String>(query),
    };
  }

  ChannelSearchesData copyWith({
    int? createdAt,
    int? updatedAt,
    int? id,
    String? query,
  }) => ChannelSearchesData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    query: query ?? this.query,
  );
  ChannelSearchesData copyWithCompanion(ChannelSearchesCompanion data) {
    return ChannelSearchesData(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      query: data.query.present ? data.query.value : this.query,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelSearchesData(')
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
      (other is ChannelSearchesData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.query == this.query);
}

class ChannelSearchesCompanion extends UpdateCompanion<ChannelSearchesData> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
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
  static Insertable<ChannelSearchesData> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
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
    Value<int>? createdAt,
    Value<int>? updatedAt,
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
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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

class ChannelSearchVsChannels extends Table
    with TableInfo<ChannelSearchVsChannels, ChannelSearchVsChannelsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChannelSearchVsChannels(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> searchId = GeneratedColumn<int>(
    'search_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES channel_searches(id)',
  );
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
    'channel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES channels(id)',
  );
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [searchId, channelId, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channel_search_vs_channels';
  @override
  Set<GeneratedColumn> get $primaryKey => {searchId, channelId};
  @override
  ChannelSearchVsChannelsData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChannelSearchVsChannelsData(
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
  ChannelSearchVsChannels createAlias(String alias) {
    return ChannelSearchVsChannels(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(search_id, channel_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ChannelSearchVsChannelsData extends DataClass
    implements Insertable<ChannelSearchVsChannelsData> {
  final int searchId;
  final String channelId;
  final int priority;
  const ChannelSearchVsChannelsData({
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

  factory ChannelSearchVsChannelsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChannelSearchVsChannelsData(
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

  ChannelSearchVsChannelsData copyWith({
    int? searchId,
    String? channelId,
    int? priority,
  }) => ChannelSearchVsChannelsData(
    searchId: searchId ?? this.searchId,
    channelId: channelId ?? this.channelId,
    priority: priority ?? this.priority,
  );
  ChannelSearchVsChannelsData copyWithCompanion(
    ChannelSearchVsChannelsCompanion data,
  ) {
    return ChannelSearchVsChannelsData(
      searchId: data.searchId.present ? data.searchId.value : this.searchId,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChannelSearchVsChannelsData(')
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
      (other is ChannelSearchVsChannelsData &&
          other.searchId == this.searchId &&
          other.channelId == this.channelId &&
          other.priority == this.priority);
}

class ChannelSearchVsChannelsCompanion
    extends UpdateCompanion<ChannelSearchVsChannelsData> {
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
  static Insertable<ChannelSearchVsChannelsData> custom({
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

class VideoSearches extends Table
    with TableInfo<VideoSearches, VideoSearchesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  VideoSearches(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
    'query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [createdAt, updatedAt, id, query];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_searches';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoSearchesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoSearchesData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
  VideoSearches createAlias(String alias) {
    return VideoSearches(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class VideoSearchesData extends DataClass
    implements Insertable<VideoSearchesData> {
  final int createdAt;
  final int updatedAt;
  final int id;
  final String query;
  const VideoSearchesData({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.query,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
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

  factory VideoSearchesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoSearchesData(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      id: serializer.fromJson<int>(json['id']),
      query: serializer.fromJson<String>(json['query']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'id': serializer.toJson<int>(id),
      'query': serializer.toJson<String>(query),
    };
  }

  VideoSearchesData copyWith({
    int? createdAt,
    int? updatedAt,
    int? id,
    String? query,
  }) => VideoSearchesData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    query: query ?? this.query,
  );
  VideoSearchesData copyWithCompanion(VideoSearchesCompanion data) {
    return VideoSearchesData(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      query: data.query.present ? data.query.value : this.query,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoSearchesData(')
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
      (other is VideoSearchesData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.query == this.query);
}

class VideoSearchesCompanion extends UpdateCompanion<VideoSearchesData> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
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
  static Insertable<VideoSearchesData> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
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
    Value<int>? createdAt,
    Value<int>? updatedAt,
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
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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

class VideoSearchVsVideos extends Table
    with TableInfo<VideoSearchVsVideos, VideoSearchVsVideosData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  VideoSearchVsVideos(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> searchId = GeneratedColumn<int>(
    'search_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES video_searches(id)',
  );
  late final GeneratedColumn<String> videoId = GeneratedColumn<String>(
    'video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES videos(id)',
  );
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [searchId, videoId, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_search_vs_videos';
  @override
  Set<GeneratedColumn> get $primaryKey => {searchId, videoId};
  @override
  VideoSearchVsVideosData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoSearchVsVideosData(
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
  VideoSearchVsVideos createAlias(String alias) {
    return VideoSearchVsVideos(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(search_id, video_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class VideoSearchVsVideosData extends DataClass
    implements Insertable<VideoSearchVsVideosData> {
  final int searchId;
  final String videoId;
  final int priority;
  const VideoSearchVsVideosData({
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

  factory VideoSearchVsVideosData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoSearchVsVideosData(
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

  VideoSearchVsVideosData copyWith({
    int? searchId,
    String? videoId,
    int? priority,
  }) => VideoSearchVsVideosData(
    searchId: searchId ?? this.searchId,
    videoId: videoId ?? this.videoId,
    priority: priority ?? this.priority,
  );
  VideoSearchVsVideosData copyWithCompanion(VideoSearchVsVideosCompanion data) {
    return VideoSearchVsVideosData(
      searchId: data.searchId.present ? data.searchId.value : this.searchId,
      videoId: data.videoId.present ? data.videoId.value : this.videoId,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoSearchVsVideosData(')
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
      (other is VideoSearchVsVideosData &&
          other.searchId == this.searchId &&
          other.videoId == this.videoId &&
          other.priority == this.priority);
}

class VideoSearchVsVideosCompanion
    extends UpdateCompanion<VideoSearchVsVideosData> {
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
  static Insertable<VideoSearchVsVideosData> custom({
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

class Collections extends Table with TableInfo<Collections, CollectionsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Collections(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  late final GeneratedColumn<int> isSystem = GeneratedColumn<int>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (is_system IN (0, 1))',
  );
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionsData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
  Collections createAlias(String alias) {
    return Collections(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CollectionsData extends DataClass implements Insertable<CollectionsData> {
  final int createdAt;
  final int updatedAt;
  final int id;
  final int isSystem;
  final int priority;
  final String name;
  final String description;
  const CollectionsData({
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
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['id'] = Variable<int>(id);
    map['is_system'] = Variable<int>(isSystem);
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

  factory CollectionsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionsData(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      id: serializer.fromJson<int>(json['id']),
      isSystem: serializer.fromJson<int>(json['isSystem']),
      priority: serializer.fromJson<int>(json['priority']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'id': serializer.toJson<int>(id),
      'isSystem': serializer.toJson<int>(isSystem),
      'priority': serializer.toJson<int>(priority),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  CollectionsData copyWith({
    int? createdAt,
    int? updatedAt,
    int? id,
    int? isSystem,
    int? priority,
    String? name,
    String? description,
  }) => CollectionsData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    isSystem: isSystem ?? this.isSystem,
    priority: priority ?? this.priority,
    name: name ?? this.name,
    description: description ?? this.description,
  );
  CollectionsData copyWithCompanion(CollectionsCompanion data) {
    return CollectionsData(
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
    return (StringBuffer('CollectionsData(')
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
      (other is CollectionsData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.isSystem == this.isSystem &&
          other.priority == this.priority &&
          other.name == this.name &&
          other.description == this.description);
}

class CollectionsCompanion extends UpdateCompanion<CollectionsData> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> id;
  final Value<int> isSystem;
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
    required int isSystem,
    required int priority,
    required String name,
    required String description,
  }) : isSystem = Value(isSystem),
       priority = Value(priority),
       name = Value(name),
       description = Value(description);
  static Insertable<CollectionsData> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? id,
    Expression<int>? isSystem,
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
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? id,
    Value<int>? isSystem,
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
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<int>(isSystem.value);
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

class Series extends Table with TableInfo<Series, SeriesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Series(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT (CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER))',
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES collections(id)',
  );
  late final GeneratedColumn<String> coverVideoId = GeneratedColumn<String>(
    'cover_video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES videos(id)',
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SeriesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeriesData(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
  Series createAlias(String alias) {
    return Series(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class SeriesData extends DataClass implements Insertable<SeriesData> {
  final int createdAt;
  final int updatedAt;
  final int id;
  final int collectionId;
  final String coverVideoId;
  final String name;
  final String description;
  final int priority;
  const SeriesData({
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
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
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

  factory SeriesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeriesData(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
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
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int>(collectionId),
      'coverVideoId': serializer.toJson<String>(coverVideoId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'priority': serializer.toJson<int>(priority),
    };
  }

  SeriesData copyWith({
    int? createdAt,
    int? updatedAt,
    int? id,
    int? collectionId,
    String? coverVideoId,
    String? name,
    String? description,
    int? priority,
  }) => SeriesData(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    coverVideoId: coverVideoId ?? this.coverVideoId,
    name: name ?? this.name,
    description: description ?? this.description,
    priority: priority ?? this.priority,
  );
  SeriesData copyWithCompanion(SeriesCompanion data) {
    return SeriesData(
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
    return (StringBuffer('SeriesData(')
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
      (other is SeriesData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.coverVideoId == this.coverVideoId &&
          other.name == this.name &&
          other.description == this.description &&
          other.priority == this.priority);
}

class SeriesCompanion extends UpdateCompanion<SeriesData> {
  final Value<int> createdAt;
  final Value<int> updatedAt;
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
  static Insertable<SeriesData> custom({
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
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
    Value<int>? createdAt,
    Value<int>? updatedAt,
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
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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

class SeriesVsVideos extends Table
    with TableInfo<SeriesVsVideos, SeriesVsVideosData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SeriesVsVideos(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> seriesId = GeneratedColumn<int>(
    'series_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES series(id)',
  );
  late final GeneratedColumn<String> videoId = GeneratedColumn<String>(
    'video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES videos(id)',
  );
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [seriesId, videoId, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'series_vs_videos';
  @override
  Set<GeneratedColumn> get $primaryKey => {seriesId, videoId};
  @override
  SeriesVsVideosData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeriesVsVideosData(
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
  SeriesVsVideos createAlias(String alias) {
    return SeriesVsVideos(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(series_id, video_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class SeriesVsVideosData extends DataClass
    implements Insertable<SeriesVsVideosData> {
  final int seriesId;
  final String videoId;
  final int priority;
  const SeriesVsVideosData({
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

  factory SeriesVsVideosData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeriesVsVideosData(
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

  SeriesVsVideosData copyWith({
    int? seriesId,
    String? videoId,
    int? priority,
  }) => SeriesVsVideosData(
    seriesId: seriesId ?? this.seriesId,
    videoId: videoId ?? this.videoId,
    priority: priority ?? this.priority,
  );
  SeriesVsVideosData copyWithCompanion(SeriesVsVideosCompanion data) {
    return SeriesVsVideosData(
      seriesId: data.seriesId.present ? data.seriesId.value : this.seriesId,
      videoId: data.videoId.present ? data.videoId.value : this.videoId,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SeriesVsVideosData(')
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
      (other is SeriesVsVideosData &&
          other.seriesId == this.seriesId &&
          other.videoId == this.videoId &&
          other.priority == this.priority);
}

class SeriesVsVideosCompanion extends UpdateCompanion<SeriesVsVideosData> {
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
  static Insertable<SeriesVsVideosData> custom({
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

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(e);
  late final Channels channels = Channels(this);
  late final ChannelSnippets channelSnippets = ChannelSnippets(this);
  late final ChannelThumbnails channelThumbnails = ChannelThumbnails(this);
  late final ChannelContentDetails channelContentDetails =
      ChannelContentDetails(this);
  late final ChannelStatistics channelStatistics = ChannelStatistics(this);
  late final ChannelStatuses channelStatuses = ChannelStatuses(this);
  late final Videos videos = Videos(this);
  late final VideoSnippets videoSnippets = VideoSnippets(this);
  late final VideoThumbnails videoThumbnails = VideoThumbnails(this);
  late final VideoContentDetails videoContentDetails = VideoContentDetails(
    this,
  );
  late final VideoStatuses videoStatuses = VideoStatuses(this);
  late final VideoStatistics videoStatistics = VideoStatistics(this);
  late final VideoProgress videoProgress = VideoProgress(this);
  late final Playlists playlists = Playlists(this);
  late final PlaylistSnippets playlistSnippets = PlaylistSnippets(this);
  late final PlaylistThumbnails playlistThumbnails = PlaylistThumbnails(this);
  late final PlaylistContentDetails playlistContentDetails =
      PlaylistContentDetails(this);
  late final PlaylistVsVideos playlistVsVideos = PlaylistVsVideos(this);
  late final ChannelSearches channelSearches = ChannelSearches(this);
  late final ChannelSearchVsChannels channelSearchVsChannels =
      ChannelSearchVsChannels(this);
  late final VideoSearches videoSearches = VideoSearches(this);
  late final VideoSearchVsVideos videoSearchVsVideos = VideoSearchVsVideos(
    this,
  );
  late final Collections collections = Collections(this);
  late final Series series = Series(this);
  late final SeriesVsVideos seriesVsVideos = SeriesVsVideos(this);
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
  @override
  int get schemaVersion => 1;
}
