class Doctor {
  String? id;
  String? doctId;
  String? doctName;
  String? doctImage;
  String? doctCategory;
  String? doctDesc;

  Doctor(
      {this.id,
      this.doctId,
      this.doctName,
      this.doctImage,
      this.doctCategory,
      this.doctDesc});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    doctId = json['doctId'];
    doctName = json['doctName'];
    doctImage = json['doctImage'];
    doctCategory = json['doctCategory'];
    doctDesc = json['doctDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctId'] = this.doctId;
    data['doctName'] = this.doctName;
    data['doctImage'] = this.doctImage;
    data['doctCategory'] = this.doctCategory;
    data['doctDesc'] = this.doctDesc;
    return data;
  }
}
