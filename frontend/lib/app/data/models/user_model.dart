class UserModel {

  int id;
  String name;
  String cpf;
  DateTime birth;
  

  UserModel({ this.id, this.name, this.cpf, this.birth });

  static UserModel fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      name: json['name'],
      cpf: json['cpf'],
      birth: DateTime.parse(json["birth"]),
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cpf'] = this.cpf;
    return data;
  }
}