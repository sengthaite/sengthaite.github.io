// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_model_frontmatter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppModelFrontmatter _$AppModelFrontmatterFromJson(Map<String, dynamic> json) =>
    _AppModelFrontmatter(
      title: json['title'] as String?,
      author: json['author'] as String?,
      excerpt: json['excerpt'] as String?,
      category: json['category'] as String?,
      date: json['date'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$AppModelFrontmatterToJson(
  _AppModelFrontmatter instance,
) => <String, dynamic>{
  'title': instance.title,
  'author': instance.author,
  'excerpt': instance.excerpt,
  'category': instance.category,
  'date': instance.date,
  'content': instance.content,
};
