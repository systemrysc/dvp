class Users {
  final int id;
  final String name;
  final String lastname;
  final String date;
  final String direction;

  Users({
    required this.id,
    required this.name,
    required this.lastname,
    required this.date,
    required this.direction,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      date: json['date'],
      direction: json['direction'],
    );
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'date': date,
      'direction': direction,
    };
  }
}
