class Employee {
  int? id;
  String? name;
  String? address;
  String? phoneNumber;
  String? avatar;

  Employee({
    this.id,
    this.avatar,
    this.name,
    this.phoneNumber,
    this.address,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['Logo'];
    name = json['Name'];
    phoneNumber = json['Phone'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['Logo'] = avatar;
    data['Name'] = name;
    data['Phone'] = phoneNumber;
    data['Address'] = address;

    return data;
  }
}
