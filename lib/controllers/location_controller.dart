import 'dart:convert';

import 'package:e_commerce/data/api/api_checker.dart';
import 'package:e_commerce/data/repository/location_repo.dart';
import 'package:e_commerce/models/address_model.dart';
import 'package:e_commerce/models/response_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService{
 LocationRepo locationRepo;

 LocationController({required this.locationRepo});

 bool loading=false;
 late Position position;
 late Position pickPosition;
 Placemark placeMark=Placemark();
 Placemark pickPlaceMark=Placemark();
 List<AddressModel>addressList=[];
 late List<AddressModel>allAddressList;
 List<String>addressTypeList=["home","office","other"];
 int addressTypeIndex=0;

 late GoogleMapController _mapController;
 GoogleMapController get mapController=>_mapController;
bool updateAddressData=true;
bool changeAddress=true;

bool isLoading=false;//for the service zone
bool inZone=false;//if the user is in service zone or not
bool buttonDisable=true;//showing and hiding the button as the map loads



void setMapController(GoogleMapController mapController){
  _mapController=mapController;
 }

  void updatePosition(CameraPosition cPosition, bool fromAddress) async{
 if(updateAddressData)
  {
   loading=true;
   update();
   try{
    if(fromAddress)
     {
      position=Position(
       longitude: cPosition.target.longitude,
          latitude: cPosition.target.latitude,
          timestamp: DateTime.now(),
          accuracy: 1,
          altitude: 1,
          heading: 1,
          speed: 1,
          speedAccuracy: 1,
      );
     }
    else{
     pickPosition=Position(
      longitude: cPosition.target.longitude,
      latitude: cPosition.target.latitude,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
     );

    }

    ResponseModel _responseModel=await getZone(cPosition.target.latitude.toString(),
        cPosition.target.longitude.toString(),
        false);
    buttonDisable=!_responseModel.isSuccess;


    if(changeAddress)
    {
     String _address=await getAddressfromGeocode(
      LatLng(cPosition.target.latitude, cPosition.target.longitude),
     );
     fromAddress?placeMark=Placemark(name: _address):pickPlaceMark=Placemark(name: _address);

    }
    else{
     changeAddress=true;
    }
   }catch(e){print(e);}
   loading=false;
   update();
  }else{
  updateAddressData=true;
 }

  }

Future<String>getAddressfromGeocode(LatLng latLng)async{
 String _address="Unknown Location Founded ";
 Response response=await locationRepo.getAddressfromGeocode(latLng);
 if(response.body['status']=='OK')
  {
   _address=response.body['results'][0]['formatted_address'].toString();
   print("Printing address="+_address);
  }
 else{
  print("Error Getting the google api");
 }
 update();
 return _address;
}

late Map<String,dynamic>getAddress;

 AddressModel getUserAddress(){
  late AddressModel addressModel;
  //استخدمت هنا ال jsondecode عشان المتغير getAddress من نوع Mapوالفانكشن بتاع ال getUserAddress من نوع String
  getAddress=jsonDecode(locationRepo.getUserAddress());
  try{
   addressModel=AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
  }catch(e){print(e);}
  return addressModel;
 }

 void setAddressTypeIndex(int index){
  addressTypeIndex=index;
  update();
 }

 Future<ResponseModel> addAddress(AddressModel addressModel)async{
  loading=true;
  update();
  Response response=await locationRepo.addAddress(addressModel);
  ResponseModel responseModel;
  if(response.statusCode==200){
  await getAddressList();
   String message=response.body['message'];
   responseModel=ResponseModel(true, message);
  //save address in sharedprefresns
   await saveUserAddress(addressModel);

  }
  else{
   print("Couldn't save the Address");
   responseModel=ResponseModel(false, response.statusText!);

  }
  update();
  return responseModel;
 }

 Future<void>getAddressList()async{
   Response response=await locationRepo.getAllAddress();
   if(response.statusCode==200){
    addressList=[];
    allAddressList=[];
    response.body.forEach((address) {
     addressList.add(AddressModel.fromJson(address));
     allAddressList.add(AddressModel.fromJson(address));
    });
   }
   else{
    addressList=[];
    allAddressList=[];
   }
   update();
 }


 Future<bool> saveUserAddress(AddressModel addressModel)async{
   String userAddress=jsonEncode(addressModel.toJson());

   return await locationRepo.saveUserAddress(userAddress);

 }

 void clearAddressList(){
  addressList=[];
  allAddressList=[];
  update();
 }
  String getUserAddressFromLocalStorage(){
    return locationRepo.getUserAddress();
 }

void setAddAddressData(){
  position=pickPosition;
  placeMark=pickPlaceMark;
  updateAddressData=false;
  update();
 }

 Future<ResponseModel> getZone(String lat,String lng,bool markLoad)async{
  late ResponseModel _responseModel;
  if(markLoad){
   loading=true;
  }
  else{
   isLoading=true;
  }
  update();
  Response response=await locationRepo.getZone(lat, lng);
  if(response.statusCode==200){
   inZone=true;
   _responseModel=ResponseModel(true, response.body["zone_id"].toString());
  }else{
   inZone=false;
   _responseModel=ResponseModel(true, response.statusText!);

  }
  if(markLoad){
   loading=false;
  }
  else{
   isLoading=false;
  }
  print("Zone resp"+response.statusCode.toString());
  update();
  return _responseModel;
 }


  List<Prediction>predictionList=[];

 Future<List<Prediction>> searchLocation(BuildContext context,String text)async{
    if(text.isNotEmpty){
     Response response=await locationRepo.searchLocation(text);
     if(response.statusCode==200&&response.body['status']=='OK')
     {
      predictionList=[];
      response.body['predictions'].forEach((prediction)=>predictionList.add(Prediction.fromJson(prediction)));
     }
     else{
      ApiChecker.checkApi(response);
     }
    }
    return predictionList;
  }

  setLocation(String placeID,String address,GoogleMapController mapController)async{
    loading=true;
    update();
    PlacesDetailsResponse details;
    Response response=await locationRepo.setLocation(placeID);
    details=PlacesDetailsResponse.fromJson(response.body);
    pickPosition= Position(
        longitude: details.result.geometry!.location.lng,
        latitude: details.result.geometry!.location.lat,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1
    );
    pickPlaceMark=Placemark(name: address);
    changeAddress=false;
    if(!mapController.isNull){
     mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
       target: LatLng(
        details.result.geometry!.location.lat,
        details.result.geometry!.location.lng,
       ),
       zoom: 17,
      ),
     ));
    }
    loading=false;
    update();
  }

}