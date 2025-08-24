import 'package:sengthaite_blog/features/tool/api/api_request_builder.dart';

class APIVarialbeHelper {
  static String replaceAllVariables(String template) {
    final datum = HttpRequestBuilder.getInstance().selectedDatum;
    final allVariables = datum?.allVariables;
    final response = {"Response": datum?.response ?? {}};
    if (allVariables == null || allVariables.isEmpty) return template;
    if (response.isNotEmpty) {
      for (final entry in allVariables.entries) {
        allVariables[entry.key] = getNestedValue(response, entry.value);
      }
    }
    return template.replaceAllMapped(
      RegExp(r'\@(\w+)\@'),
      (match) =>
          allVariables[match.group(1)]?.toString() ?? '\$${match.group(1)}\$',
    );
  }

  /// Get nested value from map with dot notation
  static dynamic getNestedValue(
    Map<String, dynamic> map,
    String path, {
    dynamic defaultValue,
    bool safeAccess = true,
  }) {
    if (map.isEmpty || path.isEmpty) return defaultValue;

    final parts = path.split('.');
    dynamic current = map;

    for (final part in parts) {
      if (_isArrayAccess(part)) {
        current = _handleArrayAccess(current, part, safeAccess, defaultValue);
        if (current == defaultValue && safeAccess) return defaultValue;
      } else {
        current = _handleMapAccess(current, part, safeAccess, defaultValue);
        if (current == defaultValue && safeAccess) return defaultValue;
      }

      if (current == null) return defaultValue;
    }

    return current ?? defaultValue;
  }

  /// Check if path contains array access
  static bool _isArrayAccess(String part) {
    return part.contains('[') && part.contains(']');
  }

  /// Handle array access like "users[0]"
  static dynamic _handleArrayAccess(
      dynamic current, String part, bool safeAccess, dynamic defaultValue) {
    final match = RegExp(r'^(.+)\[(\d+)\]$').firstMatch(part);
    if (match == null) {
      return safeAccess
          ? defaultValue
          : throw FormatException('Invalid array access format: $part');
    }

    final arrayKey = match.group(1);
    final index = int.tryParse(match.group(2)!);

    if (arrayKey != null && current is Map<String, dynamic>) {
      current = current[arrayKey];
    }

    if (current is List &&
        index != null &&
        index >= 0 &&
        index < current.length) {
      return current[index];
    }

    return safeAccess
        ? defaultValue
        : throw RangeError('Index $index out of bounds');
  }

  /// Handle regular map access
  static dynamic _handleMapAccess(
      dynamic current, String part, bool safeAccess, dynamic defaultValue) {
    if (current is Map<String, dynamic>) {
      if (current.containsKey(part)) {
        return current[part];
      }
      return safeAccess
          ? defaultValue
          : throw ArgumentError('Key "$part" not found');
    }
    return safeAccess
        ? defaultValue
        : throw StateError('Cannot access "$part" on non-map value');
  }

  /// Set nested value in map
  static void setNestedValue(
    Map<String, dynamic> map,
    String path,
    dynamic value, {
    bool createMissing = true,
  }) {
    final parts = path.split('.');
    dynamic current = map;

    for (int i = 0; i < parts.length - 1; i++) {
      final part = parts[i];

      if (_isArrayAccess(part)) {
        throw ArgumentError('Array access not supported for setting values');
      }

      if (current is! Map<String, dynamic>) {
        throw StateError(
            'Cannot set value at "$path" - intermediate value is not a map');
      }

      if (!current.containsKey(part)) {
        if (createMissing) {
          current[part] = <String, dynamic>{};
        } else {
          throw ArgumentError('Path "$path" does not exist');
        }
      }

      current = current[part];
    }

    final lastPart = parts.last;
    if (current is Map<String, dynamic>) {
      current[lastPart] = value;
    } else {
      throw StateError(
          'Cannot set value at "$path" - final destination is not a map');
    }
  }

  /// Check if nested path exists
  static bool hasNestedKey(Map<String, dynamic> map, String path) {
    return getNestedValue(map, path, defaultValue: const Object()) !=
        const Object();
  }

  /// Get nested value with type safety
  static T? getNestedValueAs<T>(
    Map<String, dynamic> map,
    String path, {
    T? defaultValue,
    bool safeAccess = true,
  }) {
    final value = getNestedValue(map, path,
        defaultValue: defaultValue, safeAccess: safeAccess);
    if (value is T) {
      return value;
    }
    return defaultValue;
  }
}
