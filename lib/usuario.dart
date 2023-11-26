class Usuario {
  int? idrol;
  String? nombrerol;
  String? descrol;
  bool? permisosrol;

  Usuario({this.idrol, this.nombrerol, this.descrol, this.permisosrol});

  Usuario.fromJson(Map<String, dynamic> json) {
    idrol = json["idrol"];
    nombrerol = json["nombrerol"];
    descrol = json["descrol"];
    permisosrol = json["permisosrol"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idrol'] = idrol;
    data['nombrerol'] = nombrerol;
    data['descrol'] = descrol;
    data['permisosrol'] = permisosrol;
    return data;
  }
}
