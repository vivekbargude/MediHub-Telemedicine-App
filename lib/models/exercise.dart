class Exercise {
  String? name;
  String? type;
  String? muscle;
  String? equipment;
  String? difficulty;
  String? instructions;

  Exercise(
      {this.name,
      this.type,
      this.muscle,
      this.equipment,
      this.difficulty,
      this.instructions});

  Exercise.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    muscle = json['muscle'];
    equipment = json['equipment'];
    difficulty = json['difficulty'];
    instructions = json['instructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['muscle'] = this.muscle;
    data['equipment'] = this.equipment;
    data['difficulty'] = this.difficulty;
    data['instructions'] = this.instructions;
    return data;
  }
}
