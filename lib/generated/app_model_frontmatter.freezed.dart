// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_model_frontmatter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppModelFrontmatter _$AppModelFrontmatterFromJson(Map<String, dynamic> json) {
  return _AppModelFrontmatter.fromJson(json);
}

/// @nodoc
mixin _$AppModelFrontmatter {
  String? get title => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String? get excerpt => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppModelFrontmatterCopyWith<AppModelFrontmatter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppModelFrontmatterCopyWith<$Res> {
  factory $AppModelFrontmatterCopyWith(
          AppModelFrontmatter value, $Res Function(AppModelFrontmatter) then) =
      _$AppModelFrontmatterCopyWithImpl<$Res, AppModelFrontmatter>;
  @useResult
  $Res call(
      {String? title,
      String? author,
      String? excerpt,
      String? category,
      String? date});
}

/// @nodoc
class _$AppModelFrontmatterCopyWithImpl<$Res, $Val extends AppModelFrontmatter>
    implements $AppModelFrontmatterCopyWith<$Res> {
  _$AppModelFrontmatterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? author = freezed,
    Object? excerpt = freezed,
    Object? category = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      excerpt: freezed == excerpt
          ? _value.excerpt
          : excerpt // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppModelFrontmatterImplCopyWith<$Res>
    implements $AppModelFrontmatterCopyWith<$Res> {
  factory _$$AppModelFrontmatterImplCopyWith(_$AppModelFrontmatterImpl value,
          $Res Function(_$AppModelFrontmatterImpl) then) =
      __$$AppModelFrontmatterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? author,
      String? excerpt,
      String? category,
      String? date});
}

/// @nodoc
class __$$AppModelFrontmatterImplCopyWithImpl<$Res>
    extends _$AppModelFrontmatterCopyWithImpl<$Res, _$AppModelFrontmatterImpl>
    implements _$$AppModelFrontmatterImplCopyWith<$Res> {
  __$$AppModelFrontmatterImplCopyWithImpl(_$AppModelFrontmatterImpl _value,
      $Res Function(_$AppModelFrontmatterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? author = freezed,
    Object? excerpt = freezed,
    Object? category = freezed,
    Object? date = freezed,
  }) {
    return _then(_$AppModelFrontmatterImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      excerpt: freezed == excerpt
          ? _value.excerpt
          : excerpt // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppModelFrontmatterImpl extends _AppModelFrontmatter {
  const _$AppModelFrontmatterImpl(
      {this.title, this.author, this.excerpt, this.category, this.date})
      : super._();

  factory _$AppModelFrontmatterImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppModelFrontmatterImplFromJson(json);

  @override
  final String? title;
  @override
  final String? author;
  @override
  final String? excerpt;
  @override
  final String? category;
  @override
  final String? date;

  @override
  String toString() {
    return 'AppModelFrontmatter(title: $title, author: $author, excerpt: $excerpt, category: $category, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppModelFrontmatterImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.excerpt, excerpt) || other.excerpt == excerpt) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, author, excerpt, category, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppModelFrontmatterImplCopyWith<_$AppModelFrontmatterImpl> get copyWith =>
      __$$AppModelFrontmatterImplCopyWithImpl<_$AppModelFrontmatterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppModelFrontmatterImplToJson(
      this,
    );
  }
}

abstract class _AppModelFrontmatter extends AppModelFrontmatter {
  const factory _AppModelFrontmatter(
      {final String? title,
      final String? author,
      final String? excerpt,
      final String? category,
      final String? date}) = _$AppModelFrontmatterImpl;
  const _AppModelFrontmatter._() : super._();

  factory _AppModelFrontmatter.fromJson(Map<String, dynamic> json) =
      _$AppModelFrontmatterImpl.fromJson;

  @override
  String? get title;
  @override
  String? get author;
  @override
  String? get excerpt;
  @override
  String? get category;
  @override
  String? get date;
  @override
  @JsonKey(ignore: true)
  _$$AppModelFrontmatterImplCopyWith<_$AppModelFrontmatterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
