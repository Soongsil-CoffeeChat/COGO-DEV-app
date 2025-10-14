// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatRoomResponse _$ChatRoomResponseFromJson(Map<String, dynamic> json) {
  return _ChatRoomResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomResponse {
  @JsonKey(name: 'content')
  List<ChatRoom> get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'pageNumber')
  int get pageNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'pageSize')
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalElements')
  int get totalElements => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalPages')
  int get totalPages => throw _privateConstructorUsedError;
  @JsonKey(name: 'last')
  bool get last => throw _privateConstructorUsedError;

  /// Serializes this ChatRoomResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatRoomResponseCopyWith<ChatRoomResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomResponseCopyWith<$Res> {
  factory $ChatRoomResponseCopyWith(
          ChatRoomResponse value, $Res Function(ChatRoomResponse) then) =
      _$ChatRoomResponseCopyWithImpl<$Res, ChatRoomResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'content') List<ChatRoom> content,
      @JsonKey(name: 'pageNumber') int pageNumber,
      @JsonKey(name: 'pageSize') int pageSize,
      @JsonKey(name: 'totalElements') int totalElements,
      @JsonKey(name: 'totalPages') int totalPages,
      @JsonKey(name: 'last') bool last});
}

/// @nodoc
class _$ChatRoomResponseCopyWithImpl<$Res, $Val extends ChatRoomResponse>
    implements $ChatRoomResponseCopyWith<$Res> {
  _$ChatRoomResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? pageNumber = null,
    Object? pageSize = null,
    Object? totalElements = null,
    Object? totalPages = null,
    Object? last = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<ChatRoom>,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalElements: null == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      last: null == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomResponseImplCopyWith<$Res>
    implements $ChatRoomResponseCopyWith<$Res> {
  factory _$$ChatRoomResponseImplCopyWith(_$ChatRoomResponseImpl value,
          $Res Function(_$ChatRoomResponseImpl) then) =
      __$$ChatRoomResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'content') List<ChatRoom> content,
      @JsonKey(name: 'pageNumber') int pageNumber,
      @JsonKey(name: 'pageSize') int pageSize,
      @JsonKey(name: 'totalElements') int totalElements,
      @JsonKey(name: 'totalPages') int totalPages,
      @JsonKey(name: 'last') bool last});
}

