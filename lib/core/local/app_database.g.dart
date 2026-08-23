// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DoctorsTableTable extends DoctorsTable
    with TableInfo<$DoctorsTableTable, DoctorsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoctorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _qualificationMeta = const VerificationMeta(
    'qualification',
  );
  @override
  late final GeneratedColumn<String> qualification = GeneratedColumn<String>(
    'qualification',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _experienceMeta = const VerificationMeta(
    'experience',
  );
  @override
  late final GeneratedColumn<int> experience = GeneratedColumn<int>(
    'experience',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _specialtyMeta = const VerificationMeta(
    'specialty',
  );
  @override
  late final GeneratedColumn<String> specialty = GeneratedColumn<String>(
    'specialty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workingDaysMeta = const VerificationMeta(
    'workingDays',
  );
  @override
  late final GeneratedColumn<String> workingDays = GeneratedColumn<String>(
    'working_days',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
    'start_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxTokensPerDayMeta = const VerificationMeta(
    'maxTokensPerDay',
  );
  @override
  late final GeneratedColumn<int> maxTokensPerDay = GeneratedColumn<int>(
    'max_tokens_per_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clinicNameMeta = const VerificationMeta(
    'clinicName',
  );
  @override
  late final GeneratedColumn<String> clinicName = GeneratedColumn<String>(
    'clinic_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isInterestedMeta = const VerificationMeta(
    'isInterested',
  );
  @override
  late final GeneratedColumn<bool> isInterested = GeneratedColumn<bool>(
    'is_interested',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_interested" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _aboutMeta = const VerificationMeta('about');
  @override
  late final GeneratedColumn<String> about = GeneratedColumn<String>(
    'about',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clinicId,
    name,
    qualification,
    experience,
    specialty,
    price,
    durationMinutes,
    workingDays,
    startTime,
    endTime,
    maxTokensPerDay,
    rating,
    photoUrl,
    clinicName,
    reviewCount,
    isInterested,
    isAvailable,
    about,
    location,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'doctors_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DoctorsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('qualification')) {
      context.handle(
        _qualificationMeta,
        qualification.isAcceptableOrUnknown(
          data['qualification']!,
          _qualificationMeta,
        ),
      );
    }
    if (data.containsKey('experience')) {
      context.handle(
        _experienceMeta,
        experience.isAcceptableOrUnknown(data['experience']!, _experienceMeta),
      );
    }
    if (data.containsKey('specialty')) {
      context.handle(
        _specialtyMeta,
        specialty.isAcceptableOrUnknown(data['specialty']!, _specialtyMeta),
      );
    } else if (isInserting) {
      context.missing(_specialtyMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('working_days')) {
      context.handle(
        _workingDaysMeta,
        workingDays.isAcceptableOrUnknown(
          data['working_days']!,
          _workingDaysMeta,
        ),
      );
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('max_tokens_per_day')) {
      context.handle(
        _maxTokensPerDayMeta,
        maxTokensPerDay.isAcceptableOrUnknown(
          data['max_tokens_per_day']!,
          _maxTokensPerDayMeta,
        ),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('clinic_name')) {
      context.handle(
        _clinicNameMeta,
        clinicName.isAcceptableOrUnknown(data['clinic_name']!, _clinicNameMeta),
      );
    } else if (isInserting) {
      context.missing(_clinicNameMeta);
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reviewCountMeta);
    }
    if (data.containsKey('is_interested')) {
      context.handle(
        _isInterestedMeta,
        isInterested.isAcceptableOrUnknown(
          data['is_interested']!,
          _isInterestedMeta,
        ),
      );
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    }
    if (data.containsKey('about')) {
      context.handle(
        _aboutMeta,
        about.isAcceptableOrUnknown(data['about']!, _aboutMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DoctorsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoctorsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      qualification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qualification'],
      ),
      experience: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}experience'],
      ),
      specialty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}specialty'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      workingDays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}working_days'],
      ),
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_time'],
      ),
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_time'],
      ),
      maxTokensPerDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_tokens_per_day'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      clinicName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_name'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      isInterested: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_interested'],
      )!,
      isAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_available'],
      )!,
      about: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}about'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $DoctorsTableTable createAlias(String alias) {
    return $DoctorsTableTable(attachedDatabase, alias);
  }
}

