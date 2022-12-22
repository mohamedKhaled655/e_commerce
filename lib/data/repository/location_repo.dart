import 'package:e_commerce/data/api/api_client.dart';
import 'package:e_commerce/models/address_model.dart';
import 'package:e_commerce/utills/app_constance.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient,required this.sharedPreferences});

 Future<Response> getAddressfromGeocode(LatLng latLng)async{
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}'

    );
  }

  String getUserAddress() {
   return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
   }

   Future<Response>addAddress(AddressModel addressModel)async{
    return  await apiClient.postData(
        AppConstants.ADD_USER_ADDRESS,
        addressModel.toJson(),
    );
   }

   Future <Response>getAllAddress()async{
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
   }

   Future<bool>saveUserAddress(String address)async{

      apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
      
      return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
   }

   Future<Response>getZone(String lat,String lng)async{
   return await apiClient.getData('${AppConstants.ZONE_URI}?lat=${lat}&lng=${lng}');
   }

  Future<Response> searchLocation(String text)async{
      return await apiClient.getData('${AppConstants.SEARCH_LOCATION_URI}?search_text=${text}');
   }

  Future<Response> setLocation(String placeId)async{
    return await apiClient.getData('${AppConstants.PLACE_DETAILS_URI}?placeid=${placeId}');
  }


}