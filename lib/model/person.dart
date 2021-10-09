final String tablePersons = 'persons';

class PersonFields {
  static final List<String> values = [
    /// Add all fields
    uuid, name, lastname, email, foto, largefoto
  ];

//  static final String id = '_id';
  static final String uuid = 'uuid';
  static final String name = 'iname';
  static final String lastname = 'lastnamer';
  static final String email = 'email';
  static final String foto = 'foto';
  static final String largefoto = 'largefoto';
}

class Person {
// late int id;
  String uuid;
  String name;

  String lastName;
  String email;
  String foto;
  String largeFoto;

  Person({
    required this.uuid,
    required this.name,
    required this.lastName,
    required this.email,
    required this.foto,
    required this.largeFoto,
  });

  @override
  String toString() {
    return this.name;
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        //id:json['id']==null? null : json['id'],
        uuid: json['login']['uuid'] == null ? null : json['login']['uuid'],
        name: json['name']['first'] == null
            ? "Unknown name"
            : json['name']['first'],
        lastName: json['name']['last'] == null
            ? "Unknown lastname"
            : json['name']['last'],
        email: json['email'] == null ? "Unknown email" : json['email'],
        foto: json['picture']['medium'] == null
            ? null
            : json['picture']['medium'],
        largeFoto:
            json['picture']['large'] == null ? null : json['picture']['large']);
  }

  factory Person.fromDB(Map<String, dynamic> map) {
    return Person(
        //id:json['id']==null? null : json['id'],
        uuid: map[PersonFields.uuid] == null ? null : map[PersonFields.uuid],
        name: map[PersonFields.name] == null
            ? "Unknown name"
            : map[PersonFields.name],
        lastName: map[PersonFields.lastname] == null
            ? "Unknown lastname"
            : map[PersonFields.lastname],
        email: map[PersonFields.email] == null
            ? "Unknown email"
            : map[PersonFields.email],
        foto: map[PersonFields.foto] == null ? null : map[PersonFields.foto],
        largeFoto: map[PersonFields.largefoto] == null
            ? null
            : map[PersonFields.largefoto]);
  }

  Map<String, dynamic> toJson() => {
        //  PersonFields.id: id,
        PersonFields.uuid: uuid,
        PersonFields.name: name,
        PersonFields.lastname: lastName,
        PersonFields.email: email,
        PersonFields.foto: foto,
        PersonFields.largefoto: largeFoto,
      };

  Person copy(
          {int? id,
          String? uuid,
          String? name,
          String? lastname,
          String? email,
          String? foto,
          String? largefoto}) =>
      Person(
        //id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        lastName: lastname ?? this.lastName,
        email: email ?? this.email,
        foto: foto ?? this.foto,
        largeFoto: largefoto ?? this.largeFoto,
      );
}