class DoctorsTableData extends DataClass
    implements Insertable<DoctorsTableData> {
  final String id;
  final String? clinicId;
  final String name;
  final String? qualification;
  final int? experience;
  final String specialty;
  final double price;
  final int durationMinutes;
  final String? workingDays;
  final String? startTime;
  final String? endTime;
  final int? maxTokensPerDay;
  final double rating;
  final String? photoUrl;
  final String clinicName;
  final int reviewCount;
  final bool isInterested;
  final bool isAvailable;
  final String? about;
  final String? location;
  final DateTime cachedAt;
  const DoctorsTableData({
    required this.id,
    this.clinicId,
    required this.name,
    this.qualification,
    this.experience,
    required this.specialty,
    required this.price,
    required this.durationMinutes,
    this.workingDays,
    this.startTime,
    this.endTime,
    this.maxTokensPerDay,
    required this.rating,
    this.photoUrl,
    required this.clinicName,
    required this.reviewCount,
    required this.isInterested,
    required this.isAvailable,
    this.about,
    this.location,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || clinicId != null) {
      map['clinic_id'] = Variable<String>(clinicId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || qualification != null) {
      map['qualification'] = Variable<String>(qualification);
    }
    if (!nullToAbsent || experience != null) {
      map['experience'] = Variable<int>(experience);
    }
    map['specialty'] = Variable<String>(specialty);
    map['price'] = Variable<double>(price);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || workingDays != null) {
      map['working_days'] = Variable<String>(workingDays);
    }
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<String>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<String>(endTime);
    }
    if (!nullToAbsent || maxTokensPerDay != null) {
      map['max_tokens_per_day'] = Variable<int>(maxTokensPerDay);
    }
    map['rating'] = Variable<double>(rating);
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['clinic_name'] = Variable<String>(clinicName);
    map['review_count'] = Variable<int>(reviewCount);
    map['is_interested'] = Variable<bool>(isInterested);
    map['is_available'] = Variable<bool>(isAvailable);
    if (!nullToAbsent || about != null) {
      map['about'] = Variable<String>(about);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  DoctorsTableCompanion toCompanion(bool nullToAbsent) {
    return DoctorsTableCompanion(
      id: Value(id),
      clinicId: clinicId == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicId),
      name: Value(name),
      qualification: qualification == null && nullToAbsent
          ? const Value.absent()
          : Value(qualification),
      experience: experience == null && nullToAbsent
          ? const Value.absent()
          : Value(experience),
      specialty: Value(specialty),
      price: Value(price),
      durationMinutes: Value(durationMinutes),
      workingDays: workingDays == null && nullToAbsent
          ? const Value.absent()
          : Value(workingDays),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      maxTokensPerDay: maxTokensPerDay == null && nullToAbsent
          ? const Value.absent()
          : Value(maxTokensPerDay),
      rating: Value(rating),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      clinicName: Value(clinicName),
      reviewCount: Value(reviewCount),
      isInterested: Value(isInterested),
      isAvailable: Value(isAvailable),
      about: about == null && nullToAbsent
          ? const Value.absent()
          : Value(about),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      cachedAt: Value(cachedAt),
    );
  }

  factory DoctorsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoctorsTableData(
      id: serializer.fromJson<String>(json['id']),
      clinicId: serializer.fromJson<String?>(json['clinicId']),
      name: serializer.fromJson<String>(json['name']),
      qualification: serializer.fromJson<String?>(json['qualification']),
      experience: serializer.fromJson<int?>(json['experience']),
      specialty: serializer.fromJson<String>(json['specialty']),
      price: serializer.fromJson<double>(json['price']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      workingDays: serializer.fromJson<String?>(json['workingDays']),
      startTime: serializer.fromJson<String?>(json['startTime']),
      endTime: serializer.fromJson<String?>(json['endTime']),
      maxTokensPerDay: serializer.fromJson<int?>(json['maxTokensPerDay']),
      rating: serializer.fromJson<double>(json['rating']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      clinicName: serializer.fromJson<String>(json['clinicName']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      isInterested: serializer.fromJson<bool>(json['isInterested']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      about: serializer.fromJson<String?>(json['about']),
      location: serializer.fromJson<String?>(json['location']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clinicId': serializer.toJson<String?>(clinicId),
      'name': serializer.toJson<String>(name),
      'qualification': serializer.toJson<String?>(qualification),
      'experience': serializer.toJson<int?>(experience),
      'specialty': serializer.toJson<String>(specialty),
      'price': serializer.toJson<double>(price),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'workingDays': serializer.toJson<String?>(workingDays),
      'startTime': serializer.toJson<String?>(startTime),
      'endTime': serializer.toJson<String?>(endTime),
      'maxTokensPerDay': serializer.toJson<int?>(maxTokensPerDay),
      'rating': serializer.toJson<double>(rating),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'clinicName': serializer.toJson<String>(clinicName),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'isInterested': serializer.toJson<bool>(isInterested),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'about': serializer.toJson<String?>(about),
      'location': serializer.toJson<String?>(location),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  DoctorsTableData copyWith({
    String? id,
    Value<String?> clinicId = const Value.absent(),
    String? name,
    Value<String?> qualification = const Value.absent(),
    Value<int?> experience = const Value.absent(),
    String? specialty,
    double? price,
    int? durationMinutes,
    Value<String?> workingDays = const Value.absent(),
    Value<String?> startTime = const Value.absent(),
    Value<String?> endTime = const Value.absent(),
    Value<int?> maxTokensPerDay = const Value.absent(),
    double? rating,
    Value<String?> photoUrl = const Value.absent(),
    String? clinicName,
    int? reviewCount,
    bool? isInterested,
    bool? isAvailable,
    Value<String?> about = const Value.absent(),
    Value<String?> location = const Value.absent(),
    DateTime? cachedAt,
  }) => DoctorsTableData(
    id: id ?? this.id,
    clinicId: clinicId.present ? clinicId.value : this.clinicId,
    name: name ?? this.name,
    qualification: qualification.present
        ? qualification.value
        : this.qualification,
    experience: experience.present ? experience.value : this.experience,
    specialty: specialty ?? this.specialty,
    price: price ?? this.price,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    workingDays: workingDays.present ? workingDays.value : this.workingDays,
    startTime: startTime.present ? startTime.value : this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    maxTokensPerDay: maxTokensPerDay.present
        ? maxTokensPerDay.value
        : this.maxTokensPerDay,
    rating: rating ?? this.rating,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    clinicName: clinicName ?? this.clinicName,
    reviewCount: reviewCount ?? this.reviewCount,
    isInterested: isInterested ?? this.isInterested,
    isAvailable: isAvailable ?? this.isAvailable,
    about: about.present ? about.value : this.about,
    location: location.present ? location.value : this.location,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  DoctorsTableData copyWithCompanion(DoctorsTableCompanion data) {
    return DoctorsTableData(
      id: data.id.present ? data.id.value : this.id,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      name: data.name.present ? data.name.value : this.name,
      qualification: data.qualification.present
          ? data.qualification.value
          : this.qualification,
      experience: data.experience.present
          ? data.experience.value
          : this.experience,
      specialty: data.specialty.present ? data.specialty.value : this.specialty,
      price: data.price.present ? data.price.value : this.price,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      workingDays: data.workingDays.present
          ? data.workingDays.value
          : this.workingDays,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      maxTokensPerDay: data.maxTokensPerDay.present
          ? data.maxTokensPerDay.value
          : this.maxTokensPerDay,
      rating: data.rating.present ? data.rating.value : this.rating,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      clinicName: data.clinicName.present
          ? data.clinicName.value
          : this.clinicName,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      isInterested: data.isInterested.present
          ? data.isInterested.value
          : this.isInterested,
      isAvailable: data.isAvailable.present
          ? data.isAvailable.value
          : this.isAvailable,
      about: data.about.present ? data.about.value : this.about,
      location: data.location.present ? data.location.value : this.location,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoctorsTableData(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('name: $name, ')
          ..write('qualification: $qualification, ')
          ..write('experience: $experience, ')
          ..write('specialty: $specialty, ')
          ..write('price: $price, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('workingDays: $workingDays, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('maxTokensPerDay: $maxTokensPerDay, ')
          ..write('rating: $rating, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('clinicName: $clinicName, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('isInterested: $isInterested, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('about: $about, ')
          ..write('location: $location, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    clinicId,
    name,
    qualification,
    experience,
    specialty,
    price,
    durationMinutes,
    workingDays,
    startTime,
    endTime,
    maxTokensPerDay,
    rating,
    photoUrl,
    clinicName,
    reviewCount,
    isInterested,
    isAvailable,
    about,
    location,
    cachedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoctorsTableData &&
          other.id == this.id &&
          other.clinicId == this.clinicId &&
          other.name == this.name &&
          other.qualification == this.qualification &&
          other.experience == this.experience &&
          other.specialty == this.specialty &&
          other.price == this.price &&
          other.durationMinutes == this.durationMinutes &&
          other.workingDays == this.workingDays &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.maxTokensPerDay == this.maxTokensPerDay &&
          other.rating == this.rating &&
          other.photoUrl == this.photoUrl &&
          other.clinicName == this.clinicName &&
          other.reviewCount == this.reviewCount &&
          other.isInterested == this.isInterested &&
          other.isAvailable == this.isAvailable &&
          other.about == this.about &&
          other.location == this.location &&
          other.cachedAt == this.cachedAt);
}

class DoctorsTableCompanion extends UpdateCompanion<DoctorsTableData> {
  final Value<String> id;
  final Value<String?> clinicId;
  final Value<String> name;
  final Value<String?> qualification;
  final Value<int?> experience;
  final Value<String> specialty;
  final Value<double> price;
  final Value<int> durationMinutes;
  final Value<String?> workingDays;
  final Value<String?> startTime;
  final Value<String?> endTime;
  final Value<int?> maxTokensPerDay;
  final Value<double> rating;
  final Value<String?> photoUrl;
  final Value<String> clinicName;
  final Value<int> reviewCount;
  final Value<bool> isInterested;
  final Value<bool> isAvailable;
  final Value<String?> about;
  final Value<String?> location;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const DoctorsTableCompanion({
    this.id = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.name = const Value.absent(),
    this.qualification = const Value.absent(),
    this.experience = const Value.absent(),
    this.specialty = const Value.absent(),
    this.price = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.workingDays = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.maxTokensPerDay = const Value.absent(),
    this.rating = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.clinicName = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.isInterested = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.about = const Value.absent(),
    this.location = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DoctorsTableCompanion.insert({
    required String id,
    this.clinicId = const Value.absent(),
    required String name,
    this.qualification = const Value.absent(),
    this.experience = const Value.absent(),
    required String specialty,
    required double price,
    required int durationMinutes,
    this.workingDays = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.maxTokensPerDay = const Value.absent(),
    required double rating,
    this.photoUrl = const Value.absent(),
    required String clinicName,
    required int reviewCount,
    this.isInterested = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.about = const Value.absent(),
    this.location = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       specialty = Value(specialty),
       price = Value(price),
       durationMinutes = Value(durationMinutes),
       rating = Value(rating),
       clinicName = Value(clinicName),
       reviewCount = Value(reviewCount),
       cachedAt = Value(cachedAt);
  static Insertable<DoctorsTableData> custom({
    Expression<String>? id,
    Expression<String>? clinicId,
    Expression<String>? name,
    Expression<String>? qualification,
    Expression<int>? experience,
    Expression<String>? specialty,
    Expression<double>? price,
    Expression<int>? durationMinutes,
    Expression<String>? workingDays,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<int>? maxTokensPerDay,
    Expression<double>? rating,
    Expression<String>? photoUrl,
    Expression<String>? clinicName,
    Expression<int>? reviewCount,
    Expression<bool>? isInterested,
    Expression<bool>? isAvailable,
    Expression<String>? about,
    Expression<String>? location,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicId != null) 'clinic_id': clinicId,
      if (name != null) 'name': name,
      if (qualification != null) 'qualification': qualification,
      if (experience != null) 'experience': experience,
      if (specialty != null) 'specialty': specialty,
      if (price != null) 'price': price,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (workingDays != null) 'working_days': workingDays,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (maxTokensPerDay != null) 'max_tokens_per_day': maxTokensPerDay,
      if (rating != null) 'rating': rating,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (clinicName != null) 'clinic_name': clinicName,
      if (reviewCount != null) 'review_count': reviewCount,
      if (isInterested != null) 'is_interested': isInterested,
      if (isAvailable != null) 'is_available': isAvailable,
      if (about != null) 'about': about,
      if (location != null) 'location': location,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DoctorsTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? clinicId,
    Value<String>? name,
    Value<String?>? qualification,
    Value<int?>? experience,
    Value<String>? specialty,
    Value<double>? price,
    Value<int>? durationMinutes,
    Value<String?>? workingDays,
    Value<String?>? startTime,
    Value<String?>? endTime,
    Value<int?>? maxTokensPerDay,
    Value<double>? rating,
    Value<String?>? photoUrl,
    Value<String>? clinicName,
    Value<int>? reviewCount,
    Value<bool>? isInterested,
    Value<bool>? isAvailable,
    Value<String?>? about,
    Value<String?>? location,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return DoctorsTableCompanion(
      id: id ?? this.id,
      clinicId: clinicId ?? this.clinicId,
      name: name ?? this.name,
      qualification: qualification ?? this.qualification,
      experience: experience ?? this.experience,
      specialty: specialty ?? this.specialty,
      price: price ?? this.price,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      workingDays: workingDays ?? this.workingDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      maxTokensPerDay: maxTokensPerDay ?? this.maxTokensPerDay,
      rating: rating ?? this.rating,
      photoUrl: photoUrl ?? this.photoUrl,
      clinicName: clinicName ?? this.clinicName,
      reviewCount: reviewCount ?? this.reviewCount,
      isInterested: isInterested ?? this.isInterested,
      isAvailable: isAvailable ?? this.isAvailable,
      about: about ?? this.about,
      location: location ?? this.location,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (qualification.present) {
      map['qualification'] = Variable<String>(qualification.value);
    }
    if (experience.present) {
      map['experience'] = Variable<int>(experience.value);
    }
    if (specialty.present) {
      map['specialty'] = Variable<String>(specialty.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (workingDays.present) {
      map['working_days'] = Variable<String>(workingDays.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (maxTokensPerDay.present) {
      map['max_tokens_per_day'] = Variable<int>(maxTokensPerDay.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (clinicName.present) {
      map['clinic_name'] = Variable<String>(clinicName.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (isInterested.present) {
      map['is_interested'] = Variable<bool>(isInterested.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (about.present) {
      map['about'] = Variable<String>(about.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoctorsTableCompanion(')
          ..write('id: $id, ')
          ..write('clinicId: $clinicId, ')
          ..write('name: $name, ')
          ..write('qualification: $qualification, ')
          ..write('experience: $experience, ')
          ..write('specialty: $specialty, ')
          ..write('price: $price, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('workingDays: $workingDays, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('maxTokensPerDay: $maxTokensPerDay, ')
          ..write('rating: $rating, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('clinicName: $clinicName, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('isInterested: $isInterested, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('about: $about, ')
          ..write('location: $location, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClinicsTableTable extends ClinicsTable
    with TableInfo<$ClinicsTableTable, ClinicsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClinicsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _specialtyTagMeta = const VerificationMeta(
    'specialtyTag',
  );
  @override
  late final GeneratedColumn<String> specialtyTag = GeneratedColumn<String>(
    'specialty_tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingHoursMeta = const VerificationMeta(
    'openingHours',
  );
  @override
  late final GeneratedColumn<String> openingHours = GeneratedColumn<String>(
    'opening_hours',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doctorCountMeta = const VerificationMeta(
    'doctorCount',
  );
  @override
  late final GeneratedColumn<int> doctorCount = GeneratedColumn<int>(
    'doctor_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientCountMeta = const VerificationMeta(
    'patientCount',
  );
  @override
  late final GeneratedColumn<String> patientCount = GeneratedColumn<String>(
    'patient_count',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _specialistCountMeta = const VerificationMeta(
    'specialistCount',
  );
  @override
  late final GeneratedColumn<String> specialistCount = GeneratedColumn<String>(
    'specialist_count',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearsExperienceMeta = const VerificationMeta(
    'yearsExperience',
  );
  @override
  late final GeneratedColumn<String> yearsExperience = GeneratedColumn<String>(
    'years_experience',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isOpenMeta = const VerificationMeta('isOpen');
  @override
  late final GeneratedColumn<bool> isOpen = GeneratedColumn<bool>(
    'is_open',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_open" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clinicNameMeta = const VerificationMeta(
    'clinicName',
  );
  @override
  late final GeneratedColumn<String> clinicName = GeneratedColumn<String>(
    'clinic_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taglineMeta = const VerificationMeta(
    'tagline',
  );
  @override
  late final GeneratedColumn<String> tagline = GeneratedColumn<String>(
    'tagline',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _zipCodeMeta = const VerificationMeta(
    'zipCode',
  );
  @override
  late final GeneratedColumn<String> zipCode = GeneratedColumn<String>(
    'zip_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _websiteMeta = const VerificationMeta(
    'website',
  );
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
    'website',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _openTimeMeta = const VerificationMeta(
    'openTime',
  );
  @override
  late final GeneratedColumn<String> openTime = GeneratedColumn<String>(
    'open_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _closeTimeMeta = const VerificationMeta(
    'closeTime',
  );
  @override
  late final GeneratedColumn<String> closeTime = GeneratedColumn<String>(
    'close_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workingDaysMeta = const VerificationMeta(
    'workingDays',
  );
  @override
  late final GeneratedColumn<String> workingDays = GeneratedColumn<String>(
    'working_days',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _specialtiesMeta = const VerificationMeta(
    'specialties',
  );
  @override
  late final GeneratedColumn<String> specialties = GeneratedColumn<String>(
    'specialties',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _facilitiesMeta = const VerificationMeta(
    'facilities',
  );
  @override
  late final GeneratedColumn<String> facilities = GeneratedColumn<String>(
    'facilities',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emergencyServicesMeta = const VerificationMeta(
    'emergencyServices',
  );
  @override
  late final GeneratedColumn<bool> emergencyServices = GeneratedColumn<bool>(
    'emergency_services',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("emergency_services" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    imageUrl,
    specialtyTag,
    rating,
    reviewCount,
    openingHours,
    address,
    doctorCount,
    phone,
    patientCount,
    specialistCount,
    yearsExperience,
    isOpen,
    ownerId,
    clinicName,
    tagline,
    description,
    city,
    state,
    zipCode,
    email,
    website,
    openTime,
    closeTime,
    workingDays,
    specialties,
    facilities,
    emergencyServices,
    createdAt,
    updatedAt,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clinics_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClinicsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('specialty_tag')) {
      context.handle(
        _specialtyTagMeta,
        specialtyTag.isAcceptableOrUnknown(
          data['specialty_tag']!,
          _specialtyTagMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_specialtyTagMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reviewCountMeta);
    }
    if (data.containsKey('opening_hours')) {
      context.handle(
        _openingHoursMeta,
        openingHours.isAcceptableOrUnknown(
          data['opening_hours']!,
          _openingHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingHoursMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('doctor_count')) {
      context.handle(
        _doctorCountMeta,
        doctorCount.isAcceptableOrUnknown(
          data['doctor_count']!,
          _doctorCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_doctorCountMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('patient_count')) {
      context.handle(
        _patientCountMeta,
        patientCount.isAcceptableOrUnknown(
          data['patient_count']!,
          _patientCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_patientCountMeta);
    }
    if (data.containsKey('specialist_count')) {
      context.handle(
        _specialistCountMeta,
        specialistCount.isAcceptableOrUnknown(
          data['specialist_count']!,
          _specialistCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_specialistCountMeta);
    }
    if (data.containsKey('years_experience')) {
      context.handle(
        _yearsExperienceMeta,
        yearsExperience.isAcceptableOrUnknown(
          data['years_experience']!,
          _yearsExperienceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_yearsExperienceMeta);
    }
    if (data.containsKey('is_open')) {
      context.handle(
        _isOpenMeta,
        isOpen.isAcceptableOrUnknown(data['is_open']!, _isOpenMeta),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    }
    if (data.containsKey('clinic_name')) {
      context.handle(
        _clinicNameMeta,
        clinicName.isAcceptableOrUnknown(data['clinic_name']!, _clinicNameMeta),
      );
    }
    if (data.containsKey('tagline')) {
      context.handle(
        _taglineMeta,
        tagline.isAcceptableOrUnknown(data['tagline']!, _taglineMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('zip_code')) {
      context.handle(
        _zipCodeMeta,
        zipCode.isAcceptableOrUnknown(data['zip_code']!, _zipCodeMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('website')) {
      context.handle(
        _websiteMeta,
        website.isAcceptableOrUnknown(data['website']!, _websiteMeta),
      );
    }
    if (data.containsKey('open_time')) {
      context.handle(
        _openTimeMeta,
        openTime.isAcceptableOrUnknown(data['open_time']!, _openTimeMeta),
      );
    }
    if (data.containsKey('close_time')) {
      context.handle(
        _closeTimeMeta,
        closeTime.isAcceptableOrUnknown(data['close_time']!, _closeTimeMeta),
      );
    }
    if (data.containsKey('working_days')) {
      context.handle(
        _workingDaysMeta,
        workingDays.isAcceptableOrUnknown(
          data['working_days']!,
          _workingDaysMeta,
        ),
      );
    }
    if (data.containsKey('specialties')) {
      context.handle(
        _specialtiesMeta,
        specialties.isAcceptableOrUnknown(
          data['specialties']!,
          _specialtiesMeta,
        ),
      );
    }
    if (data.containsKey('facilities')) {
      context.handle(
        _facilitiesMeta,
        facilities.isAcceptableOrUnknown(data['facilities']!, _facilitiesMeta),
      );
    }
    if (data.containsKey('emergency_services')) {
      context.handle(
        _emergencyServicesMeta,
        emergencyServices.isAcceptableOrUnknown(
          data['emergency_services']!,
          _emergencyServicesMeta,
        ),
      );
    }
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
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClinicsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClinicsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      specialtyTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}specialty_tag'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      openingHours: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opening_hours'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      doctorCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}doctor_count'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      patientCount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_count'],
      )!,
      specialistCount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}specialist_count'],
      )!,
      yearsExperience: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}years_experience'],
      )!,
      isOpen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_open'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      ),
      clinicName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_name'],
      ),
      tagline: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tagline'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      ),
      zipCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}zip_code'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      website: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website'],
      ),
      openTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}open_time'],
      ),
      closeTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}close_time'],
      ),
      workingDays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}working_days'],
      ),
      specialties: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}specialties'],
      ),
      facilities: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}facilities'],
      ),
      emergencyServices: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}emergency_services'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $ClinicsTableTable createAlias(String alias) {
    return $ClinicsTableTable(attachedDatabase, alias);
  }
}

class ClinicsTableData extends DataClass
    implements Insertable<ClinicsTableData> {
  final String id;
  final String name;
  final String? imageUrl;
  final String specialtyTag;
  final double rating;
  final int reviewCount;
  final String openingHours;
  final String address;
  final int doctorCount;
  final String phone;
  final String patientCount;
  final String specialistCount;
  final String yearsExperience;
  final bool isOpen;
  final String? ownerId;
  final String? clinicName;
  final String? tagline;
  final String? description;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? email;
  final String? website;
  final String? openTime;
  final String? closeTime;
  final String? workingDays;
  final String? specialties;
  final String? facilities;
  final bool emergencyServices;
  final String? createdAt;
  final String? updatedAt;
  final DateTime cachedAt;
  const ClinicsTableData({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.specialtyTag,
    required this.rating,
    required this.reviewCount,
    required this.openingHours,
    required this.address,
    required this.doctorCount,
    required this.phone,
    required this.patientCount,
    required this.specialistCount,
    required this.yearsExperience,
    required this.isOpen,
    this.ownerId,
    this.clinicName,
    this.tagline,
    this.description,
    this.city,
    this.state,
    this.zipCode,
    this.email,
    this.website,
    this.openTime,
    this.closeTime,
    this.workingDays,
    this.specialties,
    this.facilities,
    required this.emergencyServices,
    this.createdAt,
    this.updatedAt,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['specialty_tag'] = Variable<String>(specialtyTag);
    map['rating'] = Variable<double>(rating);
    map['review_count'] = Variable<int>(reviewCount);
    map['opening_hours'] = Variable<String>(openingHours);
    map['address'] = Variable<String>(address);
    map['doctor_count'] = Variable<int>(doctorCount);
    map['phone'] = Variable<String>(phone);
    map['patient_count'] = Variable<String>(patientCount);
    map['specialist_count'] = Variable<String>(specialistCount);
    map['years_experience'] = Variable<String>(yearsExperience);
    map['is_open'] = Variable<bool>(isOpen);
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
    if (!nullToAbsent || clinicName != null) {
      map['clinic_name'] = Variable<String>(clinicName);
    }
    if (!nullToAbsent || tagline != null) {
      map['tagline'] = Variable<String>(tagline);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || zipCode != null) {
      map['zip_code'] = Variable<String>(zipCode);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || openTime != null) {
      map['open_time'] = Variable<String>(openTime);
    }
    if (!nullToAbsent || closeTime != null) {
      map['close_time'] = Variable<String>(closeTime);
    }
    if (!nullToAbsent || workingDays != null) {
      map['working_days'] = Variable<String>(workingDays);
    }
    if (!nullToAbsent || specialties != null) {
      map['specialties'] = Variable<String>(specialties);
    }
    if (!nullToAbsent || facilities != null) {
      map['facilities'] = Variable<String>(facilities);
    }
    map['emergency_services'] = Variable<bool>(emergencyServices);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  ClinicsTableCompanion toCompanion(bool nullToAbsent) {
    return ClinicsTableCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      specialtyTag: Value(specialtyTag),
      rating: Value(rating),
      reviewCount: Value(reviewCount),
      openingHours: Value(openingHours),
      address: Value(address),
      doctorCount: Value(doctorCount),
      phone: Value(phone),
      patientCount: Value(patientCount),
      specialistCount: Value(specialistCount),
      yearsExperience: Value(yearsExperience),
      isOpen: Value(isOpen),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
      clinicName: clinicName == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicName),
      tagline: tagline == null && nullToAbsent
          ? const Value.absent()
          : Value(tagline),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      state: state == null && nullToAbsent
          ? const Value.absent()
          : Value(state),
      zipCode: zipCode == null && nullToAbsent
          ? const Value.absent()
          : Value(zipCode),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      openTime: openTime == null && nullToAbsent
          ? const Value.absent()
          : Value(openTime),
      closeTime: closeTime == null && nullToAbsent
          ? const Value.absent()
          : Value(closeTime),
      workingDays: workingDays == null && nullToAbsent
          ? const Value.absent()
          : Value(workingDays),
      specialties: specialties == null && nullToAbsent
          ? const Value.absent()
          : Value(specialties),
      facilities: facilities == null && nullToAbsent
          ? const Value.absent()
          : Value(facilities),
      emergencyServices: Value(emergencyServices),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory ClinicsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClinicsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      specialtyTag: serializer.fromJson<String>(json['specialtyTag']),
      rating: serializer.fromJson<double>(json['rating']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      openingHours: serializer.fromJson<String>(json['openingHours']),
      address: serializer.fromJson<String>(json['address']),
      doctorCount: serializer.fromJson<int>(json['doctorCount']),
      phone: serializer.fromJson<String>(json['phone']),
      patientCount: serializer.fromJson<String>(json['patientCount']),
      specialistCount: serializer.fromJson<String>(json['specialistCount']),
      yearsExperience: serializer.fromJson<String>(json['yearsExperience']),
      isOpen: serializer.fromJson<bool>(json['isOpen']),
      ownerId: serializer.fromJson<String?>(json['ownerId']),
      clinicName: serializer.fromJson<String?>(json['clinicName']),
      tagline: serializer.fromJson<String?>(json['tagline']),
      description: serializer.fromJson<String?>(json['description']),
      city: serializer.fromJson<String?>(json['city']),
      state: serializer.fromJson<String?>(json['state']),
      zipCode: serializer.fromJson<String?>(json['zipCode']),
      email: serializer.fromJson<String?>(json['email']),
      website: serializer.fromJson<String?>(json['website']),
      openTime: serializer.fromJson<String?>(json['openTime']),
      closeTime: serializer.fromJson<String?>(json['closeTime']),
      workingDays: serializer.fromJson<String?>(json['workingDays']),
      specialties: serializer.fromJson<String?>(json['specialties']),
      facilities: serializer.fromJson<String?>(json['facilities']),
      emergencyServices: serializer.fromJson<bool>(json['emergencyServices']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'specialtyTag': serializer.toJson<String>(specialtyTag),
      'rating': serializer.toJson<double>(rating),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'openingHours': serializer.toJson<String>(openingHours),
      'address': serializer.toJson<String>(address),
      'doctorCount': serializer.toJson<int>(doctorCount),
      'phone': serializer.toJson<String>(phone),
      'patientCount': serializer.toJson<String>(patientCount),
      'specialistCount': serializer.toJson<String>(specialistCount),
      'yearsExperience': serializer.toJson<String>(yearsExperience),
      'isOpen': serializer.toJson<bool>(isOpen),
      'ownerId': serializer.toJson<String?>(ownerId),
      'clinicName': serializer.toJson<String?>(clinicName),
      'tagline': serializer.toJson<String?>(tagline),
      'description': serializer.toJson<String?>(description),
      'city': serializer.toJson<String?>(city),
      'state': serializer.toJson<String?>(state),
      'zipCode': serializer.toJson<String?>(zipCode),
      'email': serializer.toJson<String?>(email),
      'website': serializer.toJson<String?>(website),
      'openTime': serializer.toJson<String?>(openTime),
      'closeTime': serializer.toJson<String?>(closeTime),
      'workingDays': serializer.toJson<String?>(workingDays),
      'specialties': serializer.toJson<String?>(specialties),
      'facilities': serializer.toJson<String?>(facilities),
      'emergencyServices': serializer.toJson<bool>(emergencyServices),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  ClinicsTableData copyWith({
    String? id,
    String? name,
    Value<String?> imageUrl = const Value.absent(),
    String? specialtyTag,
    double? rating,
    int? reviewCount,
    String? openingHours,
    String? address,
    int? doctorCount,
    String? phone,
    String? patientCount,
    String? specialistCount,
    String? yearsExperience,
    bool? isOpen,
    Value<String?> ownerId = const Value.absent(),
    Value<String?> clinicName = const Value.absent(),
    Value<String?> tagline = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> state = const Value.absent(),
    Value<String?> zipCode = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> website = const Value.absent(),
    Value<String?> openTime = const Value.absent(),
    Value<String?> closeTime = const Value.absent(),
    Value<String?> workingDays = const Value.absent(),
    Value<String?> specialties = const Value.absent(),
    Value<String?> facilities = const Value.absent(),
    bool? emergencyServices,
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
    DateTime? cachedAt,
  }) => ClinicsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    specialtyTag: specialtyTag ?? this.specialtyTag,
    rating: rating ?? this.rating,
    reviewCount: reviewCount ?? this.reviewCount,
    openingHours: openingHours ?? this.openingHours,
    address: address ?? this.address,
    doctorCount: doctorCount ?? this.doctorCount,
    phone: phone ?? this.phone,
    patientCount: patientCount ?? this.patientCount,
    specialistCount: specialistCount ?? this.specialistCount,
    yearsExperience: yearsExperience ?? this.yearsExperience,
    isOpen: isOpen ?? this.isOpen,
    ownerId: ownerId.present ? ownerId.value : this.ownerId,
    clinicName: clinicName.present ? clinicName.value : this.clinicName,
    tagline: tagline.present ? tagline.value : this.tagline,
    description: description.present ? description.value : this.description,
    city: city.present ? city.value : this.city,
    state: state.present ? state.value : this.state,
    zipCode: zipCode.present ? zipCode.value : this.zipCode,
    email: email.present ? email.value : this.email,
    website: website.present ? website.value : this.website,
    openTime: openTime.present ? openTime.value : this.openTime,
    closeTime: closeTime.present ? closeTime.value : this.closeTime,
    workingDays: workingDays.present ? workingDays.value : this.workingDays,
    specialties: specialties.present ? specialties.value : this.specialties,
    facilities: facilities.present ? facilities.value : this.facilities,
    emergencyServices: emergencyServices ?? this.emergencyServices,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  ClinicsTableData copyWithCompanion(ClinicsTableCompanion data) {
    return ClinicsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      specialtyTag: data.specialtyTag.present
          ? data.specialtyTag.value
          : this.specialtyTag,
      rating: data.rating.present ? data.rating.value : this.rating,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      openingHours: data.openingHours.present
          ? data.openingHours.value
          : this.openingHours,
      address: data.address.present ? data.address.value : this.address,
      doctorCount: data.doctorCount.present
          ? data.doctorCount.value
          : this.doctorCount,
      phone: data.phone.present ? data.phone.value : this.phone,
      patientCount: data.patientCount.present
          ? data.patientCount.value
          : this.patientCount,
      specialistCount: data.specialistCount.present
          ? data.specialistCount.value
          : this.specialistCount,
      yearsExperience: data.yearsExperience.present
          ? data.yearsExperience.value
          : this.yearsExperience,
      isOpen: data.isOpen.present ? data.isOpen.value : this.isOpen,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      clinicName: data.clinicName.present
          ? data.clinicName.value
          : this.clinicName,
      tagline: data.tagline.present ? data.tagline.value : this.tagline,
      description: data.description.present
          ? data.description.value
          : this.description,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      zipCode: data.zipCode.present ? data.zipCode.value : this.zipCode,
      email: data.email.present ? data.email.value : this.email,
      website: data.website.present ? data.website.value : this.website,
      openTime: data.openTime.present ? data.openTime.value : this.openTime,
      closeTime: data.closeTime.present ? data.closeTime.value : this.closeTime,
      workingDays: data.workingDays.present
          ? data.workingDays.value
          : this.workingDays,
      specialties: data.specialties.present
          ? data.specialties.value
          : this.specialties,
      facilities: data.facilities.present
          ? data.facilities.value
          : this.facilities,
      emergencyServices: data.emergencyServices.present
          ? data.emergencyServices.value
          : this.emergencyServices,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClinicsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('specialtyTag: $specialtyTag, ')
          ..write('rating: $rating, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('openingHours: $openingHours, ')
          ..write('address: $address, ')
          ..write('doctorCount: $doctorCount, ')
          ..write('phone: $phone, ')
          ..write('patientCount: $patientCount, ')
          ..write('specialistCount: $specialistCount, ')
          ..write('yearsExperience: $yearsExperience, ')
          ..write('isOpen: $isOpen, ')
          ..write('ownerId: $ownerId, ')
          ..write('clinicName: $clinicName, ')
          ..write('tagline: $tagline, ')
          ..write('description: $description, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('zipCode: $zipCode, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('openTime: $openTime, ')
          ..write('closeTime: $closeTime, ')
          ..write('workingDays: $workingDays, ')
          ..write('specialties: $specialties, ')
          ..write('facilities: $facilities, ')
          ..write('emergencyServices: $emergencyServices, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    imageUrl,
    specialtyTag,
    rating,
    reviewCount,
    openingHours,
    address,
    doctorCount,
    phone,
    patientCount,
    specialistCount,
    yearsExperience,
    isOpen,
    ownerId,
    clinicName,
    tagline,
    description,
    city,
    state,
    zipCode,
    email,
    website,
    openTime,
    closeTime,
    workingDays,
    specialties,
    facilities,
    emergencyServices,
    createdAt,
    updatedAt,
    cachedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClinicsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.specialtyTag == this.specialtyTag &&
          other.rating == this.rating &&
          other.reviewCount == this.reviewCount &&
          other.openingHours == this.openingHours &&
          other.address == this.address &&
          other.doctorCount == this.doctorCount &&
          other.phone == this.phone &&
          other.patientCount == this.patientCount &&
          other.specialistCount == this.specialistCount &&
          other.yearsExperience == this.yearsExperience &&
          other.isOpen == this.isOpen &&
          other.ownerId == this.ownerId &&
          other.clinicName == this.clinicName &&
          other.tagline == this.tagline &&
          other.description == this.description &&
          other.city == this.city &&
          other.state == this.state &&
          other.zipCode == this.zipCode &&
          other.email == this.email &&
          other.website == this.website &&
          other.openTime == this.openTime &&
          other.closeTime == this.closeTime &&
          other.workingDays == this.workingDays &&
          other.specialties == this.specialties &&
          other.facilities == this.facilities &&
          other.emergencyServices == this.emergencyServices &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cachedAt == this.cachedAt);
}

class ClinicsTableCompanion extends UpdateCompanion<ClinicsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> imageUrl;
  final Value<String> specialtyTag;
  final Value<double> rating;
  final Value<int> reviewCount;
  final Value<String> openingHours;
  final Value<String> address;
  final Value<int> doctorCount;
  final Value<String> phone;
  final Value<String> patientCount;
  final Value<String> specialistCount;
  final Value<String> yearsExperience;
  final Value<bool> isOpen;
  final Value<String?> ownerId;
  final Value<String?> clinicName;
  final Value<String?> tagline;
  final Value<String?> description;
  final Value<String?> city;
  final Value<String?> state;
  final Value<String?> zipCode;
  final Value<String?> email;
  final Value<String?> website;
  final Value<String?> openTime;
  final Value<String?> closeTime;
  final Value<String?> workingDays;
  final Value<String?> specialties;
  final Value<String?> facilities;
  final Value<bool> emergencyServices;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const ClinicsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.specialtyTag = const Value.absent(),
    this.rating = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.openingHours = const Value.absent(),
    this.address = const Value.absent(),
    this.doctorCount = const Value.absent(),
    this.phone = const Value.absent(),
    this.patientCount = const Value.absent(),
    this.specialistCount = const Value.absent(),
    this.yearsExperience = const Value.absent(),
    this.isOpen = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.clinicName = const Value.absent(),
    this.tagline = const Value.absent(),
    this.description = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.openTime = const Value.absent(),
    this.closeTime = const Value.absent(),
    this.workingDays = const Value.absent(),
    this.specialties = const Value.absent(),
    this.facilities = const Value.absent(),
    this.emergencyServices = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClinicsTableCompanion.insert({
    required String id,
    required String name,
    this.imageUrl = const Value.absent(),
    required String specialtyTag,
    required double rating,
    required int reviewCount,
    required String openingHours,
    required String address,
    required int doctorCount,
    required String phone,
    required String patientCount,
    required String specialistCount,
    required String yearsExperience,
    this.isOpen = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.clinicName = const Value.absent(),
    this.tagline = const Value.absent(),
    this.description = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.openTime = const Value.absent(),
    this.closeTime = const Value.absent(),
    this.workingDays = const Value.absent(),
    this.specialties = const Value.absent(),
    this.facilities = const Value.absent(),
    this.emergencyServices = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       specialtyTag = Value(specialtyTag),
       rating = Value(rating),
       reviewCount = Value(reviewCount),
       openingHours = Value(openingHours),
       address = Value(address),
       doctorCount = Value(doctorCount),
       phone = Value(phone),
       patientCount = Value(patientCount),
       specialistCount = Value(specialistCount),
       yearsExperience = Value(yearsExperience),
       cachedAt = Value(cachedAt);
  static Insertable<ClinicsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<String>? specialtyTag,
    Expression<double>? rating,
    Expression<int>? reviewCount,
    Expression<String>? openingHours,
    Expression<String>? address,
    Expression<int>? doctorCount,
    Expression<String>? phone,
    Expression<String>? patientCount,
    Expression<String>? specialistCount,
    Expression<String>? yearsExperience,
    Expression<bool>? isOpen,
    Expression<String>? ownerId,
    Expression<String>? clinicName,
    Expression<String>? tagline,
    Expression<String>? description,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? zipCode,
    Expression<String>? email,
    Expression<String>? website,
    Expression<String>? openTime,
    Expression<String>? closeTime,
    Expression<String>? workingDays,
    Expression<String>? specialties,
    Expression<String>? facilities,
    Expression<bool>? emergencyServices,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (specialtyTag != null) 'specialty_tag': specialtyTag,
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'review_count': reviewCount,
      if (openingHours != null) 'opening_hours': openingHours,
      if (address != null) 'address': address,
      if (doctorCount != null) 'doctor_count': doctorCount,
      if (phone != null) 'phone': phone,
      if (patientCount != null) 'patient_count': patientCount,
      if (specialistCount != null) 'specialist_count': specialistCount,
      if (yearsExperience != null) 'years_experience': yearsExperience,
      if (isOpen != null) 'is_open': isOpen,
      if (ownerId != null) 'owner_id': ownerId,
      if (clinicName != null) 'clinic_name': clinicName,
      if (tagline != null) 'tagline': tagline,
      if (description != null) 'description': description,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (zipCode != null) 'zip_code': zipCode,
      if (email != null) 'email': email,
      if (website != null) 'website': website,
      if (openTime != null) 'open_time': openTime,
      if (closeTime != null) 'close_time': closeTime,
      if (workingDays != null) 'working_days': workingDays,
      if (specialties != null) 'specialties': specialties,
      if (facilities != null) 'facilities': facilities,
      if (emergencyServices != null) 'emergency_services': emergencyServices,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClinicsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? imageUrl,
    Value<String>? specialtyTag,
    Value<double>? rating,
    Value<int>? reviewCount,
    Value<String>? openingHours,
    Value<String>? address,
    Value<int>? doctorCount,
    Value<String>? phone,
    Value<String>? patientCount,
    Value<String>? specialistCount,
    Value<String>? yearsExperience,
    Value<bool>? isOpen,
    Value<String?>? ownerId,
    Value<String?>? clinicName,
    Value<String?>? tagline,
    Value<String?>? description,
    Value<String?>? city,
    Value<String?>? state,
    Value<String?>? zipCode,
    Value<String?>? email,
    Value<String?>? website,
    Value<String?>? openTime,
    Value<String?>? closeTime,
    Value<String?>? workingDays,
    Value<String?>? specialties,
    Value<String?>? facilities,
    Value<bool>? emergencyServices,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return ClinicsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      specialtyTag: specialtyTag ?? this.specialtyTag,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      openingHours: openingHours ?? this.openingHours,
      address: address ?? this.address,
      doctorCount: doctorCount ?? this.doctorCount,
      phone: phone ?? this.phone,
      patientCount: patientCount ?? this.patientCount,
      specialistCount: specialistCount ?? this.specialistCount,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      isOpen: isOpen ?? this.isOpen,
      ownerId: ownerId ?? this.ownerId,
      clinicName: clinicName ?? this.clinicName,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      email: email ?? this.email,
      website: website ?? this.website,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      workingDays: workingDays ?? this.workingDays,
      specialties: specialties ?? this.specialties,
      facilities: facilities ?? this.facilities,
      emergencyServices: emergencyServices ?? this.emergencyServices,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (specialtyTag.present) {
      map['specialty_tag'] = Variable<String>(specialtyTag.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (openingHours.present) {
      map['opening_hours'] = Variable<String>(openingHours.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (doctorCount.present) {
      map['doctor_count'] = Variable<int>(doctorCount.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (patientCount.present) {
      map['patient_count'] = Variable<String>(patientCount.value);
    }
    if (specialistCount.present) {
      map['specialist_count'] = Variable<String>(specialistCount.value);
    }
    if (yearsExperience.present) {
      map['years_experience'] = Variable<String>(yearsExperience.value);
    }
    if (isOpen.present) {
      map['is_open'] = Variable<bool>(isOpen.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (clinicName.present) {
      map['clinic_name'] = Variable<String>(clinicName.value);
    }
    if (tagline.present) {
      map['tagline'] = Variable<String>(tagline.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String>(zipCode.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (openTime.present) {
      map['open_time'] = Variable<String>(openTime.value);
    }
    if (closeTime.present) {
      map['close_time'] = Variable<String>(closeTime.value);
    }
    if (workingDays.present) {
      map['working_days'] = Variable<String>(workingDays.value);
    }
    if (specialties.present) {
      map['specialties'] = Variable<String>(specialties.value);
    }
    if (facilities.present) {
      map['facilities'] = Variable<String>(facilities.value);
    }
    if (emergencyServices.present) {
      map['emergency_services'] = Variable<bool>(emergencyServices.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClinicsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('specialtyTag: $specialtyTag, ')
          ..write('rating: $rating, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('openingHours: $openingHours, ')
          ..write('address: $address, ')
          ..write('doctorCount: $doctorCount, ')
          ..write('phone: $phone, ')
          ..write('patientCount: $patientCount, ')
          ..write('specialistCount: $specialistCount, ')
          ..write('yearsExperience: $yearsExperience, ')
          ..write('isOpen: $isOpen, ')
          ..write('ownerId: $ownerId, ')
          ..write('clinicName: $clinicName, ')
          ..write('tagline: $tagline, ')
          ..write('description: $description, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('zipCode: $zipCode, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('openTime: $openTime, ')
          ..write('closeTime: $closeTime, ')
          ..write('workingDays: $workingDays, ')
          ..write('specialties: $specialties, ')
          ..write('facilities: $facilities, ')
          ..write('emergencyServices: $emergencyServices, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileTableTable extends ProfileTable
    with TableInfo<$ProfileTableTable, ProfileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAccountVerifiedMeta = const VerificationMeta(
    'isAccountVerified',
  );
  @override
  late final GeneratedColumn<bool> isAccountVerified = GeneratedColumn<bool>(
    'is_account_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_account_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    role,
    email,
    phone,
    isAccountVerified,
    clinicId,
    createdAt,
    updatedAt,
    gender,
    dateOfBirth,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('is_account_verified')) {
      context.handle(
        _isAccountVerifiedMeta,
        isAccountVerified.isAcceptableOrUnknown(
          data['is_account_verified']!,
          _isAccountVerifiedMeta,
        ),
      );
    }
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    }
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
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      isAccountVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_account_verified'],
      )!,
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_of_birth'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $ProfileTableTable createAlias(String alias) {
    return $ProfileTableTable(attachedDatabase, alias);
  }
}

class ProfileTableData extends DataClass
    implements Insertable<ProfileTableData> {
  final String id;
  final String name;
  final String role;
  final String email;
  final String? phone;
  final bool isAccountVerified;
  final String? clinicId;
  final String? createdAt;
  final String? updatedAt;
  final String? gender;
  final String? dateOfBirth;
  final DateTime cachedAt;
  const ProfileTableData({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    this.phone,
    required this.isAccountVerified,
    this.clinicId,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.dateOfBirth,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(role);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['is_account_verified'] = Variable<bool>(isAccountVerified);
    if (!nullToAbsent || clinicId != null) {
      map['clinic_id'] = Variable<String>(clinicId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String>(dateOfBirth);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  ProfileTableCompanion toCompanion(bool nullToAbsent) {
    return ProfileTableCompanion(
      id: Value(id),
      name: Value(name),
      role: Value(role),
      email: Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      isAccountVerified: Value(isAccountVerified),
      clinicId: clinicId == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      cachedAt: Value(cachedAt),
    );
  }

  factory ProfileTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      isAccountVerified: serializer.fromJson<bool>(json['isAccountVerified']),
      clinicId: serializer.fromJson<String?>(json['clinicId']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
      gender: serializer.fromJson<String?>(json['gender']),
      dateOfBirth: serializer.fromJson<String?>(json['dateOfBirth']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String?>(phone),
      'isAccountVerified': serializer.toJson<bool>(isAccountVerified),
      'clinicId': serializer.toJson<String?>(clinicId),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'gender': serializer.toJson<String?>(gender),
      'dateOfBirth': serializer.toJson<String?>(dateOfBirth),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  ProfileTableData copyWith({
    String? id,
    String? name,
    String? role,
    String? email,
    Value<String?> phone = const Value.absent(),
    bool? isAccountVerified,
    Value<String?> clinicId = const Value.absent(),
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
    Value<String?> gender = const Value.absent(),
    Value<String?> dateOfBirth = const Value.absent(),
    DateTime? cachedAt,
  }) => ProfileTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    role: role ?? this.role,
    email: email ?? this.email,
    phone: phone.present ? phone.value : this.phone,
    isAccountVerified: isAccountVerified ?? this.isAccountVerified,
    clinicId: clinicId.present ? clinicId.value : this.clinicId,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    gender: gender.present ? gender.value : this.gender,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  ProfileTableData copyWithCompanion(ProfileTableCompanion data) {
    return ProfileTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      isAccountVerified: data.isAccountVerified.present
          ? data.isAccountVerified.value
          : this.isAccountVerified,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      gender: data.gender.present ? data.gender.value : this.gender,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('isAccountVerified: $isAccountVerified, ')
          ..write('clinicId: $clinicId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    role,
    email,
    phone,
    isAccountVerified,
    clinicId,
    createdAt,
    updatedAt,
    gender,
    dateOfBirth,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.role == this.role &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.isAccountVerified == this.isAccountVerified &&
          other.clinicId == this.clinicId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.gender == this.gender &&
          other.dateOfBirth == this.dateOfBirth &&
          other.cachedAt == this.cachedAt);
}

class ProfileTableCompanion extends UpdateCompanion<ProfileTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> role;
  final Value<String> email;
  final Value<String?> phone;
  final Value<bool> isAccountVerified;
  final Value<String?> clinicId;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<String?> gender;
  final Value<String?> dateOfBirth;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const ProfileTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.isAccountVerified = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileTableCompanion.insert({
    required String id,
    required String name,
    required String role,
    required String email,
    this.phone = const Value.absent(),
    this.isAccountVerified = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       role = Value(role),
       email = Value(email),
       cachedAt = Value(cachedAt);
  static Insertable<ProfileTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? role,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<bool>? isAccountVerified,
    Expression<String>? clinicId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? gender,
    Expression<String>? dateOfBirth,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (isAccountVerified != null) 'is_account_verified': isAccountVerified,
      if (clinicId != null) 'clinic_id': clinicId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? role,
    Value<String>? email,
    Value<String?>? phone,
    Value<bool>? isAccountVerified,
    Value<String?>? clinicId,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
    Value<String?>? gender,
    Value<String?>? dateOfBirth,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return ProfileTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isAccountVerified: isAccountVerified ?? this.isAccountVerified,
      clinicId: clinicId ?? this.clinicId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (isAccountVerified.present) {
      map['is_account_verified'] = Variable<bool>(isAccountVerified.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('isAccountVerified: $isAccountVerified, ')
          ..write('clinicId: $clinicId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InterestedItemsTableTable extends InterestedItemsTable
    with TableInfo<$InterestedItemsTableTable, InterestedItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InterestedItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [entityId, entityType, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'interested_items_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<InterestedItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entityId, entityType};
  @override
  InterestedItemsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InterestedItemsTableData(
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $InterestedItemsTableTable createAlias(String alias) {
    return $InterestedItemsTableTable(attachedDatabase, alias);
  }
}

class InterestedItemsTableData extends DataClass
    implements Insertable<InterestedItemsTableData> {
  final String entityId;
  final String entityType;
  final DateTime addedAt;
  const InterestedItemsTableData({
    required this.entityId,
    required this.entityType,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entity_id'] = Variable<String>(entityId);
    map['entity_type'] = Variable<String>(entityType);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  InterestedItemsTableCompanion toCompanion(bool nullToAbsent) {
    return InterestedItemsTableCompanion(
      entityId: Value(entityId),
      entityType: Value(entityType),
      addedAt: Value(addedAt),
    );
  }

  factory InterestedItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InterestedItemsTableData(
      entityId: serializer.fromJson<String>(json['entityId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entityId': serializer.toJson<String>(entityId),
      'entityType': serializer.toJson<String>(entityType),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  InterestedItemsTableData copyWith({
    String? entityId,
    String? entityType,
    DateTime? addedAt,
  }) => InterestedItemsTableData(
    entityId: entityId ?? this.entityId,
    entityType: entityType ?? this.entityType,
    addedAt: addedAt ?? this.addedAt,
  );
  InterestedItemsTableData copyWithCompanion(
    InterestedItemsTableCompanion data,
  ) {
    return InterestedItemsTableData(
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InterestedItemsTableData(')
          ..write('entityId: $entityId, ')
          ..write('entityType: $entityType, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entityId, entityType, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InterestedItemsTableData &&
          other.entityId == this.entityId &&
          other.entityType == this.entityType &&
          other.addedAt == this.addedAt);
}

class InterestedItemsTableCompanion
    extends UpdateCompanion<InterestedItemsTableData> {
  final Value<String> entityId;
  final Value<String> entityType;
  final Value<DateTime> addedAt;
  final Value<int> rowid;
  const InterestedItemsTableCompanion({
    this.entityId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InterestedItemsTableCompanion.insert({
    required String entityId,
    required String entityType,
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : entityId = Value(entityId),
       entityType = Value(entityType);
  static Insertable<InterestedItemsTableData> custom({
    Expression<String>? entityId,
    Expression<String>? entityType,
    Expression<DateTime>? addedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entityId != null) 'entity_id': entityId,
      if (entityType != null) 'entity_type': entityType,
      if (addedAt != null) 'added_at': addedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InterestedItemsTableCompanion copyWith({
    Value<String>? entityId,
    Value<String>? entityType,
    Value<DateTime>? addedAt,
    Value<int>? rowid,
  }) {
    return InterestedItemsTableCompanion(
      entityId: entityId ?? this.entityId,
      entityType: entityType ?? this.entityType,
      addedAt: addedAt ?? this.addedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InterestedItemsTableCompanion(')
          ..write('entityId: $entityId, ')
          ..write('entityType: $entityType, ')
          ..write('addedAt: $addedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TokensTableTable extends TokensTable
    with TableInfo<$TokensTableTable, TokensTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TokensTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doctorIdMeta = const VerificationMeta(
    'doctorId',
  );
  @override
  late final GeneratedColumn<String> doctorId = GeneratedColumn<String>(
    'doctor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tokenNumberMeta = const VerificationMeta(
    'tokenNumber',
  );
  @override
  late final GeneratedColumn<int> tokenNumber = GeneratedColumn<int>(
    'token_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    doctorId,
    clinicId,
    userId,
    notes,
    status,
    tokenNumber,
    createdAt,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tokens_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TokensTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('doctor_id')) {
      context.handle(
        _doctorIdMeta,
        doctorId.isAcceptableOrUnknown(data['doctor_id']!, _doctorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_doctorIdMeta);
    }
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clinicIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('token_number')) {
      context.handle(
        _tokenNumberMeta,
        tokenNumber.isAcceptableOrUnknown(
          data['token_number']!,
          _tokenNumberMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TokensTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TokensTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      doctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_id'],
      )!,
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      tokenNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}token_number'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $TokensTableTable createAlias(String alias) {
    return $TokensTableTable(attachedDatabase, alias);
  }
}

class TokensTableData extends DataClass implements Insertable<TokensTableData> {
  final String id;
  final String doctorId;
  final String clinicId;
  final String userId;
  final String? notes;
  final String status;
  final int? tokenNumber;
  final String? createdAt;
  final DateTime cachedAt;
  const TokensTableData({
    required this.id,
    required this.doctorId,
    required this.clinicId,
    required this.userId,
    this.notes,
    required this.status,
    this.tokenNumber,
    this.createdAt,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['doctor_id'] = Variable<String>(doctorId);
    map['clinic_id'] = Variable<String>(clinicId);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || tokenNumber != null) {
      map['token_number'] = Variable<int>(tokenNumber);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  TokensTableCompanion toCompanion(bool nullToAbsent) {
    return TokensTableCompanion(
      id: Value(id),
      doctorId: Value(doctorId),
      clinicId: Value(clinicId),
      userId: Value(userId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      tokenNumber: tokenNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(tokenNumber),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory TokensTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TokensTableData(
      id: serializer.fromJson<String>(json['id']),
      doctorId: serializer.fromJson<String>(json['doctorId']),
      clinicId: serializer.fromJson<String>(json['clinicId']),
      userId: serializer.fromJson<String>(json['userId']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      tokenNumber: serializer.fromJson<int?>(json['tokenNumber']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'doctorId': serializer.toJson<String>(doctorId),
      'clinicId': serializer.toJson<String>(clinicId),
      'userId': serializer.toJson<String>(userId),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'tokenNumber': serializer.toJson<int?>(tokenNumber),
      'createdAt': serializer.toJson<String?>(createdAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  TokensTableData copyWith({
    String? id,
    String? doctorId,
    String? clinicId,
    String? userId,
    Value<String?> notes = const Value.absent(),
    String? status,
    Value<int?> tokenNumber = const Value.absent(),
    Value<String?> createdAt = const Value.absent(),
    DateTime? cachedAt,
  }) => TokensTableData(
    id: id ?? this.id,
    doctorId: doctorId ?? this.doctorId,
    clinicId: clinicId ?? this.clinicId,
    userId: userId ?? this.userId,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    tokenNumber: tokenNumber.present ? tokenNumber.value : this.tokenNumber,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  TokensTableData copyWithCompanion(TokensTableCompanion data) {
    return TokensTableData(
      id: data.id.present ? data.id.value : this.id,
      doctorId: data.doctorId.present ? data.doctorId.value : this.doctorId,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      userId: data.userId.present ? data.userId.value : this.userId,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      tokenNumber: data.tokenNumber.present
          ? data.tokenNumber.value
          : this.tokenNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TokensTableData(')
          ..write('id: $id, ')
          ..write('doctorId: $doctorId, ')
          ..write('clinicId: $clinicId, ')
          ..write('userId: $userId, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('tokenNumber: $tokenNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    doctorId,
    clinicId,
    userId,
    notes,
    status,
    tokenNumber,
    createdAt,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TokensTableData &&
          other.id == this.id &&
          other.doctorId == this.doctorId &&
          other.clinicId == this.clinicId &&
          other.userId == this.userId &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.tokenNumber == this.tokenNumber &&
          other.createdAt == this.createdAt &&
          other.cachedAt == this.cachedAt);
}

class TokensTableCompanion extends UpdateCompanion<TokensTableData> {
  final Value<String> id;
  final Value<String> doctorId;
  final Value<String> clinicId;
  final Value<String> userId;
  final Value<String?> notes;
  final Value<String> status;
  final Value<int?> tokenNumber;
  final Value<String?> createdAt;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const TokensTableCompanion({
    this.id = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.userId = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.tokenNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TokensTableCompanion.insert({
    required String id,
    required String doctorId,
    required String clinicId,
    required String userId,
    this.notes = const Value.absent(),
    required String status,
    this.tokenNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       doctorId = Value(doctorId),
       clinicId = Value(clinicId),
       userId = Value(userId),
       status = Value(status),
       cachedAt = Value(cachedAt);
  static Insertable<TokensTableData> custom({
    Expression<String>? id,
    Expression<String>? doctorId,
    Expression<String>? clinicId,
    Expression<String>? userId,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<int>? tokenNumber,
    Expression<String>? createdAt,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (doctorId != null) 'doctor_id': doctorId,
      if (clinicId != null) 'clinic_id': clinicId,
      if (userId != null) 'user_id': userId,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (tokenNumber != null) 'token_number': tokenNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TokensTableCompanion copyWith({
    Value<String>? id,
    Value<String>? doctorId,
    Value<String>? clinicId,
    Value<String>? userId,
    Value<String?>? notes,
    Value<String>? status,
    Value<int?>? tokenNumber,
    Value<String?>? createdAt,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return TokensTableCompanion(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      clinicId: clinicId ?? this.clinicId,
      userId: userId ?? this.userId,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      tokenNumber: tokenNumber ?? this.tokenNumber,
      createdAt: createdAt ?? this.createdAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<String>(doctorId.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (tokenNumber.present) {
      map['token_number'] = Variable<int>(tokenNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TokensTableCompanion(')
          ..write('id: $id, ')
          ..write('doctorId: $doctorId, ')
          ..write('clinicId: $clinicId, ')
          ..write('userId: $userId, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('tokenNumber: $tokenNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrackingCacheTableTable extends TrackingCacheTable
    with TableInfo<$TrackingCacheTableTable, TrackingCacheTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackingCacheTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tokenIdMeta = const VerificationMeta(
    'tokenId',
  );
  @override
  late final GeneratedColumn<String> tokenId = GeneratedColumn<String>(
    'token_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentTokenNumberMeta =
      const VerificationMeta('currentTokenNumber');
  @override
  late final GeneratedColumn<int> currentTokenNumber = GeneratedColumn<int>(
    'current_token_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yourTokenNumberMeta = const VerificationMeta(
    'yourTokenNumber',
  );
  @override
  late final GeneratedColumn<int> yourTokenNumber = GeneratedColumn<int>(
    'your_token_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _patientsAheadCountMeta =
      const VerificationMeta('patientsAheadCount');
  @override
  late final GeneratedColumn<int> patientsAheadCount = GeneratedColumn<int>(
    'patients_ahead_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedWaitMinutesMeta =
      const VerificationMeta('estimatedWaitMinutes');
  @override
  late final GeneratedColumn<int> estimatedWaitMinutes = GeneratedColumn<int>(
    'estimated_wait_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFromCacheMeta = const VerificationMeta(
    'isFromCache',
  );
  @override
  late final GeneratedColumn<bool> isFromCache = GeneratedColumn<bool>(
    'is_from_cache',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_from_cache" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isStaleMeta = const VerificationMeta(
    'isStale',
  );
  @override
  late final GeneratedColumn<bool> isStale = GeneratedColumn<bool>(
    'is_stale',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_stale" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    tokenId,
    currentTokenNumber,
    yourTokenNumber,
    patientsAheadCount,
    estimatedWaitMinutes,
    status,
    lastSyncedAt,
    isFromCache,
    isStale,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tracking_cache_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackingCacheTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('token_id')) {
      context.handle(
        _tokenIdMeta,
        tokenId.isAcceptableOrUnknown(data['token_id']!, _tokenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenIdMeta);
    }
    if (data.containsKey('current_token_number')) {
      context.handle(
        _currentTokenNumberMeta,
        currentTokenNumber.isAcceptableOrUnknown(
          data['current_token_number']!,
          _currentTokenNumberMeta,
        ),
      );
    }
    if (data.containsKey('your_token_number')) {
      context.handle(
        _yourTokenNumberMeta,
        yourTokenNumber.isAcceptableOrUnknown(
          data['your_token_number']!,
          _yourTokenNumberMeta,
        ),
      );
    }
    if (data.containsKey('patients_ahead_count')) {
      context.handle(
        _patientsAheadCountMeta,
        patientsAheadCount.isAcceptableOrUnknown(
          data['patients_ahead_count']!,
          _patientsAheadCountMeta,
        ),
      );
    }
    if (data.containsKey('estimated_wait_minutes')) {
      context.handle(
        _estimatedWaitMinutesMeta,
        estimatedWaitMinutes.isAcceptableOrUnknown(
          data['estimated_wait_minutes']!,
          _estimatedWaitMinutesMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSyncedAtMeta);
    }
    if (data.containsKey('is_from_cache')) {
      context.handle(
        _isFromCacheMeta,
        isFromCache.isAcceptableOrUnknown(
          data['is_from_cache']!,
          _isFromCacheMeta,
        ),
      );
    }
    if (data.containsKey('is_stale')) {
      context.handle(
        _isStaleMeta,
        isStale.isAcceptableOrUnknown(data['is_stale']!, _isStaleMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tokenId};
  @override
  TrackingCacheTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackingCacheTableData(
      tokenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token_id'],
      )!,
      currentTokenNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_token_number'],
      ),
      yourTokenNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}your_token_number'],
      ),
      patientsAheadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}patients_ahead_count'],
      ),
      estimatedWaitMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_wait_minutes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      )!,
      isFromCache: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_from_cache'],
      )!,
      isStale: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_stale'],
      )!,
    );
  }

  @override
  $TrackingCacheTableTable createAlias(String alias) {
    return $TrackingCacheTableTable(attachedDatabase, alias);
  }
}

class TrackingCacheTableData extends DataClass
    implements Insertable<TrackingCacheTableData> {
  final String tokenId;
  final int? currentTokenNumber;
  final int? yourTokenNumber;
  final int? patientsAheadCount;
  final int? estimatedWaitMinutes;
  final String? status;
  final DateTime lastSyncedAt;
  final bool isFromCache;
  final bool isStale;
  const TrackingCacheTableData({
    required this.tokenId,
    this.currentTokenNumber,
    this.yourTokenNumber,
    this.patientsAheadCount,
    this.estimatedWaitMinutes,
    this.status,
    required this.lastSyncedAt,
    required this.isFromCache,
    required this.isStale,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['token_id'] = Variable<String>(tokenId);
    if (!nullToAbsent || currentTokenNumber != null) {
      map['current_token_number'] = Variable<int>(currentTokenNumber);
    }
    if (!nullToAbsent || yourTokenNumber != null) {
      map['your_token_number'] = Variable<int>(yourTokenNumber);
    }
    if (!nullToAbsent || patientsAheadCount != null) {
      map['patients_ahead_count'] = Variable<int>(patientsAheadCount);
    }
    if (!nullToAbsent || estimatedWaitMinutes != null) {
      map['estimated_wait_minutes'] = Variable<int>(estimatedWaitMinutes);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    map['is_from_cache'] = Variable<bool>(isFromCache);
    map['is_stale'] = Variable<bool>(isStale);
    return map;
  }

  TrackingCacheTableCompanion toCompanion(bool nullToAbsent) {
    return TrackingCacheTableCompanion(
      tokenId: Value(tokenId),
      currentTokenNumber: currentTokenNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(currentTokenNumber),
      yourTokenNumber: yourTokenNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(yourTokenNumber),
      patientsAheadCount: patientsAheadCount == null && nullToAbsent
          ? const Value.absent()
          : Value(patientsAheadCount),
      estimatedWaitMinutes: estimatedWaitMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedWaitMinutes),
      status: status == null && nullToAbsent
          ? const Value.absent()
          : Value(status),
      lastSyncedAt: Value(lastSyncedAt),
      isFromCache: Value(isFromCache),
      isStale: Value(isStale),
    );
  }

  factory TrackingCacheTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackingCacheTableData(
      tokenId: serializer.fromJson<String>(json['tokenId']),
      currentTokenNumber: serializer.fromJson<int?>(json['currentTokenNumber']),
      yourTokenNumber: serializer.fromJson<int?>(json['yourTokenNumber']),
      patientsAheadCount: serializer.fromJson<int?>(json['patientsAheadCount']),
      estimatedWaitMinutes: serializer.fromJson<int?>(
        json['estimatedWaitMinutes'],
      ),
      status: serializer.fromJson<String?>(json['status']),
      lastSyncedAt: serializer.fromJson<DateTime>(json['lastSyncedAt']),
      isFromCache: serializer.fromJson<bool>(json['isFromCache']),
      isStale: serializer.fromJson<bool>(json['isStale']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tokenId': serializer.toJson<String>(tokenId),
      'currentTokenNumber': serializer.toJson<int?>(currentTokenNumber),
      'yourTokenNumber': serializer.toJson<int?>(yourTokenNumber),
      'patientsAheadCount': serializer.toJson<int?>(patientsAheadCount),
      'estimatedWaitMinutes': serializer.toJson<int?>(estimatedWaitMinutes),
      'status': serializer.toJson<String?>(status),
      'lastSyncedAt': serializer.toJson<DateTime>(lastSyncedAt),
      'isFromCache': serializer.toJson<bool>(isFromCache),
      'isStale': serializer.toJson<bool>(isStale),
    };
  }

  TrackingCacheTableData copyWith({
    String? tokenId,
    Value<int?> currentTokenNumber = const Value.absent(),
    Value<int?> yourTokenNumber = const Value.absent(),
    Value<int?> patientsAheadCount = const Value.absent(),
    Value<int?> estimatedWaitMinutes = const Value.absent(),
    Value<String?> status = const Value.absent(),
    DateTime? lastSyncedAt,
    bool? isFromCache,
    bool? isStale,
  }) => TrackingCacheTableData(
    tokenId: tokenId ?? this.tokenId,
    currentTokenNumber: currentTokenNumber.present
        ? currentTokenNumber.value
        : this.currentTokenNumber,
    yourTokenNumber: yourTokenNumber.present
        ? yourTokenNumber.value
        : this.yourTokenNumber,
    patientsAheadCount: patientsAheadCount.present
        ? patientsAheadCount.value
        : this.patientsAheadCount,
    estimatedWaitMinutes: estimatedWaitMinutes.present
        ? estimatedWaitMinutes.value
        : this.estimatedWaitMinutes,
    status: status.present ? status.value : this.status,
    lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    isFromCache: isFromCache ?? this.isFromCache,
    isStale: isStale ?? this.isStale,
  );
  TrackingCacheTableData copyWithCompanion(TrackingCacheTableCompanion data) {
    return TrackingCacheTableData(
      tokenId: data.tokenId.present ? data.tokenId.value : this.tokenId,
      currentTokenNumber: data.currentTokenNumber.present
          ? data.currentTokenNumber.value
          : this.currentTokenNumber,
      yourTokenNumber: data.yourTokenNumber.present
          ? data.yourTokenNumber.value
          : this.yourTokenNumber,
      patientsAheadCount: data.patientsAheadCount.present
          ? data.patientsAheadCount.value
          : this.patientsAheadCount,
      estimatedWaitMinutes: data.estimatedWaitMinutes.present
          ? data.estimatedWaitMinutes.value
          : this.estimatedWaitMinutes,
      status: data.status.present ? data.status.value : this.status,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      isFromCache: data.isFromCache.present
          ? data.isFromCache.value
          : this.isFromCache,
      isStale: data.isStale.present ? data.isStale.value : this.isStale,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackingCacheTableData(')
          ..write('tokenId: $tokenId, ')
          ..write('currentTokenNumber: $currentTokenNumber, ')
          ..write('yourTokenNumber: $yourTokenNumber, ')
          ..write('patientsAheadCount: $patientsAheadCount, ')
          ..write('estimatedWaitMinutes: $estimatedWaitMinutes, ')
          ..write('status: $status, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('isFromCache: $isFromCache, ')
          ..write('isStale: $isStale')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    tokenId,
    currentTokenNumber,
    yourTokenNumber,
    patientsAheadCount,
    estimatedWaitMinutes,
    status,
    lastSyncedAt,
    isFromCache,
    isStale,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackingCacheTableData &&
          other.tokenId == this.tokenId &&
          other.currentTokenNumber == this.currentTokenNumber &&
          other.yourTokenNumber == this.yourTokenNumber &&
          other.patientsAheadCount == this.patientsAheadCount &&
          other.estimatedWaitMinutes == this.estimatedWaitMinutes &&
          other.status == this.status &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.isFromCache == this.isFromCache &&
          other.isStale == this.isStale);
}

class TrackingCacheTableCompanion
    extends UpdateCompanion<TrackingCacheTableData> {
  final Value<String> tokenId;
  final Value<int?> currentTokenNumber;
  final Value<int?> yourTokenNumber;
  final Value<int?> patientsAheadCount;
  final Value<int?> estimatedWaitMinutes;
  final Value<String?> status;
  final Value<DateTime> lastSyncedAt;
  final Value<bool> isFromCache;
  final Value<bool> isStale;
  final Value<int> rowid;
  const TrackingCacheTableCompanion({
    this.tokenId = const Value.absent(),
    this.currentTokenNumber = const Value.absent(),
    this.yourTokenNumber = const Value.absent(),
    this.patientsAheadCount = const Value.absent(),
    this.estimatedWaitMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.isFromCache = const Value.absent(),
    this.isStale = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrackingCacheTableCompanion.insert({
    required String tokenId,
    this.currentTokenNumber = const Value.absent(),
    this.yourTokenNumber = const Value.absent(),
    this.patientsAheadCount = const Value.absent(),
    this.estimatedWaitMinutes = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime lastSyncedAt,
    this.isFromCache = const Value.absent(),
    this.isStale = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : tokenId = Value(tokenId),
       lastSyncedAt = Value(lastSyncedAt);
  static Insertable<TrackingCacheTableData> custom({
    Expression<String>? tokenId,
    Expression<int>? currentTokenNumber,
    Expression<int>? yourTokenNumber,
    Expression<int>? patientsAheadCount,
    Expression<int>? estimatedWaitMinutes,
    Expression<String>? status,
    Expression<DateTime>? lastSyncedAt,
    Expression<bool>? isFromCache,
    Expression<bool>? isStale,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tokenId != null) 'token_id': tokenId,
      if (currentTokenNumber != null)
        'current_token_number': currentTokenNumber,
      if (yourTokenNumber != null) 'your_token_number': yourTokenNumber,
      if (patientsAheadCount != null)
        'patients_ahead_count': patientsAheadCount,
      if (estimatedWaitMinutes != null)
        'estimated_wait_minutes': estimatedWaitMinutes,
      if (status != null) 'status': status,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (isFromCache != null) 'is_from_cache': isFromCache,
      if (isStale != null) 'is_stale': isStale,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrackingCacheTableCompanion copyWith({
    Value<String>? tokenId,
    Value<int?>? currentTokenNumber,
    Value<int?>? yourTokenNumber,
    Value<int?>? patientsAheadCount,
    Value<int?>? estimatedWaitMinutes,
    Value<String?>? status,
    Value<DateTime>? lastSyncedAt,
    Value<bool>? isFromCache,
    Value<bool>? isStale,
    Value<int>? rowid,
  }) {
    return TrackingCacheTableCompanion(
      tokenId: tokenId ?? this.tokenId,
      currentTokenNumber: currentTokenNumber ?? this.currentTokenNumber,
      yourTokenNumber: yourTokenNumber ?? this.yourTokenNumber,
      patientsAheadCount: patientsAheadCount ?? this.patientsAheadCount,
      estimatedWaitMinutes: estimatedWaitMinutes ?? this.estimatedWaitMinutes,
      status: status ?? this.status,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      isFromCache: isFromCache ?? this.isFromCache,
      isStale: isStale ?? this.isStale,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tokenId.present) {
      map['token_id'] = Variable<String>(tokenId.value);
    }
    if (currentTokenNumber.present) {
      map['current_token_number'] = Variable<int>(currentTokenNumber.value);
    }
    if (yourTokenNumber.present) {
      map['your_token_number'] = Variable<int>(yourTokenNumber.value);
    }
    if (patientsAheadCount.present) {
      map['patients_ahead_count'] = Variable<int>(patientsAheadCount.value);
    }
    if (estimatedWaitMinutes.present) {
      map['estimated_wait_minutes'] = Variable<int>(estimatedWaitMinutes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (isFromCache.present) {
      map['is_from_cache'] = Variable<bool>(isFromCache.value);
    }
    if (isStale.present) {
      map['is_stale'] = Variable<bool>(isStale.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackingCacheTableCompanion(')
          ..write('tokenId: $tokenId, ')
          ..write('currentTokenNumber: $currentTokenNumber, ')
          ..write('yourTokenNumber: $yourTokenNumber, ')
          ..write('patientsAheadCount: $patientsAheadCount, ')
          ..write('estimatedWaitMinutes: $estimatedWaitMinutes, ')
          ..write('status: $status, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('isFromCache: $isFromCache, ')
          ..write('isStale: $isStale, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DoctorsTableTable doctorsTable = $DoctorsTableTable(this);
  late final $ClinicsTableTable clinicsTable = $ClinicsTableTable(this);
  late final $ProfileTableTable profileTable = $ProfileTableTable(this);
  late final $InterestedItemsTableTable interestedItemsTable =
      $InterestedItemsTableTable(this);
  late final $TokensTableTable tokensTable = $TokensTableTable(this);
  late final $TrackingCacheTableTable trackingCacheTable =
      $TrackingCacheTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    doctorsTable,
    clinicsTable,
    profileTable,
    interestedItemsTable,
    tokensTable,
    trackingCacheTable,
  ];
}

typedef $$DoctorsTableTableCreateCompanionBuilder =
    DoctorsTableCompanion Function({
      required String id,
      Value<String?> clinicId,
      required String name,
      Value<String?> qualification,
      Value<int?> experience,
      required String specialty,
      required double price,
      required int durationMinutes,
      Value<String?> workingDays,
      Value<String?> startTime,
      Value<String?> endTime,
      Value<int?> maxTokensPerDay,
      required double rating,
      Value<String?> photoUrl,
      required String clinicName,
      required int reviewCount,
      Value<bool> isInterested,
      Value<bool> isAvailable,
      Value<String?> about,
      Value<String?> location,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$DoctorsTableTableUpdateCompanionBuilder =
    DoctorsTableCompanion Function({
      Value<String> id,
      Value<String?> clinicId,
      Value<String> name,
      Value<String?> qualification,
      Value<int?> experience,
      Value<String> specialty,
      Value<double> price,
      Value<int> durationMinutes,
      Value<String?> workingDays,
      Value<String?> startTime,
      Value<String?> endTime,
      Value<int?> maxTokensPerDay,
      Value<double> rating,
      Value<String?> photoUrl,
      Value<String> clinicName,
      Value<int> reviewCount,
      Value<bool> isInterested,
      Value<bool> isAvailable,
      Value<String?> about,
      Value<String?> location,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$DoctorsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DoctorsTableTable> {
  $$DoctorsTableTableFilterComposer({
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

  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qualification => $composableBuilder(
    column: $table.qualification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specialty => $composableBuilder(
    column: $table.specialty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workingDays => $composableBuilder(
    column: $table.workingDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxTokensPerDay => $composableBuilder(
    column: $table.maxTokensPerDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isInterested => $composableBuilder(
    column: $table.isInterested,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DoctorsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DoctorsTableTable> {
  $$DoctorsTableTableOrderingComposer({
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

  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qualification => $composableBuilder(
    column: $table.qualification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialty => $composableBuilder(
    column: $table.specialty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workingDays => $composableBuilder(
    column: $table.workingDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxTokensPerDay => $composableBuilder(
    column: $table.maxTokensPerDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isInterested => $composableBuilder(
    column: $table.isInterested,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DoctorsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoctorsTableTable> {
  $$DoctorsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get qualification => $composableBuilder(
    column: $table.qualification,
    builder: (column) => column,
  );

  GeneratedColumn<int> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => column,
  );

  GeneratedColumn<String> get specialty =>
      $composableBuilder(column: $table.specialty, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workingDays => $composableBuilder(
    column: $table.workingDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get maxTokensPerDay => $composableBuilder(
    column: $table.maxTokensPerDay,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isInterested => $composableBuilder(
    column: $table.isInterested,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get about =>
      $composableBuilder(column: $table.about, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$DoctorsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DoctorsTableTable,
          DoctorsTableData,
          $$DoctorsTableTableFilterComposer,
          $$DoctorsTableTableOrderingComposer,
          $$DoctorsTableTableAnnotationComposer,
          $$DoctorsTableTableCreateCompanionBuilder,
          $$DoctorsTableTableUpdateCompanionBuilder,
          (
            DoctorsTableData,
            BaseReferences<_$AppDatabase, $DoctorsTableTable, DoctorsTableData>,
          ),
          DoctorsTableData,
          PrefetchHooks Function()
        > {
  $$DoctorsTableTableTableManager(_$AppDatabase db, $DoctorsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoctorsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoctorsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoctorsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> clinicId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> qualification = const Value.absent(),
                Value<int?> experience = const Value.absent(),
                Value<String> specialty = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<String?> workingDays = const Value.absent(),
                Value<String?> startTime = const Value.absent(),
                Value<String?> endTime = const Value.absent(),
                Value<int?> maxTokensPerDay = const Value.absent(),
                Value<double> rating = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String> clinicName = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<bool> isInterested = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<String?> about = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoctorsTableCompanion(
                id: id,
                clinicId: clinicId,
                name: name,
                qualification: qualification,
                experience: experience,
                specialty: specialty,
                price: price,
                durationMinutes: durationMinutes,
                workingDays: workingDays,
                startTime: startTime,
                endTime: endTime,
                maxTokensPerDay: maxTokensPerDay,
                rating: rating,
                photoUrl: photoUrl,
                clinicName: clinicName,
                reviewCount: reviewCount,
                isInterested: isInterested,
                isAvailable: isAvailable,
                about: about,
                location: location,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> clinicId = const Value.absent(),
                required String name,
                Value<String?> qualification = const Value.absent(),
                Value<int?> experience = const Value.absent(),
                required String specialty,
                required double price,
                required int durationMinutes,
                Value<String?> workingDays = const Value.absent(),
                Value<String?> startTime = const Value.absent(),
                Value<String?> endTime = const Value.absent(),
                Value<int?> maxTokensPerDay = const Value.absent(),
                required double rating,
                Value<String?> photoUrl = const Value.absent(),
                required String clinicName,
                required int reviewCount,
                Value<bool> isInterested = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<String?> about = const Value.absent(),
                Value<String?> location = const Value.absent(),
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => DoctorsTableCompanion.insert(
                id: id,
                clinicId: clinicId,
                name: name,
                qualification: qualification,
                experience: experience,
                specialty: specialty,
                price: price,
                durationMinutes: durationMinutes,
                workingDays: workingDays,
                startTime: startTime,
                endTime: endTime,
                maxTokensPerDay: maxTokensPerDay,
                rating: rating,
                photoUrl: photoUrl,
                clinicName: clinicName,
                reviewCount: reviewCount,
                isInterested: isInterested,
                isAvailable: isAvailable,
                about: about,
                location: location,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DoctorsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DoctorsTableTable,
      DoctorsTableData,
      $$DoctorsTableTableFilterComposer,
      $$DoctorsTableTableOrderingComposer,
      $$DoctorsTableTableAnnotationComposer,
      $$DoctorsTableTableCreateCompanionBuilder,
      $$DoctorsTableTableUpdateCompanionBuilder,
      (
        DoctorsTableData,
        BaseReferences<_$AppDatabase, $DoctorsTableTable, DoctorsTableData>,
      ),
      DoctorsTableData,
      PrefetchHooks Function()
    >;
typedef $$ClinicsTableTableCreateCompanionBuilder =
    ClinicsTableCompanion Function({
      required String id,
      required String name,
      Value<String?> imageUrl,
      required String specialtyTag,
      required double rating,
      required int reviewCount,
      required String openingHours,
      required String address,
      required int doctorCount,
      required String phone,
      required String patientCount,
      required String specialistCount,
      required String yearsExperience,
      Value<bool> isOpen,
      Value<String?> ownerId,
      Value<String?> clinicName,
      Value<String?> tagline,
      Value<String?> description,
      Value<String?> city,
      Value<String?> state,
      Value<String?> zipCode,
      Value<String?> email,
      Value<String?> website,
      Value<String?> openTime,
      Value<String?> closeTime,
      Value<String?> workingDays,
      Value<String?> specialties,
      Value<String?> facilities,
      Value<bool> emergencyServices,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$ClinicsTableTableUpdateCompanionBuilder =
    ClinicsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> imageUrl,
      Value<String> specialtyTag,
      Value<double> rating,
      Value<int> reviewCount,
      Value<String> openingHours,
      Value<String> address,
      Value<int> doctorCount,
      Value<String> phone,
      Value<String> patientCount,
      Value<String> specialistCount,
      Value<String> yearsExperience,
      Value<bool> isOpen,
      Value<String?> ownerId,
      Value<String?> clinicName,
      Value<String?> tagline,
      Value<String?> description,
      Value<String?> city,
      Value<String?> state,
      Value<String?> zipCode,
      Value<String?> email,
      Value<String?> website,
      Value<String?> openTime,
      Value<String?> closeTime,
      Value<String?> workingDays,
      Value<String?> specialties,
      Value<String?> facilities,
      Value<bool> emergencyServices,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$ClinicsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ClinicsTableTable> {
  $$ClinicsTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specialtyTag => $composableBuilder(
    column: $table.specialtyTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get doctorCount => $composableBuilder(
    column: $table.doctorCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientCount => $composableBuilder(
    column: $table.patientCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specialistCount => $composableBuilder(
    column: $table.specialistCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get yearsExperience => $composableBuilder(
    column: $table.yearsExperience,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOpen => $composableBuilder(
    column: $table.isOpen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagline => $composableBuilder(
    column: $table.tagline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get zipCode => $composableBuilder(
    column: $table.zipCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openTime => $composableBuilder(
    column: $table.openTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get closeTime => $composableBuilder(
    column: $table.closeTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workingDays => $composableBuilder(
    column: $table.workingDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specialties => $composableBuilder(
    column: $table.specialties,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get facilities => $composableBuilder(
    column: $table.facilities,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get emergencyServices => $composableBuilder(
    column: $table.emergencyServices,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClinicsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ClinicsTableTable> {
  $$ClinicsTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialtyTag => $composableBuilder(
    column: $table.specialtyTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get doctorCount => $composableBuilder(
    column: $table.doctorCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientCount => $composableBuilder(
    column: $table.patientCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialistCount => $composableBuilder(
    column: $table.specialistCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get yearsExperience => $composableBuilder(
    column: $table.yearsExperience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOpen => $composableBuilder(
    column: $table.isOpen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagline => $composableBuilder(
    column: $table.tagline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get zipCode => $composableBuilder(
    column: $table.zipCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openTime => $composableBuilder(
    column: $table.openTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get closeTime => $composableBuilder(
    column: $table.closeTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workingDays => $composableBuilder(
    column: $table.workingDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialties => $composableBuilder(
    column: $table.specialties,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get facilities => $composableBuilder(
    column: $table.facilities,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get emergencyServices => $composableBuilder(
    column: $table.emergencyServices,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClinicsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClinicsTableTable> {
  $$ClinicsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get specialtyTag => $composableBuilder(
    column: $table.specialtyTag,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get doctorCount => $composableBuilder(
    column: $table.doctorCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get patientCount => $composableBuilder(
    column: $table.patientCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get specialistCount => $composableBuilder(
    column: $table.specialistCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get yearsExperience => $composableBuilder(
    column: $table.yearsExperience,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isOpen =>
      $composableBuilder(column: $table.isOpen, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagline =>
      $composableBuilder(column: $table.tagline, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get zipCode =>
      $composableBuilder(column: $table.zipCode, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get openTime =>
      $composableBuilder(column: $table.openTime, builder: (column) => column);

  GeneratedColumn<String> get closeTime =>
      $composableBuilder(column: $table.closeTime, builder: (column) => column);

  GeneratedColumn<String> get workingDays => $composableBuilder(
    column: $table.workingDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get specialties => $composableBuilder(
    column: $table.specialties,
    builder: (column) => column,
  );

  GeneratedColumn<String> get facilities => $composableBuilder(
    column: $table.facilities,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get emergencyServices => $composableBuilder(
    column: $table.emergencyServices,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$ClinicsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClinicsTableTable,
          ClinicsTableData,
          $$ClinicsTableTableFilterComposer,
          $$ClinicsTableTableOrderingComposer,
          $$ClinicsTableTableAnnotationComposer,
          $$ClinicsTableTableCreateCompanionBuilder,
          $$ClinicsTableTableUpdateCompanionBuilder,
          (
            ClinicsTableData,
            BaseReferences<_$AppDatabase, $ClinicsTableTable, ClinicsTableData>,
          ),
          ClinicsTableData,
          PrefetchHooks Function()
        > {
  $$ClinicsTableTableTableManager(_$AppDatabase db, $ClinicsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClinicsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClinicsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClinicsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String> specialtyTag = const Value.absent(),
                Value<double> rating = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<String> openingHours = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int> doctorCount = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> patientCount = const Value.absent(),
                Value<String> specialistCount = const Value.absent(),
                Value<String> yearsExperience = const Value.absent(),
                Value<bool> isOpen = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<String?> clinicName = const Value.absent(),
                Value<String?> tagline = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String?> zipCode = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> openTime = const Value.absent(),
                Value<String?> closeTime = const Value.absent(),
                Value<String?> workingDays = const Value.absent(),
                Value<String?> specialties = const Value.absent(),
                Value<String?> facilities = const Value.absent(),
                Value<bool> emergencyServices = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClinicsTableCompanion(
                id: id,
                name: name,
                imageUrl: imageUrl,
                specialtyTag: specialtyTag,
                rating: rating,
                reviewCount: reviewCount,
                openingHours: openingHours,
                address: address,
                doctorCount: doctorCount,
                phone: phone,
                patientCount: patientCount,
                specialistCount: specialistCount,
                yearsExperience: yearsExperience,
                isOpen: isOpen,
                ownerId: ownerId,
                clinicName: clinicName,
                tagline: tagline,
                description: description,
                city: city,
                state: state,
                zipCode: zipCode,
                email: email,
                website: website,
                openTime: openTime,
                closeTime: closeTime,
                workingDays: workingDays,
                specialties: specialties,
                facilities: facilities,
                emergencyServices: emergencyServices,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> imageUrl = const Value.absent(),
                required String specialtyTag,
                required double rating,
                required int reviewCount,
                required String openingHours,
                required String address,
                required int doctorCount,
                required String phone,
                required String patientCount,
                required String specialistCount,
                required String yearsExperience,
                Value<bool> isOpen = const Value.absent(),
                Value<String?> ownerId = const Value.absent(),
                Value<String?> clinicName = const Value.absent(),
                Value<String?> tagline = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String?> zipCode = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> openTime = const Value.absent(),
                Value<String?> closeTime = const Value.absent(),
                Value<String?> workingDays = const Value.absent(),
                Value<String?> specialties = const Value.absent(),
                Value<String?> facilities = const Value.absent(),
                Value<bool> emergencyServices = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => ClinicsTableCompanion.insert(
                id: id,
                name: name,
                imageUrl: imageUrl,
                specialtyTag: specialtyTag,
                rating: rating,
                reviewCount: reviewCount,
                openingHours: openingHours,
                address: address,
                doctorCount: doctorCount,
                phone: phone,
                patientCount: patientCount,
                specialistCount: specialistCount,
                yearsExperience: yearsExperience,
                isOpen: isOpen,
                ownerId: ownerId,
                clinicName: clinicName,
                tagline: tagline,
                description: description,
                city: city,
                state: state,
                zipCode: zipCode,
                email: email,
                website: website,
                openTime: openTime,
                closeTime: closeTime,
                workingDays: workingDays,
                specialties: specialties,
                facilities: facilities,
                emergencyServices: emergencyServices,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClinicsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClinicsTableTable,
      ClinicsTableData,
      $$ClinicsTableTableFilterComposer,
      $$ClinicsTableTableOrderingComposer,
      $$ClinicsTableTableAnnotationComposer,
      $$ClinicsTableTableCreateCompanionBuilder,
      $$ClinicsTableTableUpdateCompanionBuilder,
      (
        ClinicsTableData,
        BaseReferences<_$AppDatabase, $ClinicsTableTable, ClinicsTableData>,
      ),
      ClinicsTableData,
      PrefetchHooks Function()
    >;
typedef $$ProfileTableTableCreateCompanionBuilder =
    ProfileTableCompanion Function({
      required String id,
      required String name,
      required String role,
      required String email,
      Value<String?> phone,
      Value<bool> isAccountVerified,
      Value<String?> clinicId,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<String?> gender,
      Value<String?> dateOfBirth,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$ProfileTableTableUpdateCompanionBuilder =
    ProfileTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> role,
      Value<String> email,
      Value<String?> phone,
      Value<bool> isAccountVerified,
      Value<String?> clinicId,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<String?> gender,
      Value<String?> dateOfBirth,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$ProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileTableTable> {
  $$ProfileTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAccountVerified => $composableBuilder(
    column: $table.isAccountVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileTableTable> {
  $$ProfileTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAccountVerified => $composableBuilder(
    column: $table.isAccountVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileTableTable> {
  $$ProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<bool> get isAccountVerified => $composableBuilder(
    column: $table.isAccountVerified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$ProfileTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileTableTable,
          ProfileTableData,
          $$ProfileTableTableFilterComposer,
          $$ProfileTableTableOrderingComposer,
          $$ProfileTableTableAnnotationComposer,
          $$ProfileTableTableCreateCompanionBuilder,
          $$ProfileTableTableUpdateCompanionBuilder,
          (
            ProfileTableData,
            BaseReferences<_$AppDatabase, $ProfileTableTable, ProfileTableData>,
          ),
          ProfileTableData,
          PrefetchHooks Function()
        > {
  $$ProfileTableTableTableManager(_$AppDatabase db, $ProfileTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<bool> isAccountVerified = const Value.absent(),
                Value<String?> clinicId = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> dateOfBirth = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileTableCompanion(
                id: id,
                name: name,
                role: role,
                email: email,
                phone: phone,
                isAccountVerified: isAccountVerified,
                clinicId: clinicId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                gender: gender,
                dateOfBirth: dateOfBirth,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String role,
                required String email,
                Value<String?> phone = const Value.absent(),
                Value<bool> isAccountVerified = const Value.absent(),
                Value<String?> clinicId = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> dateOfBirth = const Value.absent(),
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProfileTableCompanion.insert(
                id: id,
                name: name,
                role: role,
                email: email,
                phone: phone,
                isAccountVerified: isAccountVerified,
                clinicId: clinicId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                gender: gender,
                dateOfBirth: dateOfBirth,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileTableTable,
      ProfileTableData,
      $$ProfileTableTableFilterComposer,
      $$ProfileTableTableOrderingComposer,
      $$ProfileTableTableAnnotationComposer,
      $$ProfileTableTableCreateCompanionBuilder,
      $$ProfileTableTableUpdateCompanionBuilder,
      (
        ProfileTableData,
        BaseReferences<_$AppDatabase, $ProfileTableTable, ProfileTableData>,
      ),
      ProfileTableData,
      PrefetchHooks Function()
    >;
typedef $$InterestedItemsTableTableCreateCompanionBuilder =
    InterestedItemsTableCompanion Function({
      required String entityId,
      required String entityType,
      Value<DateTime> addedAt,
      Value<int> rowid,
    });
typedef $$InterestedItemsTableTableUpdateCompanionBuilder =
    InterestedItemsTableCompanion Function({
      Value<String> entityId,
      Value<String> entityType,
      Value<DateTime> addedAt,
      Value<int> rowid,
    });

class $$InterestedItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $InterestedItemsTableTable> {
  $$InterestedItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InterestedItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InterestedItemsTableTable> {
  $$InterestedItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InterestedItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InterestedItemsTableTable> {
  $$InterestedItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$InterestedItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InterestedItemsTableTable,
          InterestedItemsTableData,
          $$InterestedItemsTableTableFilterComposer,
          $$InterestedItemsTableTableOrderingComposer,
          $$InterestedItemsTableTableAnnotationComposer,
          $$InterestedItemsTableTableCreateCompanionBuilder,
          $$InterestedItemsTableTableUpdateCompanionBuilder,
          (
            InterestedItemsTableData,
            BaseReferences<
              _$AppDatabase,
              $InterestedItemsTableTable,
              InterestedItemsTableData
            >,
          ),
          InterestedItemsTableData,
          PrefetchHooks Function()
        > {
  $$InterestedItemsTableTableTableManager(
    _$AppDatabase db,
    $InterestedItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InterestedItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InterestedItemsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InterestedItemsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> entityId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InterestedItemsTableCompanion(
                entityId: entityId,
                entityType: entityType,
                addedAt: addedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String entityId,
                required String entityType,
                Value<DateTime> addedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InterestedItemsTableCompanion.insert(
                entityId: entityId,
                entityType: entityType,
                addedAt: addedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InterestedItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InterestedItemsTableTable,
      InterestedItemsTableData,
      $$InterestedItemsTableTableFilterComposer,
      $$InterestedItemsTableTableOrderingComposer,
      $$InterestedItemsTableTableAnnotationComposer,
      $$InterestedItemsTableTableCreateCompanionBuilder,
      $$InterestedItemsTableTableUpdateCompanionBuilder,
      (
        InterestedItemsTableData,
        BaseReferences<
          _$AppDatabase,
          $InterestedItemsTableTable,
          InterestedItemsTableData
        >,
      ),
      InterestedItemsTableData,
      PrefetchHooks Function()
    >;
typedef $$TokensTableTableCreateCompanionBuilder =
    TokensTableCompanion Function({
      required String id,
      required String doctorId,
      required String clinicId,
      required String userId,
      Value<String?> notes,
      required String status,
      Value<int?> tokenNumber,
      Value<String?> createdAt,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$TokensTableTableUpdateCompanionBuilder =
    TokensTableCompanion Function({
      Value<String> id,
      Value<String> doctorId,
      Value<String> clinicId,
      Value<String> userId,
      Value<String?> notes,
      Value<String> status,
      Value<int?> tokenNumber,
      Value<String?> createdAt,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$TokensTableTableFilterComposer
    extends Composer<_$AppDatabase, $TokensTableTable> {
  $$TokensTableTableFilterComposer({
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

  ColumnFilters<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tokenNumber => $composableBuilder(
    column: $table.tokenNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TokensTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TokensTableTable> {
  $$TokensTableTableOrderingComposer({
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

  ColumnOrderings<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tokenNumber => $composableBuilder(
    column: $table.tokenNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TokensTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TokensTableTable> {
  $$TokensTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get doctorId =>
      $composableBuilder(column: $table.doctorId, builder: (column) => column);

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get tokenNumber => $composableBuilder(
    column: $table.tokenNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$TokensTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TokensTableTable,
          TokensTableData,
          $$TokensTableTableFilterComposer,
          $$TokensTableTableOrderingComposer,
          $$TokensTableTableAnnotationComposer,
          $$TokensTableTableCreateCompanionBuilder,
          $$TokensTableTableUpdateCompanionBuilder,
          (
            TokensTableData,
            BaseReferences<_$AppDatabase, $TokensTableTable, TokensTableData>,
          ),
          TokensTableData,
          PrefetchHooks Function()
        > {
  $$TokensTableTableTableManager(_$AppDatabase db, $TokensTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TokensTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TokensTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TokensTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> doctorId = const Value.absent(),
                Value<String> clinicId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> tokenNumber = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TokensTableCompanion(
                id: id,
                doctorId: doctorId,
                clinicId: clinicId,
                userId: userId,
                notes: notes,
                status: status,
                tokenNumber: tokenNumber,
                createdAt: createdAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String doctorId,
                required String clinicId,
                required String userId,
                Value<String?> notes = const Value.absent(),
                required String status,
                Value<int?> tokenNumber = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => TokensTableCompanion.insert(
                id: id,
                doctorId: doctorId,
                clinicId: clinicId,
                userId: userId,
                notes: notes,
                status: status,
                tokenNumber: tokenNumber,
                createdAt: createdAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TokensTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TokensTableTable,
      TokensTableData,
      $$TokensTableTableFilterComposer,
      $$TokensTableTableOrderingComposer,
      $$TokensTableTableAnnotationComposer,
      $$TokensTableTableCreateCompanionBuilder,
      $$TokensTableTableUpdateCompanionBuilder,
      (
        TokensTableData,
        BaseReferences<_$AppDatabase, $TokensTableTable, TokensTableData>,
      ),
      TokensTableData,
      PrefetchHooks Function()
    >;
typedef $$TrackingCacheTableTableCreateCompanionBuilder =
    TrackingCacheTableCompanion Function({
      required String tokenId,
      Value<int?> currentTokenNumber,
      Value<int?> yourTokenNumber,
      Value<int?> patientsAheadCount,
      Value<int?> estimatedWaitMinutes,
      Value<String?> status,
      required DateTime lastSyncedAt,
      Value<bool> isFromCache,
      Value<bool> isStale,
      Value<int> rowid,
    });
typedef $$TrackingCacheTableTableUpdateCompanionBuilder =
    TrackingCacheTableCompanion Function({
      Value<String> tokenId,
      Value<int?> currentTokenNumber,
      Value<int?> yourTokenNumber,
      Value<int?> patientsAheadCount,
      Value<int?> estimatedWaitMinutes,
      Value<String?> status,
      Value<DateTime> lastSyncedAt,
      Value<bool> isFromCache,
      Value<bool> isStale,
      Value<int> rowid,
    });

class $$TrackingCacheTableTableFilterComposer
    extends Composer<_$AppDatabase, $TrackingCacheTableTable> {
  $$TrackingCacheTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tokenId => $composableBuilder(
    column: $table.tokenId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentTokenNumber => $composableBuilder(
    column: $table.currentTokenNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yourTokenNumber => $composableBuilder(
    column: $table.yourTokenNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get patientsAheadCount => $composableBuilder(
    column: $table.patientsAheadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedWaitMinutes => $composableBuilder(
    column: $table.estimatedWaitMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFromCache => $composableBuilder(
    column: $table.isFromCache,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStale => $composableBuilder(
    column: $table.isStale,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrackingCacheTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackingCacheTableTable> {
  $$TrackingCacheTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tokenId => $composableBuilder(
    column: $table.tokenId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentTokenNumber => $composableBuilder(
    column: $table.currentTokenNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yourTokenNumber => $composableBuilder(
    column: $table.yourTokenNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get patientsAheadCount => $composableBuilder(
    column: $table.patientsAheadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedWaitMinutes => $composableBuilder(
    column: $table.estimatedWaitMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFromCache => $composableBuilder(
    column: $table.isFromCache,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStale => $composableBuilder(
    column: $table.isStale,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrackingCacheTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackingCacheTableTable> {
  $$TrackingCacheTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tokenId =>
      $composableBuilder(column: $table.tokenId, builder: (column) => column);

  GeneratedColumn<int> get currentTokenNumber => $composableBuilder(
    column: $table.currentTokenNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get yourTokenNumber => $composableBuilder(
    column: $table.yourTokenNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get patientsAheadCount => $composableBuilder(
    column: $table.patientsAheadCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedWaitMinutes => $composableBuilder(
    column: $table.estimatedWaitMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFromCache => $composableBuilder(
    column: $table.isFromCache,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isStale =>
      $composableBuilder(column: $table.isStale, builder: (column) => column);
}

class $$TrackingCacheTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackingCacheTableTable,
          TrackingCacheTableData,
          $$TrackingCacheTableTableFilterComposer,
          $$TrackingCacheTableTableOrderingComposer,
          $$TrackingCacheTableTableAnnotationComposer,
          $$TrackingCacheTableTableCreateCompanionBuilder,
          $$TrackingCacheTableTableUpdateCompanionBuilder,
          (
            TrackingCacheTableData,
            BaseReferences<
              _$AppDatabase,
              $TrackingCacheTableTable,
              TrackingCacheTableData
            >,
          ),
          TrackingCacheTableData,
          PrefetchHooks Function()
        > {
  $$TrackingCacheTableTableTableManager(
    _$AppDatabase db,
    $TrackingCacheTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackingCacheTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackingCacheTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackingCacheTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> tokenId = const Value.absent(),
                Value<int?> currentTokenNumber = const Value.absent(),
                Value<int?> yourTokenNumber = const Value.absent(),
                Value<int?> patientsAheadCount = const Value.absent(),
                Value<int?> estimatedWaitMinutes = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<DateTime> lastSyncedAt = const Value.absent(),
                Value<bool> isFromCache = const Value.absent(),
                Value<bool> isStale = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackingCacheTableCompanion(
                tokenId: tokenId,
                currentTokenNumber: currentTokenNumber,
                yourTokenNumber: yourTokenNumber,
                patientsAheadCount: patientsAheadCount,
                estimatedWaitMinutes: estimatedWaitMinutes,
                status: status,
                lastSyncedAt: lastSyncedAt,
                isFromCache: isFromCache,
                isStale: isStale,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tokenId,
                Value<int?> currentTokenNumber = const Value.absent(),
                Value<int?> yourTokenNumber = const Value.absent(),
                Value<int?> patientsAheadCount = const Value.absent(),
                Value<int?> estimatedWaitMinutes = const Value.absent(),
                Value<String?> status = const Value.absent(),
                required DateTime lastSyncedAt,
                Value<bool> isFromCache = const Value.absent(),
                Value<bool> isStale = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackingCacheTableCompanion.insert(
                tokenId: tokenId,
                currentTokenNumber: currentTokenNumber,
                yourTokenNumber: yourTokenNumber,
                patientsAheadCount: patientsAheadCount,
                estimatedWaitMinutes: estimatedWaitMinutes,
                status: status,
                lastSyncedAt: lastSyncedAt,
                isFromCache: isFromCache,
                isStale: isStale,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrackingCacheTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackingCacheTableTable,
      TrackingCacheTableData,
      $$TrackingCacheTableTableFilterComposer,
      $$TrackingCacheTableTableOrderingComposer,
      $$TrackingCacheTableTableAnnotationComposer,
      $$TrackingCacheTableTableCreateCompanionBuilder,
      $$TrackingCacheTableTableUpdateCompanionBuilder,
      (
        TrackingCacheTableData,
        BaseReferences<
          _$AppDatabase,
          $TrackingCacheTableTable,
          TrackingCacheTableData
        >,
      ),
      TrackingCacheTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DoctorsTableTableTableManager get doctorsTable =>
      $$DoctorsTableTableTableManager(_db, _db.doctorsTable);
  $$ClinicsTableTableTableManager get clinicsTable =>
      $$ClinicsTableTableTableManager(_db, _db.clinicsTable);
  $$ProfileTableTableTableManager get profileTable =>
      $$ProfileTableTableTableManager(_db, _db.profileTable);
  $$InterestedItemsTableTableTableManager get interestedItemsTable =>
      $$InterestedItemsTableTableTableManager(_db, _db.interestedItemsTable);
  $$TokensTableTableTableManager get tokensTable =>
      $$TokensTableTableTableManager(_db, _db.tokensTable);
  $$TrackingCacheTableTableTableManager get trackingCacheTable =>
      $$TrackingCacheTableTableTableManager(_db, _db.trackingCacheTable);
}
