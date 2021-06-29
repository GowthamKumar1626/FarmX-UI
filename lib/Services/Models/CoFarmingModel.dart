class CoFarmingModel {
  CoFarmingModel({
    this.name = '',
    this.phoneNumber = '',
    this.isAvailable = false,
    this.locationName = '',
    this.locationDetails = '',
  });
  String name;
  String phoneNumber;
  bool isAvailable;
  String locationName;
  dynamic locationDetails;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      "isFarmer": isAvailable,
      "locationName": locationName,
      "locationDetails": locationDetails,
    };
  }
}
