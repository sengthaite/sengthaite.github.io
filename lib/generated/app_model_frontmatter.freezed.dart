// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_model_frontmatter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppModelFrontmatter {

 String? get title; String? get author; String? get excerpt; String? get category; String? get date; String? get content;
/// Create a copy of AppModelFrontmatter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppModelFrontmatterCopyWith<AppModelFrontmatter> get copyWith => _$AppModelFrontmatterCopyWithImpl<AppModelFrontmatter>(this as AppModelFrontmatter, _$identity);

  /// Serializes this AppModelFrontmatter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppModelFrontmatter&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.excerpt, excerpt) || other.excerpt == excerpt)&&(identical(other.category, category) || other.category == category)&&(identical(other.date, date) || other.date == date)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,author,excerpt,category,date,content);

@override
String toString() {
  return 'AppModelFrontmatter(title: $title, author: $author, excerpt: $excerpt, category: $category, date: $date, content: $content)';
}


}

/// @nodoc
abstract mixin class $AppModelFrontmatterCopyWith<$Res>  {
  factory $AppModelFrontmatterCopyWith(AppModelFrontmatter value, $Res Function(AppModelFrontmatter) _then) = _$AppModelFrontmatterCopyWithImpl;
@useResult
$Res call({
 String? title, String? author, String? excerpt, String? category, String? date, String? content
});




}
/// @nodoc
class _$AppModelFrontmatterCopyWithImpl<$Res>
    implements $AppModelFrontmatterCopyWith<$Res> {
  _$AppModelFrontmatterCopyWithImpl(this._self, this._then);

  final AppModelFrontmatter _self;
  final $Res Function(AppModelFrontmatter) _then;

/// Create a copy of AppModelFrontmatter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? author = freezed,Object? excerpt = freezed,Object? category = freezed,Object? date = freezed,Object? content = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,excerpt: freezed == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppModelFrontmatter].
extension AppModelFrontmatterPatterns on AppModelFrontmatter {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppModelFrontmatter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppModelFrontmatter() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppModelFrontmatter value)  $default,){
final _that = this;
switch (_that) {
case _AppModelFrontmatter():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppModelFrontmatter value)?  $default,){
final _that = this;
switch (_that) {
case _AppModelFrontmatter() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? author,  String? excerpt,  String? category,  String? date,  String? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppModelFrontmatter() when $default != null:
return $default(_that.title,_that.author,_that.excerpt,_that.category,_that.date,_that.content);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? author,  String? excerpt,  String? category,  String? date,  String? content)  $default,) {final _that = this;
switch (_that) {
case _AppModelFrontmatter():
return $default(_that.title,_that.author,_that.excerpt,_that.category,_that.date,_that.content);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? author,  String? excerpt,  String? category,  String? date,  String? content)?  $default,) {final _that = this;
switch (_that) {
case _AppModelFrontmatter() when $default != null:
return $default(_that.title,_that.author,_that.excerpt,_that.category,_that.date,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppModelFrontmatter extends AppModelFrontmatter {
  const _AppModelFrontmatter({this.title, this.author, this.excerpt, this.category, this.date, this.content}): super._();
  factory _AppModelFrontmatter.fromJson(Map<String, dynamic> json) => _$AppModelFrontmatterFromJson(json);

@override final  String? title;
@override final  String? author;
@override final  String? excerpt;
@override final  String? category;
@override final  String? date;
@override final  String? content;

/// Create a copy of AppModelFrontmatter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppModelFrontmatterCopyWith<_AppModelFrontmatter> get copyWith => __$AppModelFrontmatterCopyWithImpl<_AppModelFrontmatter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppModelFrontmatterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppModelFrontmatter&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.excerpt, excerpt) || other.excerpt == excerpt)&&(identical(other.category, category) || other.category == category)&&(identical(other.date, date) || other.date == date)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,author,excerpt,category,date,content);

@override
String toString() {
  return 'AppModelFrontmatter(title: $title, author: $author, excerpt: $excerpt, category: $category, date: $date, content: $content)';
}


}

/// @nodoc
abstract mixin class _$AppModelFrontmatterCopyWith<$Res> implements $AppModelFrontmatterCopyWith<$Res> {
  factory _$AppModelFrontmatterCopyWith(_AppModelFrontmatter value, $Res Function(_AppModelFrontmatter) _then) = __$AppModelFrontmatterCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? author, String? excerpt, String? category, String? date, String? content
});




}
/// @nodoc
class __$AppModelFrontmatterCopyWithImpl<$Res>
    implements _$AppModelFrontmatterCopyWith<$Res> {
  __$AppModelFrontmatterCopyWithImpl(this._self, this._then);

  final _AppModelFrontmatter _self;
  final $Res Function(_AppModelFrontmatter) _then;

/// Create a copy of AppModelFrontmatter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? author = freezed,Object? excerpt = freezed,Object? category = freezed,Object? date = freezed,Object? content = freezed,}) {
  return _then(_AppModelFrontmatter(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,excerpt: freezed == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
