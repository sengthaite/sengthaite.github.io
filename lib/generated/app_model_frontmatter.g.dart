// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_model_frontmatter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppModelFrontmatterImpl _$$AppModelFrontmatterImplFromJson(
        Map<String, dynamic> json) =>
    _$AppModelFrontmatterImpl(
      title: json['title'] as String?,
      author: json['author'] as String?,
      excerpt: json['excerpt'] as String?,
      category: json['category'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$$AppModelFrontmatterImplToJson(
        _$AppModelFrontmatterImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'excerpt': instance.excerpt,
      'category': instance.category,
      'date': instance.date,
    };
