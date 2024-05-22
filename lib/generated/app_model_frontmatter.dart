import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_model_frontmatter.freezed.dart';
part 'app_model_frontmatter.g.dart';

@freezed
class AppModelFrontmatter with _$AppModelFrontmatter {
  const factory AppModelFrontmatter({
    String? title,
    String? author,
    String? excerpt,
    String? category,
    String? date,
  }) = _AppModelFrontmatter;

  const AppModelFrontmatter._();

  factory AppModelFrontmatter.fromJson(Map<String, dynamic> json) =>
      _$AppModelFrontmatterFromJson(json);
}
