// {
//     "created_at": "2021-05-11T06:12:10.58131+00:00",
//     "email": "abhishek.patil@joflee.com",
//     "first_name": "Abhishek",
//     "id": "05ee6212-deec-436e-9995-f027e9ad6df5",
//     "last_name": "Patil",
//     "updated_at": "2021-05-11T06:12:10.58131+00:00"
// }

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User(
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.updatedAt,
  );

  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "first_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
