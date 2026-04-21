// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Patient {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get medicalRecordId => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  DateTime? get lastVisit => throw _privateConstructorUsedError;
  List<Recording> get recordings => throw _privateConstructorUsedError;

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientCopyWith<Patient> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientCopyWith<$Res> {
  factory $PatientCopyWith(Patient value, $Res Function(Patient) then) =
      _$PatientCopyWithImpl<$Res, Patient>;
  @useResult
  $Res call(
      {String id,
      String name,
      DateTime? dateOfBirth,
      String gender,
      String medicalRecordId,
      String notes,
      DateTime? lastVisit,
      List<Recording> recordings});
}

/// @nodoc
class _$PatientCopyWithImpl<$Res, $Val extends Patient>
    implements $PatientCopyWith<$Res> {
  _$PatientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dateOfBirth = freezed,
    Object? gender = null,
    Object? medicalRecordId = null,
    Object? notes = null,
    Object? lastVisit = freezed,
    Object? recordings = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      medicalRecordId: null == medicalRecordId
          ? _value.medicalRecordId
          : medicalRecordId // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      lastVisit: freezed == lastVisit
          ? _value.lastVisit
          : lastVisit // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recordings: null == recordings
          ? _value.recordings
          : recordings // ignore: cast_nullable_to_non_nullable
              as List<Recording>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatientImplCopyWith<$Res> implements $PatientCopyWith<$Res> {
  factory _$$PatientImplCopyWith(
          _$PatientImpl value, $Res Function(_$PatientImpl) then) =
      __$$PatientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      DateTime? dateOfBirth,
      String gender,
      String medicalRecordId,
      String notes,
      DateTime? lastVisit,
      List<Recording> recordings});
}

/// @nodoc
class __$$PatientImplCopyWithImpl<$Res>
    extends _$PatientCopyWithImpl<$Res, _$PatientImpl>
    implements _$$PatientImplCopyWith<$Res> {
  __$$PatientImplCopyWithImpl(
      _$PatientImpl _value, $Res Function(_$PatientImpl) _then)
      : super(_value, _then);

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dateOfBirth = freezed,
    Object? gender = null,
    Object? medicalRecordId = null,
    Object? notes = null,
    Object? lastVisit = freezed,
    Object? recordings = null,
  }) {
    return _then(_$PatientImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      medicalRecordId: null == medicalRecordId
          ? _value.medicalRecordId
          : medicalRecordId // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      lastVisit: freezed == lastVisit
          ? _value.lastVisit
          : lastVisit // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recordings: null == recordings
          ? _value._recordings
          : recordings // ignore: cast_nullable_to_non_nullable
              as List<Recording>,
    ));
  }
}

/// @nodoc

class _$PatientImpl extends _Patient {
  const _$PatientImpl(
      {this.id = '',
      this.name = '',
      this.dateOfBirth,
      this.gender = '',
      this.medicalRecordId = '',
      this.notes = '',
      this.lastVisit,
      final List<Recording> recordings = const []})
      : _recordings = recordings,
        super._();

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final DateTime? dateOfBirth;
  @override
  @JsonKey()
  final String gender;
  @override
  @JsonKey()
  final String medicalRecordId;
  @override
  @JsonKey()
  final String notes;
  @override
  final DateTime? lastVisit;
  final List<Recording> _recordings;
  @override
  @JsonKey()
  List<Recording> get recordings {
    if (_recordings is EqualUnmodifiableListView) return _recordings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recordings);
  }

  @override
  String toString() {
    return 'Patient(id: $id, name: $name, dateOfBirth: $dateOfBirth, gender: $gender, medicalRecordId: $medicalRecordId, notes: $notes, lastVisit: $lastVisit, recordings: $recordings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.medicalRecordId, medicalRecordId) ||
                other.medicalRecordId == medicalRecordId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.lastVisit, lastVisit) ||
                other.lastVisit == lastVisit) &&
            const DeepCollectionEquality()
                .equals(other._recordings, _recordings));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      dateOfBirth,
      gender,
      medicalRecordId,
      notes,
      lastVisit,
      const DeepCollectionEquality().hash(_recordings));

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientImplCopyWith<_$PatientImpl> get copyWith =>
      __$$PatientImplCopyWithImpl<_$PatientImpl>(this, _$identity);
}

abstract class _Patient extends Patient {
  const factory _Patient(
      {final String id,
      final String name,
      final DateTime? dateOfBirth,
      final String gender,
      final String medicalRecordId,
      final String notes,
      final DateTime? lastVisit,
      final List<Recording> recordings}) = _$PatientImpl;
  const _Patient._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime? get dateOfBirth;
  @override
  String get gender;
  @override
  String get medicalRecordId;
  @override
  String get notes;
  @override
  DateTime? get lastVisit;
  @override
  List<Recording> get recordings;

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientImplCopyWith<_$PatientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
