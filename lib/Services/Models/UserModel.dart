class UserModel {
  UserModel({
    this.name = 'User',
    this.phoneNumber = '',
    this.isFarmer = false,
    this.locationName = '',
  });
  String name;
  String phoneNumber;
  bool isFarmer;
  String locationName;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      "isFarmer": isFarmer,
      "locationName": locationName,
    };
  }
}
