class Directions {
  final int id;
  final String direction;

  Directions({required this.id, required this.direction});

  factory Directions.fromJson(Map<String, dynamic> json){
    return Directions(
      id: json['id'],
      direction: json['direction']
      );

  }

  toJson(){
    return {
      'id': id,
      'direction': direction
    };
  } 

}

//[]
//{}