/// @nodoc
class __$$ChatRoomResponseImplCopyWithImpl<$Res>
    extends _$ChatRoomResponseCopyWithImpl<$Res, _$ChatRoomResponseImpl>
    implements _$$ChatRoomResponseImplCopyWith<$Res> {
  __$$ChatRoomResponseImplCopyWithImpl(_$ChatRoomResponseImpl _value,
      $Res Function(_$ChatRoomResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? pageNumber = null,
    Object? pageSize = null,
    Object? totalElements = null,
    Object? totalPages = null,
    Object? last = null,
  }) {
    return _then(_$ChatRoomResponseImpl(
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<ChatRoom>,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalElements: null == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      last: null == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomResponseImpl implements _ChatRoomResponse {
  const _$ChatRoomResponseImpl(
      {@JsonKey(name: 'content') required final List<ChatRoom> content,
      @JsonKey(name: 'pageNumber') required this.pageNumber,
      @JsonKey(name: 'pageSize') required this.pageSize,
      @JsonKey(name: 'totalElements') required this.totalElements,
      @JsonKey(name: 'totalPages') required this.totalPages,
      @JsonKey(name: 'last') required this.last})
      : _content = content;

  factory _$ChatRoomResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomResponseImplFromJson(json);

  final List<ChatRoom> _content;
  @override
  @JsonKey(name: 'content')
  List<ChatRoom> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  @JsonKey(name: 'pageNumber')
  final int pageNumber;
  @override
  @JsonKey(name: 'pageSize')
  final int pageSize;
  @override
  @JsonKey(name: 'totalElements')
  final int totalElements;
  @override
  @JsonKey(name: 'totalPages')
  final int totalPages;
  @override
  @JsonKey(name: 'last')
  final bool last;

  @override
  String toString() {
    return 'ChatRoomResponse(content: $content, pageNumber: $pageNumber, pageSize: $pageSize, totalElements: $totalElements, totalPages: $totalPages, last: $last)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomResponseImpl &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.last, last) || other.last == last));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_content),
      pageNumber,
      pageSize,
      totalElements,
      totalPages,
      last);

  /// Create a copy of ChatRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomResponseImplCopyWith<_$ChatRoomResponseImpl> get copyWith =>
      __$$ChatRoomResponseImplCopyWithImpl<_$ChatRoomResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomResponseImplToJson(
      this,
    );
  }
}

abstract class _ChatRoomResponse implements ChatRoomResponse {
  const factory _ChatRoomResponse(
          {@JsonKey(name: 'content') required final List<ChatRoom> content,
          @JsonKey(name: 'pageNumber') required final int pageNumber,
          @JsonKey(name: 'pageSize') required final int pageSize,
          @JsonKey(name: 'totalElements') required final int totalElements,
          @JsonKey(name: 'totalPages') required final int totalPages,
          @JsonKey(name: 'last') required final bool last}) =
      _$ChatRoomResponseImpl;

  factory _ChatRoomResponse.fromJson(Map<String, dynamic> json) =
      _$ChatRoomResponseImpl.fromJson;

  @override
  @JsonKey(name: 'content')
  List<ChatRoom> get content;
  @override
  @JsonKey(name: 'pageNumber')
  int get pageNumber;
  @override
  @JsonKey(name: 'pageSize')
  int get pageSize;
  @override
  @JsonKey(name: 'totalElements')
  int get totalElements;
  @override
  @JsonKey(name: 'totalPages')
  int get totalPages;
  @override
  @JsonKey(name: 'last')
  bool get last;

  /// Create a copy of ChatRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatRoomResponseImplCopyWith<_$ChatRoomResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  @JsonKey(name: 'id')
  int get id =>
      throw _privateConstructorUsedError; // 서버 응답에는 name 없음 → optional
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError; // null 가능
  @JsonKey(name: 'lastChat')
  String? get lastChat =>
      throw _privateConstructorUsedError; // 서버는 updatedAt 아니라 updateAt 내려줌 → 키 변경
  @JsonKey(name: 'updateAt')
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // 서버 응답에는 없음 → optional 처리
  @JsonKey(name: 'application')
  Application? get application => throw _privateConstructorUsedError;
  @JsonKey(name: 'participants')
  List<Participant>? get participants => throw _privateConstructorUsedError;

  /// Serializes this ChatRoom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'lastChat') String? lastChat,
      @JsonKey(name: 'updateAt') DateTime updatedAt,
      @JsonKey(name: 'application') Application? application,
      @JsonKey(name: 'participants') List<Participant>? participants});

  $ApplicationCopyWith<$Res>? get application;
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? lastChat = freezed,
    Object? updatedAt = null,
    Object? application = freezed,
    Object? participants = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lastChat: freezed == lastChat
          ? _value.lastChat
          : lastChat // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      application: freezed == application
          ? _value.application
          : application // ignore: cast_nullable_to_non_nullable
              as Application?,
      participants: freezed == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<Participant>?,
    ) as $Val);
  }

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApplicationCopyWith<$Res>? get application {
    if (_value.application == null) {
      return null;
    }

    return $ApplicationCopyWith<$Res>(_value.application!, (value) {
      return _then(_value.copyWith(application: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatRoomImplCopyWith<$Res>
    implements $ChatRoomCopyWith<$Res> {
  factory _$$ChatRoomImplCopyWith(
          _$ChatRoomImpl value, $Res Function(_$ChatRoomImpl) then) =
      __$$ChatRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'lastChat') String? lastChat,
      @JsonKey(name: 'updateAt') DateTime updatedAt,
      @JsonKey(name: 'application') Application? application,
      @JsonKey(name: 'participants') List<Participant>? participants});

  @override
  $ApplicationCopyWith<$Res>? get application;
}

/// @nodoc
class __$$ChatRoomImplCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$ChatRoomImpl>
    implements _$$ChatRoomImplCopyWith<$Res> {
  __$$ChatRoomImplCopyWithImpl(
      _$ChatRoomImpl _value, $Res Function(_$ChatRoomImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? lastChat = freezed,
    Object? updatedAt = null,
    Object? application = freezed,
    Object? participants = freezed,
  }) {
    return _then(_$ChatRoomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lastChat: freezed == lastChat
          ? _value.lastChat
          : lastChat // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      application: freezed == application
          ? _value.application
          : application // ignore: cast_nullable_to_non_nullable
              as Application?,
      participants: freezed == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<Participant>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomImpl implements _ChatRoom {
  const _$ChatRoomImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'lastChat') this.lastChat,
      @JsonKey(name: 'updateAt') required this.updatedAt,
      @JsonKey(name: 'application') this.application,
      @JsonKey(name: 'participants') final List<Participant>? participants})
      : _participants = participants;

  factory _$ChatRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
// 서버 응답에는 name 없음 → optional
  @override
  @JsonKey(name: 'name')
  final String? name;
// null 가능
  @override
  @JsonKey(name: 'lastChat')
  final String? lastChat;
// 서버는 updatedAt 아니라 updateAt 내려줌 → 키 변경
  @override
  @JsonKey(name: 'updateAt')
  final DateTime updatedAt;
// 서버 응답에는 없음 → optional 처리
  @override
  @JsonKey(name: 'application')
  final Application? application;
  final List<Participant>? _participants;
  @override
  @JsonKey(name: 'participants')
  List<Participant>? get participants {
    final value = _participants;
    if (value == null) return null;
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ChatRoom(id: $id, name: $name, lastChat: $lastChat, updatedAt: $updatedAt, application: $application, participants: $participants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lastChat, lastChat) ||
                other.lastChat == lastChat) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.application, application) ||
                other.application == application) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, lastChat, updatedAt,
      application, const DeepCollectionEquality().hash(_participants));

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      __$$ChatRoomImplCopyWithImpl<_$ChatRoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomImplToJson(
      this,
    );
  }
}

