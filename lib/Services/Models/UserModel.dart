class UserModel {
  UserModel({
    this.name = '',
    this.phoneNumber = '',
    this.isFarmer = false,
    this.locationName = '',
    this.locationDetails = '',
    this.coFarmingAvailable = "Not Selected",
    this.selectedDate = "none",
  });
  String name;
  String phoneNumber;
  bool isFarmer;
  String locationName;
  dynamic locationDetails;
  String coFarmingAvailable;
  dynamic selectedDate;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      "isFarmer": isFarmer,
      "locationName": locationName,
      "locationDetails": locationDetails,
      "coFarmingAvailable": coFarmingAvailable,
      "selectedDate": selectedDate,
    };
  }
}
