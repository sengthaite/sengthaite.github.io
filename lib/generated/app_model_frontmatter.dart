import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_model_frontmatter.freezed.dart';
part 'app_model_frontmatter.g.dart';

@freezed
abstract class AppModelFrontmatter with _$AppModelFrontmatter {
  const factory AppModelFrontmatter({
    String? title,
    String? author,
    String? excerpt,
    String? category,
    String? date,
    String? content,
  }) = _AppModelFrontmatter;

  const AppModelFrontmatter._();

  factory AppModelFrontmatter.fromJson(Map<String, dynamic> json) =>
      _$AppModelFrontmatterFromJson(json);
}
