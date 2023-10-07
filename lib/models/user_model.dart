// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: unnecessary_new, unnecessary_this

class UserModel {
  String? name;
  String? document;
  String? phone;
  String? token;
  UserData? User;
  CompanieData? Companie;

  UserModel({
    this.name,
    this.document,
    this.phone,
    this.token,
    this.User,
    this.Companie,
  });

  UserModel copyWith({
    String? name,
    String? document,
    String? phone,
    String? token,
    UserData? User,
    CompanieData? Companie,
  }) {
    return UserModel(
      name: name ?? this.name,
      document: document ?? this.document,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      User: User ?? this.User,
      Companie: Companie ?? this.Companie,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'document': document,
      'phone': phone,
      'token': token,
      'User': User?.toMap(),
      'Companie': Companie?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      document: map['document'] != null ? map['document'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      token: map['jwt'] != null ? map['jwt'] as String : null,
      User: map['User'] != null
          ? UserData.fromMap(map['User'] as Map<String, dynamic>)
          : null,
      Companie: map['Companie'] != null
          ? CompanieData.fromMap(map['Companie'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, document: $document, phone: $phone, token: $token, User: $User, Companie: $Companie)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.document == document &&
        other.phone == phone &&
        other.token == token &&
        other.User == User &&
        other.Companie == Companie;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        document.hashCode ^
        phone.hashCode ^
        token.hashCode ^
        User.hashCode ^
        Companie.hashCode;
  }
}

class CompanieData {
  int id = 0;
  String companyName = "";
  String document = "";
  String documentType = "";
  int ownerId = 0;

  CompanieData({
    required this.id,
    required this.companyName,
    required this.document,
    required this.documentType,
    required this.ownerId,
  });

  CompanieData copyWith({
    int? id,
    String? companyName,
    String? document,
    String? documentType,
    int? ownerId,
  }) {
    return CompanieData(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      document: document ?? this.document,
      documentType: documentType ?? this.documentType,
      ownerId: ownerId ?? this.ownerId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyName': companyName,
      'document': document,
      'documentType': documentType,
      'ownerId': ownerId,
    };
  }

  factory CompanieData.fromMap(Map<String, dynamic> map) {
    return CompanieData(
      id: map['id'] as int,
      companyName: map['companyName'] as String,
      document: map['document'] as String,
      documentType: map['documentType'] as String,
      ownerId: map['ownerId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanieData.fromJson(String source) =>
      CompanieData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CompanieData(id: $id, companyName: $companyName, document: $document, documentType: $documentType, ownerId: $ownerId)';
  }

  @override
  bool operator ==(covariant CompanieData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.companyName == companyName &&
        other.document == document &&
        other.documentType == documentType &&
        other.ownerId == ownerId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyName.hashCode ^
        document.hashCode ^
        documentType.hashCode ^
        ownerId.hashCode;
  }
}

class UserData {
  int id = 0;
  String email = "";
  String firebaseToken = "";
  int roleTypeId = 0;
  UserData({
    required this.id,
    required this.email,
    required this.firebaseToken,
    required this.roleTypeId,
  });

  UserData copyWith({
    int? id,
    String? email,
    String? firebaseToken,
    int? roleTypeId,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      firebaseToken: firebaseToken ?? this.firebaseToken,
      roleTypeId: roleTypeId ?? this.roleTypeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'firebaseToken': firebaseToken,
      'roleTypeId': roleTypeId,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] as int,
      email: map['email'] as String,
      firebaseToken: map['firebaseToken'] as String,
      roleTypeId: map['roleTypeId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(id: $id, email: $email, firebaseToken: $firebaseToken, roleTypeId: $roleTypeId)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.firebaseToken == firebaseToken &&
        other.roleTypeId == roleTypeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        firebaseToken.hashCode ^
        roleTypeId.hashCode;
  }
}
