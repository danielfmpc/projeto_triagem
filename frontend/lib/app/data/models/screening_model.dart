class ScreeningModel {
  int id;
  String screening;
  bool status;
  String ip;
  
  ScreeningModel({this.id, this.screening, this.status, this.ip});


  static ScreeningModel fromJson(Map<String, dynamic> json){
    return ScreeningModel(
      id: json['id'],
      screening: json['screening'],
      status: json['status'],
      ip: json['ip']
    );
  }
}