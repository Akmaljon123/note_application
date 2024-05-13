import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_application/services/hive_service.dart';

import '../models/note_model.dart';

List<NoteModel> noteList = [];

Future<void> setup()async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  noteList = await HiveService.getData();
}


// Future<void> checkPermission() async {
//   bool serviceEnabled;
//   LocationPermission locationPermission;
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//
//   if (!serviceEnabled) {
//     return Future.error("Location service is disabled");
//   }
//
//   locationPermission = await Geolocator.checkPermission();
//   if (locationPermission == LocationPermission.denied) {
//     locationPermission = await Geolocator.requestPermission();
//     if (locationPermission == LocationPermission.denied) {
//       return Future.error("Location permission is denied");
//     }
//   }
//
//   if (locationPermission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//
//   Position userPosition = await Geolocator.getCurrentPosition();
//   lat = userPosition.latitude;
//   lon = userPosition.longitude;
// }
//
// Future<void> getData() async {
//   isLoading = false;
//   setState(() {});
//   String? result = await HttpService.get(
//       api: HttpService.apiGetWeather,
//       param: {"lat": lat.toString(), "lon": lon.toString()});
//
//   if (result != null) {
//     weatherModel = weatherModelFromJson(result);
//     await getLocation();
//     isLoading = true;
//     setState(() {});
//   }
// }
//
// Future<void> getLocation() async {
//   address = await GeoCode().reverseGeocoding(latitude: lat, longitude: lon);
// }