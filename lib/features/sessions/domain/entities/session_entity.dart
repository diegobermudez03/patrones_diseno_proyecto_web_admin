import 'package:web_admin/shared/entities/user_entity.dart';

class SessionEntity{
  final int id;
  final UserEntity user;
  bool enabled;
  final String phone_model;

  SessionEntity(this.id, this.user, this.enabled, this.phone_model);
}