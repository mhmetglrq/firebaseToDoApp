import 'dart:convert';

class UserModel {
  String fullName;
  String uid;
  UserModel({
    required this.fullName,
    required this.uid,
  });
  

  UserModel copyWith({
    String? fullName,
    String? uid,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(fullName: $fullName, uid: $uid)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.fullName == fullName &&
      other.uid == uid;
  }

  @override
  int get hashCode => fullName.hashCode ^ uid.hashCode;
}
