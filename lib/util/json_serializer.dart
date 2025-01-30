/// [JsonSerializer] provides an abstract base class for implementing
/// JSON serialization and deserialization methods.
abstract class JsonSerializer {

  /// Converts the given [json] object to [double] value
  double asDouble(dynamic json) => json is num ? json.toDouble() : 0.0;

  /// Converts the given [json] object to [int] value
  int asInt(dynamic json) => json is num ? json.toInt() : 0;

  /// Converts the given [json] object to [String] value
  String asString(dynamic json) => json?.toString() ?? "";

  /// Converts the given [json] object to [List] of [String]s
  List<String> asStringList(List? json) {
    if (json == null) return List.empty();
    return json.map((e) => e?.toString() ?? "").toList();
  }
}