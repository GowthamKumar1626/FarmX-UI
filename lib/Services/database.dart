import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmx/Services/Models/UserModel.dart';
import 'package:farmx/Services/api_path.dart';

abstract class Database {
  Future<void> setGeneralUserData(UserModel userData);
  Stream<List<UserModel>> getAllUsersDataStream();
  Stream<UserModel> userDataStream();
  Stream<List<UserModel>> getAllCoFarmingFarmers();
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({required this.uid});
  final String uid;

  @override
  Future<void> setGeneralUserData(UserModel userData) => _setData(
        path: APIPath.userDataPath(uid),
        data: userData.toMap(),
      );

  Stream<List<UserModel>> getAllUsersDataStream() {
    final path = APIPath.allUsersDataPath();
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((element) {
          final data = element.data();
          return UserModel(
            name: data["name"],
            phoneNumber: data["phoneNumber"],
            isFarmer: data["isFarmer"],
            locationName: data["locationName"],
            locationDetails: data["locationDetails"],
            coFarmingAvailable: data["coFarmingAvailable"],
          );
        }).toList());
  }

  Stream<List<UserModel>> getAllCoFarmingFarmers() {
    final path = APIPath.allUsersDataPath();
    final reference = FirebaseFirestore.instance
        .collection(path)
        .where("isFarmer", isEqualTo: true);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((element) {
          final data = element.data();
          return UserModel(
            name: data["name"],
            phoneNumber: data["phoneNumber"],
            isFarmer: data["isFarmer"],
            locationName: data["locationName"],
            locationDetails: data["locationDetails"],
            coFarmingAvailable: data["coFarmingAvailable"],
          );
        }).toList());
  }

  Stream<UserModel> userDataStream() {
    final path = APIPath.userDataPath(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    return reference.snapshots().map((event) {
      final data = event.data();
      return UserModel(
        name: data!["name"],
        isFarmer: data["isFarmer"],
        phoneNumber: data["phoneNumber"],
        locationName: data["locationName"],
        locationDetails: data["locationDetails"],
        coFarmingAvailable: data["coFarmingAvailable"],
      );
    });
  }

  Future<void> _setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    bool exists = false;

    try {
      await FirebaseFirestore.instance
          .doc(path)
          .get()
          .then((doc) => doc.exists ? exists = true : exists = false);
      print(exists);

      final reference = FirebaseFirestore.instance.doc(path);
      if (exists) {
        await reference.update(data);
      } else {
        await reference.set(data);
      }
    } catch (error) {
      print(error);
    }
  }
}
