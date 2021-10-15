part of 'drawername_cubit.dart';

class DrawernameState extends Equatable {
  String drawerName, drawerEmail, photoUrl, role;
  DrawernameState(
      {required this.drawerName,
      required this.photoUrl,
      required this.drawerEmail,
      required this.role});

  DrawernameState copyWith(
      {String? name, String? email, String? role, String? photo}) {
    return DrawernameState(
        role: role ?? this.role,
        drawerName: name ?? this.drawerName,
        photoUrl: photo ?? this.photoUrl,
        drawerEmail: email ?? this.drawerEmail);
  }

  @override
  List<Object> get props => [drawerName, drawerEmail];
}
