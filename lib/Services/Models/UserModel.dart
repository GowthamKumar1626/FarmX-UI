class UserModel {
  UserModel({
    this.name = '',
    this.phoneNumber = '',
    this.isFarmer = false,
    this.locationName = '',
    this.locationDetails = '',
  });
  String name;
  String phoneNumber;
  bool isFarmer;
  String locationName;
  dynamic locationDetails;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      "isFarmer": isFarmer,
      "locationName": locationName,
      "locationDetails": locationDetails,
    };
  }
}
