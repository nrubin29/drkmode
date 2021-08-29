import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable()
class GenericResponse {
  final bool success;

  const GenericResponse(this.success);

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenericResponseToJson(this);

  @override
  String toString() => 'GenericResponse(success=$success)';
}
