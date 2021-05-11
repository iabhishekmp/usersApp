import 'package:json_annotation/json_annotation.dart';
import 'package:users_app/models/user.dart';

part 'list_users.g.dart';

@JsonSerializable()
class ListUsers {
  ListUsers(this.usersList);
  @JsonKey(name: 'users')
  List<User> usersList;

  factory ListUsers.fromJson(Map<String, dynamic> json) =>
      _$ListUsersFromJson(json);
  Map<String, dynamic> toJson() => _$ListUsersToJson(this);
}