abstract class _ChatRoom implements ChatRoom {
  const factory _ChatRoom(
      {@JsonKey(name: 'id') required final int id,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'lastChat') final String? lastChat,
      @JsonKey(name: 'updateAt') required final DateTime updatedAt,
      @JsonKey(name: 'application') final Application? application,
      @JsonKey(name: 'participants')
      final List<Participant>? participants}) = _$ChatRoomImpl;

  factory _ChatRoom.fromJson(Map<String, dynamic> json) =
      _$ChatRoomImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id; // 서버 응답에는 name 없음 → optional
  @override
  @JsonKey(name: 'name')
  String? get name; // null 가능
  @override
  @JsonKey(name: 'lastChat')
  String? get lastChat; // 서버는 updatedAt 아니라 updateAt 내려줌 → 키 변경
  @override
  @JsonKey(name: 'updateAt')
  DateTime get updatedAt; // 서버 응답에는 없음 → optional 처리
  @override
  @JsonKey(name: 'application')
  Application? get application;
  @override
  @JsonKey(name: 'participants')
  List<Participant>? get participants;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Application _$ApplicationFromJson(Map<String, dynamic> json) {
  return _Application.fromJson(json);
}

/// @nodoc
mixin _$Application {
  @JsonKey(name: 'applicationId')
  int get applicationId => throw _privateConstructorUsedError;

  /// Serializes this Application to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicationCopyWith<Application> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationCopyWith<$Res> {
  factory $ApplicationCopyWith(
          Application value, $Res Function(Application) then) =
      _$ApplicationCopyWithImpl<$Res, Application>;
  @useResult
  $Res call({@JsonKey(name: 'applicationId') int applicationId});
}

/// @nodoc
class _$ApplicationCopyWithImpl<$Res, $Val extends Application>
    implements $ApplicationCopyWith<$Res> {
  _$ApplicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationId = null,
  }) {
    return _then(_value.copyWith(
      applicationId: null == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplicationImplCopyWith<$Res>
    implements $ApplicationCopyWith<$Res> {
  factory _$$ApplicationImplCopyWith(
          _$ApplicationImpl value, $Res Function(_$ApplicationImpl) then) =
      __$$ApplicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'applicationId') int applicationId});
}

