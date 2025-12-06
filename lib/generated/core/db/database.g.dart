// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../core/db/database.dart';

// ignore_for_file: type=lint
class $VideoMetaTable extends VideoMeta
    with TableInfo<$VideoMetaTable, VideoMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoMetaTable(this.attachedDatabase, [this._alias]);
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, etag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    } else if (isInserting) {
      context.missing(_etagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoMetaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      etag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etag'],
      )!,
    );
  }

  @override
  $VideoMetaTable createAlias(String alias) {
    return $VideoMetaTable(attachedDatabase, alias);
  }
}

class VideoMetaData extends DataClass implements Insertable<VideoMetaData> {
  final String id;
  final String etag;
  const VideoMetaData({required this.id, required this.etag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['etag'] = Variable<String>(etag);
    return map;
  }

  VideoMetaCompanion toCompanion(bool nullToAbsent) {
    return VideoMetaCompanion(id: Value(id), etag: Value(etag));
  }

  factory VideoMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoMetaData(
      id: serializer.fromJson<String>(json['id']),
      etag: serializer.fromJson<String>(json['etag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'etag': serializer.toJson<String>(etag),
    };
  }

  VideoMetaData copyWith({String? id, String? etag}) =>
      VideoMetaData(id: id ?? this.id, etag: etag ?? this.etag);
  VideoMetaData copyWithCompanion(VideoMetaCompanion data) {
    return VideoMetaData(
      id: data.id.present ? data.id.value : this.id,
      etag: data.etag.present ? data.etag.value : this.etag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoMetaData(')
          ..write('id: $id, ')
          ..write('etag: $etag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, etag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoMetaData &&
          other.id == this.id &&
          other.etag == this.etag);
}

class VideoMetaCompanion extends UpdateCompanion<VideoMetaData> {
  final Value<String> id;
  final Value<String> etag;
  final Value<int> rowid;
  const VideoMetaCompanion({
    this.id = const Value.absent(),
    this.etag = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoMetaCompanion.insert({
    required String id,
    required String etag,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       etag = Value(etag);
  static Insertable<VideoMetaData> custom({
    Expression<String>? id,
    Expression<String>? etag,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (etag != null) 'etag': etag,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoMetaCompanion copyWith({
    Value<String>? id,
    Value<String>? etag,
    Value<int>? rowid,
  }) {
    return VideoMetaCompanion(
      id: id ?? this.id,
      etag: etag ?? this.etag,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    return (StringBuffer('VideoMetaCompanion(')
          ..write('id: $id, ')
          ..write('etag: $etag, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VideoSnippetTable extends VideoSnippet
    with TableInfo<$VideoSnippetTable, VideoSnippetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoSnippetTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES video_meta (id)',
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
  static const VerificationMeta _liveBroadcastContentMeta =
      const VerificationMeta('liveBroadcastContent');
  @override
  late final GeneratedColumn<String> liveBroadcastContent =
      GeneratedColumn<String>(
        'live_broadcast_content',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    publishedAt,
    channelId,
    title,
    description,
    channelTitle,
    liveBroadcastContent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_snippet';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoSnippetData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('channel_id')) {
      context.handle(
        _channelIdMeta,
        channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_channelIdMeta);
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
    if (data.containsKey('live_broadcast_content')) {
      context.handle(
        _liveBroadcastContentMeta,
        liveBroadcastContent.isAcceptableOrUnknown(
          data['live_broadcast_content']!,
          _liveBroadcastContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_liveBroadcastContentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoSnippetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoSnippetData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      )!,
      channelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel_id'],
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
      liveBroadcastContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}live_broadcast_content'],
      )!,
    );
  }

  @override
  $VideoSnippetTable createAlias(String alias) {
    return $VideoSnippetTable(attachedDatabase, alias);
  }
}

class VideoSnippetData extends DataClass
    implements Insertable<VideoSnippetData> {
  final String id;
  final DateTime publishedAt;
  final String channelId;
  final String title;
  final String description;
  final String channelTitle;
  final String liveBroadcastContent;
  const VideoSnippetData({
    required this.id,
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.channelTitle,
    required this.liveBroadcastContent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['published_at'] = Variable<DateTime>(publishedAt);
    map['channel_id'] = Variable<String>(channelId);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['channel_title'] = Variable<String>(channelTitle);
    map['live_broadcast_content'] = Variable<String>(liveBroadcastContent);
    return map;
  }

  VideoSnippetCompanion toCompanion(bool nullToAbsent) {
    return VideoSnippetCompanion(
      id: Value(id),
      publishedAt: Value(publishedAt),
      channelId: Value(channelId),
      title: Value(title),
      description: Value(description),
      channelTitle: Value(channelTitle),
      liveBroadcastContent: Value(liveBroadcastContent),
    );
  }

  factory VideoSnippetData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoSnippetData(
      id: serializer.fromJson<String>(json['id']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      channelId: serializer.fromJson<String>(json['channelId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      channelTitle: serializer.fromJson<String>(json['channelTitle']),
      liveBroadcastContent: serializer.fromJson<String>(
        json['liveBroadcastContent'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'channelId': serializer.toJson<String>(channelId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'channelTitle': serializer.toJson<String>(channelTitle),
      'liveBroadcastContent': serializer.toJson<String>(liveBroadcastContent),
    };
  }

  VideoSnippetData copyWith({
    String? id,
    DateTime? publishedAt,
    String? channelId,
    String? title,
    String? description,
    String? channelTitle,
    String? liveBroadcastContent,
  }) => VideoSnippetData(
    id: id ?? this.id,
    publishedAt: publishedAt ?? this.publishedAt,
    channelId: channelId ?? this.channelId,
    title: title ?? this.title,
    description: description ?? this.description,
    channelTitle: channelTitle ?? this.channelTitle,
    liveBroadcastContent: liveBroadcastContent ?? this.liveBroadcastContent,
  );
  VideoSnippetData copyWithCompanion(VideoSnippetCompanion data) {
    return VideoSnippetData(
      id: data.id.present ? data.id.value : this.id,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      channelTitle: data.channelTitle.present
          ? data.channelTitle.value
          : this.channelTitle,
      liveBroadcastContent: data.liveBroadcastContent.present
          ? data.liveBroadcastContent.value
          : this.liveBroadcastContent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoSnippetData(')
          ..write('id: $id, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('channelId: $channelId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('channelTitle: $channelTitle, ')
          ..write('liveBroadcastContent: $liveBroadcastContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    publishedAt,
    channelId,
    title,
    description,
    channelTitle,
    liveBroadcastContent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoSnippetData &&
          other.id == this.id &&
          other.publishedAt == this.publishedAt &&
          other.channelId == this.channelId &&
          other.title == this.title &&
          other.description == this.description &&
          other.channelTitle == this.channelTitle &&
          other.liveBroadcastContent == this.liveBroadcastContent);
}

class VideoSnippetCompanion extends UpdateCompanion<VideoSnippetData> {
  final Value<String> id;
  final Value<DateTime> publishedAt;
  final Value<String> channelId;
  final Value<String> title;
  final Value<String> description;
  final Value<String> channelTitle;
  final Value<String> liveBroadcastContent;
  final Value<int> rowid;
  const VideoSnippetCompanion({
    this.id = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.channelId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.channelTitle = const Value.absent(),
    this.liveBroadcastContent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoSnippetCompanion.insert({
    required String id,
    required DateTime publishedAt,
    required String channelId,
    required String title,
    required String description,
    required String channelTitle,
    required String liveBroadcastContent,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       publishedAt = Value(publishedAt),
       channelId = Value(channelId),
       title = Value(title),
       description = Value(description),
       channelTitle = Value(channelTitle),
       liveBroadcastContent = Value(liveBroadcastContent);
  static Insertable<VideoSnippetData> custom({
    Expression<String>? id,
    Expression<DateTime>? publishedAt,
    Expression<String>? channelId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? channelTitle,
    Expression<String>? liveBroadcastContent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (publishedAt != null) 'published_at': publishedAt,
      if (channelId != null) 'channel_id': channelId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (channelTitle != null) 'channel_title': channelTitle,
      if (liveBroadcastContent != null)
        'live_broadcast_content': liveBroadcastContent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoSnippetCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? publishedAt,
    Value<String>? channelId,
    Value<String>? title,
    Value<String>? description,
    Value<String>? channelTitle,
    Value<String>? liveBroadcastContent,
    Value<int>? rowid,
  }) {
    return VideoSnippetCompanion(
      id: id ?? this.id,
      publishedAt: publishedAt ?? this.publishedAt,
      channelId: channelId ?? this.channelId,
      title: title ?? this.title,
      description: description ?? this.description,
      channelTitle: channelTitle ?? this.channelTitle,
      liveBroadcastContent: liveBroadcastContent ?? this.liveBroadcastContent,
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
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
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
    if (liveBroadcastContent.present) {
      map['live_broadcast_content'] = Variable<String>(
        liveBroadcastContent.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoSnippetCompanion(')
          ..write('id: $id, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('channelId: $channelId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('channelTitle: $channelTitle, ')
          ..write('liveBroadcastContent: $liveBroadcastContent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VideoThumbnailTable extends VideoThumbnail
    with TableInfo<$VideoThumbnailTable, VideoThumbnailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoThumbnailTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES video_meta (id)',
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
  static const String $name = 'video_thumbnail';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoThumbnailData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
  VideoThumbnailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoThumbnailData(
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
  $VideoThumbnailTable createAlias(String alias) {
    return $VideoThumbnailTable(attachedDatabase, alias);
  }
}

class VideoThumbnailData extends DataClass
    implements Insertable<VideoThumbnailData> {
  final String id;
  final String defaultUrl;
  final String mediumUrl;
  final String highUrl;
  final String? standardUrl;
  final String? maxresUrl;
  const VideoThumbnailData({
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

  VideoThumbnailCompanion toCompanion(bool nullToAbsent) {
    return VideoThumbnailCompanion(
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

  factory VideoThumbnailData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoThumbnailData(
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

  VideoThumbnailData copyWith({
    String? id,
    String? defaultUrl,
    String? mediumUrl,
    String? highUrl,
    Value<String?> standardUrl = const Value.absent(),
    Value<String?> maxresUrl = const Value.absent(),
  }) => VideoThumbnailData(
    id: id ?? this.id,
    defaultUrl: defaultUrl ?? this.defaultUrl,
    mediumUrl: mediumUrl ?? this.mediumUrl,
    highUrl: highUrl ?? this.highUrl,
    standardUrl: standardUrl.present ? standardUrl.value : this.standardUrl,
    maxresUrl: maxresUrl.present ? maxresUrl.value : this.maxresUrl,
  );
  VideoThumbnailData copyWithCompanion(VideoThumbnailCompanion data) {
    return VideoThumbnailData(
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
    return (StringBuffer('VideoThumbnailData(')
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
      (other is VideoThumbnailData &&
          other.id == this.id &&
          other.defaultUrl == this.defaultUrl &&
          other.mediumUrl == this.mediumUrl &&
          other.highUrl == this.highUrl &&
          other.standardUrl == this.standardUrl &&
          other.maxresUrl == this.maxresUrl);
}

class VideoThumbnailCompanion extends UpdateCompanion<VideoThumbnailData> {
  final Value<String> id;
  final Value<String> defaultUrl;
  final Value<String> mediumUrl;
  final Value<String> highUrl;
  final Value<String?> standardUrl;
  final Value<String?> maxresUrl;
  final Value<int> rowid;
  const VideoThumbnailCompanion({
    this.id = const Value.absent(),
    this.defaultUrl = const Value.absent(),
    this.mediumUrl = const Value.absent(),
    this.highUrl = const Value.absent(),
    this.standardUrl = const Value.absent(),
    this.maxresUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoThumbnailCompanion.insert({
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
  static Insertable<VideoThumbnailData> custom({
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

  VideoThumbnailCompanion copyWith({
    Value<String>? id,
    Value<String>? defaultUrl,
    Value<String>? mediumUrl,
    Value<String>? highUrl,
    Value<String?>? standardUrl,
    Value<String?>? maxresUrl,
    Value<int>? rowid,
  }) {
    return VideoThumbnailCompanion(
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
    return (StringBuffer('VideoThumbnailCompanion(')
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

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $VideoMetaTable videoMeta = $VideoMetaTable(this);
  late final $VideoSnippetTable videoSnippet = $VideoSnippetTable(this);
  late final $VideoThumbnailTable videoThumbnail = $VideoThumbnailTable(this);
  late final Index indexEtag = Index(
    'index_etag',
    'CREATE INDEX index_etag ON video_meta (etag)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    videoMeta,
    videoSnippet,
    videoThumbnail,
    indexEtag,
  ];
}

typedef $$VideoMetaTableCreateCompanionBuilder =
    VideoMetaCompanion Function({
      required String id,
      required String etag,
      Value<int> rowid,
    });
typedef $$VideoMetaTableUpdateCompanionBuilder =
    VideoMetaCompanion Function({
      Value<String> id,
      Value<String> etag,
      Value<int> rowid,
    });

final class $$VideoMetaTableReferences
    extends BaseReferences<_$Database, $VideoMetaTable, VideoMetaData> {
  $$VideoMetaTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VideoSnippetTable, List<VideoSnippetData>>
  _videoSnippetRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.videoSnippet,
    aliasName: $_aliasNameGenerator(db.videoMeta.id, db.videoSnippet.id),
  );

  $$VideoSnippetTableProcessedTableManager get videoSnippetRefs {
    final manager = $$VideoSnippetTableTableManager(
      $_db,
      $_db.videoSnippet,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_videoSnippetRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VideoThumbnailTable, List<VideoThumbnailData>>
  _videoThumbnailRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.videoThumbnail,
    aliasName: $_aliasNameGenerator(db.videoMeta.id, db.videoThumbnail.id),
  );

  $$VideoThumbnailTableProcessedTableManager get videoThumbnailRefs {
    final manager = $$VideoThumbnailTableTableManager(
      $_db,
      $_db.videoThumbnail,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_videoThumbnailRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VideoMetaTableFilterComposer
    extends Composer<_$Database, $VideoMetaTable> {
  $$VideoMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> videoSnippetRefs(
    Expression<bool> Function($$VideoSnippetTableFilterComposer f) f,
  ) {
    final $$VideoSnippetTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoSnippet,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoSnippetTableFilterComposer(
            $db: $db,
            $table: $db.videoSnippet,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> videoThumbnailRefs(
    Expression<bool> Function($$VideoThumbnailTableFilterComposer f) f,
  ) {
    final $$VideoThumbnailTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoThumbnail,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoThumbnailTableFilterComposer(
            $db: $db,
            $table: $db.videoThumbnail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VideoMetaTableOrderingComposer
    extends Composer<_$Database, $VideoMetaTable> {
  $$VideoMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VideoMetaTableAnnotationComposer
    extends Composer<_$Database, $VideoMetaTable> {
  $$VideoMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get etag =>
      $composableBuilder(column: $table.etag, builder: (column) => column);

  Expression<T> videoSnippetRefs<T extends Object>(
    Expression<T> Function($$VideoSnippetTableAnnotationComposer a) f,
  ) {
    final $$VideoSnippetTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoSnippet,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoSnippetTableAnnotationComposer(
            $db: $db,
            $table: $db.videoSnippet,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> videoThumbnailRefs<T extends Object>(
    Expression<T> Function($$VideoThumbnailTableAnnotationComposer a) f,
  ) {
    final $$VideoThumbnailTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoThumbnail,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoThumbnailTableAnnotationComposer(
            $db: $db,
            $table: $db.videoThumbnail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VideoMetaTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoMetaTable,
          VideoMetaData,
          $$VideoMetaTableFilterComposer,
          $$VideoMetaTableOrderingComposer,
          $$VideoMetaTableAnnotationComposer,
          $$VideoMetaTableCreateCompanionBuilder,
          $$VideoMetaTableUpdateCompanionBuilder,
          (VideoMetaData, $$VideoMetaTableReferences),
          VideoMetaData,
          PrefetchHooks Function({
            bool videoSnippetRefs,
            bool videoThumbnailRefs,
          })
        > {
  $$VideoMetaTableTableManager(_$Database db, $VideoMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> etag = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoMetaCompanion(id: id, etag: etag, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String etag,
                Value<int> rowid = const Value.absent(),
              }) => VideoMetaCompanion.insert(id: id, etag: etag, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VideoMetaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({videoSnippetRefs = false, videoThumbnailRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (videoSnippetRefs) db.videoSnippet,
                    if (videoThumbnailRefs) db.videoThumbnail,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (videoSnippetRefs)
                        await $_getPrefetchedData<
                          VideoMetaData,
                          $VideoMetaTable,
                          VideoSnippetData
                        >(
                          currentTable: table,
                          referencedTable: $$VideoMetaTableReferences
                              ._videoSnippetRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideoMetaTableReferences(
                                db,
                                table,
                                p0,
                              ).videoSnippetRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (videoThumbnailRefs)
                        await $_getPrefetchedData<
                          VideoMetaData,
                          $VideoMetaTable,
                          VideoThumbnailData
                        >(
                          currentTable: table,
                          referencedTable: $$VideoMetaTableReferences
                              ._videoThumbnailRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VideoMetaTableReferences(
                                db,
                                table,
                                p0,
                              ).videoThumbnailRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VideoMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoMetaTable,
      VideoMetaData,
      $$VideoMetaTableFilterComposer,
      $$VideoMetaTableOrderingComposer,
      $$VideoMetaTableAnnotationComposer,
      $$VideoMetaTableCreateCompanionBuilder,
      $$VideoMetaTableUpdateCompanionBuilder,
      (VideoMetaData, $$VideoMetaTableReferences),
      VideoMetaData,
      PrefetchHooks Function({bool videoSnippetRefs, bool videoThumbnailRefs})
    >;
typedef $$VideoSnippetTableCreateCompanionBuilder =
    VideoSnippetCompanion Function({
      required String id,
      required DateTime publishedAt,
      required String channelId,
      required String title,
      required String description,
      required String channelTitle,
      required String liveBroadcastContent,
      Value<int> rowid,
    });
typedef $$VideoSnippetTableUpdateCompanionBuilder =
    VideoSnippetCompanion Function({
      Value<String> id,
      Value<DateTime> publishedAt,
      Value<String> channelId,
      Value<String> title,
      Value<String> description,
      Value<String> channelTitle,
      Value<String> liveBroadcastContent,
      Value<int> rowid,
    });

final class $$VideoSnippetTableReferences
    extends BaseReferences<_$Database, $VideoSnippetTable, VideoSnippetData> {
  $$VideoSnippetTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VideoMetaTable _idTable(_$Database db) => db.videoMeta.createAlias(
    $_aliasNameGenerator(db.videoSnippet.id, db.videoMeta.id),
  );

  $$VideoMetaTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$VideoMetaTableTableManager(
      $_db,
      $_db.videoMeta,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VideoSnippetTableFilterComposer
    extends Composer<_$Database, $VideoSnippetTable> {
  $$VideoSnippetTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channelId => $composableBuilder(
    column: $table.channelId,
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

  ColumnFilters<String> get liveBroadcastContent => $composableBuilder(
    column: $table.liveBroadcastContent,
    builder: (column) => ColumnFilters(column),
  );

  $$VideoMetaTableFilterComposer get id {
    final $$VideoMetaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoMeta,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoMetaTableFilterComposer(
            $db: $db,
            $table: $db.videoMeta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoSnippetTableOrderingComposer
    extends Composer<_$Database, $VideoSnippetTable> {
  $$VideoSnippetTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channelId => $composableBuilder(
    column: $table.channelId,
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

  ColumnOrderings<String> get liveBroadcastContent => $composableBuilder(
    column: $table.liveBroadcastContent,
    builder: (column) => ColumnOrderings(column),
  );

  $$VideoMetaTableOrderingComposer get id {
    final $$VideoMetaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoMeta,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoMetaTableOrderingComposer(
            $db: $db,
            $table: $db.videoMeta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoSnippetTableAnnotationComposer
    extends Composer<_$Database, $VideoSnippetTable> {
  $$VideoSnippetTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get channelId =>
      $composableBuilder(column: $table.channelId, builder: (column) => column);

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

  GeneratedColumn<String> get liveBroadcastContent => $composableBuilder(
    column: $table.liveBroadcastContent,
    builder: (column) => column,
  );

  $$VideoMetaTableAnnotationComposer get id {
    final $$VideoMetaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoMeta,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoMetaTableAnnotationComposer(
            $db: $db,
            $table: $db.videoMeta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoSnippetTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoSnippetTable,
          VideoSnippetData,
          $$VideoSnippetTableFilterComposer,
          $$VideoSnippetTableOrderingComposer,
          $$VideoSnippetTableAnnotationComposer,
          $$VideoSnippetTableCreateCompanionBuilder,
          $$VideoSnippetTableUpdateCompanionBuilder,
          (VideoSnippetData, $$VideoSnippetTableReferences),
          VideoSnippetData,
          PrefetchHooks Function({bool id})
        > {
  $$VideoSnippetTableTableManager(_$Database db, $VideoSnippetTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoSnippetTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoSnippetTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoSnippetTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> publishedAt = const Value.absent(),
                Value<String> channelId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> channelTitle = const Value.absent(),
                Value<String> liveBroadcastContent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoSnippetCompanion(
                id: id,
                publishedAt: publishedAt,
                channelId: channelId,
                title: title,
                description: description,
                channelTitle: channelTitle,
                liveBroadcastContent: liveBroadcastContent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime publishedAt,
                required String channelId,
                required String title,
                required String description,
                required String channelTitle,
                required String liveBroadcastContent,
                Value<int> rowid = const Value.absent(),
              }) => VideoSnippetCompanion.insert(
                id: id,
                publishedAt: publishedAt,
                channelId: channelId,
                title: title,
                description: description,
                channelTitle: channelTitle,
                liveBroadcastContent: liveBroadcastContent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VideoSnippetTableReferences(db, table, e),
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
                                referencedTable: $$VideoSnippetTableReferences
                                    ._idTable(db),
                                referencedColumn: $$VideoSnippetTableReferences
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

typedef $$VideoSnippetTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoSnippetTable,
      VideoSnippetData,
      $$VideoSnippetTableFilterComposer,
      $$VideoSnippetTableOrderingComposer,
      $$VideoSnippetTableAnnotationComposer,
      $$VideoSnippetTableCreateCompanionBuilder,
      $$VideoSnippetTableUpdateCompanionBuilder,
      (VideoSnippetData, $$VideoSnippetTableReferences),
      VideoSnippetData,
      PrefetchHooks Function({bool id})
    >;
typedef $$VideoThumbnailTableCreateCompanionBuilder =
    VideoThumbnailCompanion Function({
      required String id,
      required String defaultUrl,
      required String mediumUrl,
      required String highUrl,
      Value<String?> standardUrl,
      Value<String?> maxresUrl,
      Value<int> rowid,
    });
typedef $$VideoThumbnailTableUpdateCompanionBuilder =
    VideoThumbnailCompanion Function({
      Value<String> id,
      Value<String> defaultUrl,
      Value<String> mediumUrl,
      Value<String> highUrl,
      Value<String?> standardUrl,
      Value<String?> maxresUrl,
      Value<int> rowid,
    });

final class $$VideoThumbnailTableReferences
    extends
        BaseReferences<_$Database, $VideoThumbnailTable, VideoThumbnailData> {
  $$VideoThumbnailTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VideoMetaTable _idTable(_$Database db) => db.videoMeta.createAlias(
    $_aliasNameGenerator(db.videoThumbnail.id, db.videoMeta.id),
  );

  $$VideoMetaTableProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $$VideoMetaTableTableManager(
      $_db,
      $_db.videoMeta,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VideoThumbnailTableFilterComposer
    extends Composer<_$Database, $VideoThumbnailTable> {
  $$VideoThumbnailTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
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

  $$VideoMetaTableFilterComposer get id {
    final $$VideoMetaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoMeta,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoMetaTableFilterComposer(
            $db: $db,
            $table: $db.videoMeta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoThumbnailTableOrderingComposer
    extends Composer<_$Database, $VideoThumbnailTable> {
  $$VideoThumbnailTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
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

  $$VideoMetaTableOrderingComposer get id {
    final $$VideoMetaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoMeta,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoMetaTableOrderingComposer(
            $db: $db,
            $table: $db.videoMeta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoThumbnailTableAnnotationComposer
    extends Composer<_$Database, $VideoThumbnailTable> {
  $$VideoThumbnailTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
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

  $$VideoMetaTableAnnotationComposer get id {
    final $$VideoMetaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoMeta,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoMetaTableAnnotationComposer(
            $db: $db,
            $table: $db.videoMeta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoThumbnailTableTableManager
    extends
        RootTableManager<
          _$Database,
          $VideoThumbnailTable,
          VideoThumbnailData,
          $$VideoThumbnailTableFilterComposer,
          $$VideoThumbnailTableOrderingComposer,
          $$VideoThumbnailTableAnnotationComposer,
          $$VideoThumbnailTableCreateCompanionBuilder,
          $$VideoThumbnailTableUpdateCompanionBuilder,
          (VideoThumbnailData, $$VideoThumbnailTableReferences),
          VideoThumbnailData,
          PrefetchHooks Function({bool id})
        > {
  $$VideoThumbnailTableTableManager(_$Database db, $VideoThumbnailTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoThumbnailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoThumbnailTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoThumbnailTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> defaultUrl = const Value.absent(),
                Value<String> mediumUrl = const Value.absent(),
                Value<String> highUrl = const Value.absent(),
                Value<String?> standardUrl = const Value.absent(),
                Value<String?> maxresUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoThumbnailCompanion(
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
                required String id,
                required String defaultUrl,
                required String mediumUrl,
                required String highUrl,
                Value<String?> standardUrl = const Value.absent(),
                Value<String?> maxresUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VideoThumbnailCompanion.insert(
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
                  $$VideoThumbnailTableReferences(db, table, e),
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
                                referencedTable: $$VideoThumbnailTableReferences
                                    ._idTable(db),
                                referencedColumn:
                                    $$VideoThumbnailTableReferences
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

typedef $$VideoThumbnailTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $VideoThumbnailTable,
      VideoThumbnailData,
      $$VideoThumbnailTableFilterComposer,
      $$VideoThumbnailTableOrderingComposer,
      $$VideoThumbnailTableAnnotationComposer,
      $$VideoThumbnailTableCreateCompanionBuilder,
      $$VideoThumbnailTableUpdateCompanionBuilder,
      (VideoThumbnailData, $$VideoThumbnailTableReferences),
      VideoThumbnailData,
      PrefetchHooks Function({bool id})
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$VideoMetaTableTableManager get videoMeta =>
      $$VideoMetaTableTableManager(_db, _db.videoMeta);
  $$VideoSnippetTableTableManager get videoSnippet =>
      $$VideoSnippetTableTableManager(_db, _db.videoSnippet);
  $$VideoThumbnailTableTableManager get videoThumbnail =>
      $$VideoThumbnailTableTableManager(_db, _db.videoThumbnail);
}
