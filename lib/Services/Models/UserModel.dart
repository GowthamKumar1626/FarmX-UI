class UserModel {
  UserModel({
    this.name = '',
    this.phoneNumber = '',
    this.isFarmer = false,
    this.locationName = '',
    this.locationDetails = '',
    this.coFarmingAvailable = "Not Selected",
  });
  String name;
  String phoneNumber;
  bool isFarmer;
  String locationName;
  dynamic locationDetails;
  String coFarmingAvailable;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      "isFarmer": isFarmer,
      "locationName": locationName,
      "locationDetails": locationDetails,
      "coFarmingAvailable": coFarmingAvailable,
    };
  }
}