/// @nodoc
class __$$ApplicationImplCopyWithImpl<$Res>
    extends _$ApplicationCopyWithImpl<$Res, _$ApplicationImpl>
    implements _$$ApplicationImplCopyWith<$Res> {
  __$$ApplicationImplCopyWithImpl(
      _$ApplicationImpl _value, $Res Function(_$ApplicationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationId = null,
  }) {
    return _then(_$ApplicationImpl(
      applicationId: null == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicationImpl implements _Application {
  const _$ApplicationImpl(
      {@JsonKey(name: 'applicationId') required this.applicationId});

  factory _$ApplicationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicationImplFromJson(json);

  @override
  @JsonKey(name: 'applicationId')
  final int applicationId;

  @override
  String toString() {
    return 'Application(applicationId: $applicationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationImpl &&
            (identical(other.applicationId, applicationId) ||
                other.applicationId == applicationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, applicationId);

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationImplCopyWith<_$ApplicationImpl> get copyWith =>
      __$$ApplicationImplCopyWithImpl<_$ApplicationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicationImplToJson(
      this,
    );
  }
}

abstract class _Application implements Application {
  const factory _Application(
          {@JsonKey(name: 'applicationId') required final int applicationId}) =
      _$ApplicationImpl;

  factory _Application.fromJson(Map<String, dynamic> json) =
      _$ApplicationImpl.fromJson;

  @override
  @JsonKey(name: 'applicationId')
  int get applicationId;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicationImplCopyWith<_$ApplicationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Participant _$ParticipantFromJson(Map<String, dynamic> json) {
  return _Participant.fromJson(json);
}

/// @nodoc
mixin _$Participant {
  @JsonKey(name: 'userId')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'profileImage')
  String get profileImage => throw _privateConstructorUsedError;

  /// Serializes this Participant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Participant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParticipantCopyWith<Participant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParticipantCopyWith<$Res> {
  factory $ParticipantCopyWith(
          Participant value, $Res Function(Participant) then) =
      _$ParticipantCopyWithImpl<$Res, Participant>;
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') int userId,
      @JsonKey(name: 'username') String username,
      @JsonKey(name: 'profileImage') String profileImage});
}

/// @nodoc
class _$ParticipantCopyWithImpl<$Res, $Val extends Participant>
    implements $ParticipantCopyWith<$Res> {
  _$ParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Participant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? profileImage = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParticipantImplCopyWith<$Res>
    implements $ParticipantCopyWith<$Res> {
  factory _$$ParticipantImplCopyWith(
          _$ParticipantImpl value, $Res Function(_$ParticipantImpl) then) =
      __$$ParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') int userId,
      @JsonKey(name: 'username') String username,
      @JsonKey(name: 'profileImage') String profileImage});
}

/// @nodoc
class __$$ParticipantImplCopyWithImpl<$Res>
    extends _$ParticipantCopyWithImpl<$Res, _$ParticipantImpl>
    implements _$$ParticipantImplCopyWith<$Res> {
  __$$ParticipantImplCopyWithImpl(
      _$ParticipantImpl _value, $Res Function(_$ParticipantImpl) _then)
      : super(_value, _then);

  /// Create a copy of Participant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? profileImage = null,
  }) {
    return _then(_$ParticipantImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParticipantImpl implements _Participant {
  const _$ParticipantImpl(
      {@JsonKey(name: 'userId') required this.userId,
      @JsonKey(name: 'username') required this.username,
      @JsonKey(name: 'profileImage') required this.profileImage});

  factory _$ParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParticipantImplFromJson(json);

  @override
  @JsonKey(name: 'userId')
  final int userId;
  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'profileImage')
  final String profileImage;

  @override
  String toString() {
    return 'Participant(userId: $userId, username: $username, profileImage: $profileImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParticipantImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, username, profileImage);

  /// Create a copy of Participant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParticipantImplCopyWith<_$ParticipantImpl> get copyWith =>
      __$$ParticipantImplCopyWithImpl<_$ParticipantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParticipantImplToJson(
      this,
    );
  }
}

abstract class _Participant implements Participant {
  const factory _Participant(
          {@JsonKey(name: 'userId') required final int userId,
          @JsonKey(name: 'username') required final String username,
          @JsonKey(name: 'profileImage') required final String profileImage}) =
      _$ParticipantImpl;

  factory _Participant.fromJson(Map<String, dynamic> json) =
      _$ParticipantImpl.fromJson;

  @override
  @JsonKey(name: 'userId')
  int get userId;
  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'profileImage')
  String get profileImage;

  /// Create a copy of Participant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParticipantImplCopyWith<_$ParticipantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
