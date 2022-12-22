
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/location_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/models/address_model.dart';
import 'package:e_commerce/pages/address/pick_address_map.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/app_icon_bar.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  TextEditingController addressController=TextEditingController();
  final TextEditingController contactPersonName=TextEditingController();
  final TextEditingController contactPersonNumber=TextEditingController();

  late bool isLogged;

  CameraPosition _cameraPosition=CameraPosition(target: LatLng(45.51563,-122.677433),zoom: 17);
  late LatLng _initialPosition=LatLng(45.51563,-122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogged=Get.find<AuthController>().userLoggedIn();
    if(isLogged/*&& Get.find<UserController>().userModel==null*/){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){

      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
        Get.find<LocationController>().saveUserAddress(
            Get.find<LocationController>().addressList.last
        );
      }

      Get.find<LocationController>().getUserAddress();
      _cameraPosition=CameraPosition(
          target:LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]),
          ) ,
      );
      _initialPosition=LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Page"),
        backgroundColor: AppColor.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController){

        if(userController.userModel!=null&&contactPersonName.text.isEmpty){
          contactPersonName.text=userController.userModel.name;
          contactPersonNumber.text=userController.userModel.phone;
          if(Get.find<LocationController>().addressList.isNotEmpty){
           addressController.text= Get.find<LocationController>().getUserAddress().address;
          }
        }


        return GetBuilder<LocationController>(builder: (locationController){
          addressController.text='${locationController.placeMark.name??""}'
              '${locationController.placeMark.locality??""}'
              '${locationController.placeMark.postalCode??""}'
              '${locationController.placeMark.country??""}';




          print("my view "+addressController.text);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.height200,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: Dimensions.height10/2,right: Dimensions.height10/2,left: Dimensions.height10/2),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                    border: Border.all(
                      width: 2,
                      color: AppColor.mainColor,
                    ),
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition:CameraPosition(
                          target: _initialPosition,
                          zoom: 17,
                        ),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,

                        onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition,true);
                        },
                        onCameraMove: (position){
                          _cameraPosition=position;

                        },
                        onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);
                          if(Get.find<LocationController>().addressList.isEmpty){

                          }
                        },
                        onTap: (LatLng latLng){
                          Get.toNamed(
                            RouteHelper.getPickAddressPage(),
                            arguments: PickAddressMap(
                              fromAddress:false,
                              fromSignup: true,
                              googleMapController: locationController.mapController,
                            ),
                          );

                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height20),
                  child: SizedBox(
                    height: Dimensions.height100/2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            locationController.setAddressTypeIndex(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: Dimensions.height10,horizontal: Dimensions.width20),
                            margin:EdgeInsets.only(right: Dimensions.width10) ,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200]!,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Icon(
                              index==0?Icons.home_outlined:index==1?Icons.work:Icons.location_on,
                              color: locationController.addressTypeIndex==index?AppColor.mainColor:Theme.of(context).disabledColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.width20,),
                  child: BigText(text: "Delivery Address"),
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextField(hintText: "Your Address", textEditingController: addressController, icon: Icons.map,),
                SizedBox(height: Dimensions.height20,),

                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.width20,),
                  child: BigText(text: "Contact Name"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(hintText: "Your Name", textEditingController: contactPersonName, icon: Icons.person,),
                SizedBox(height: Dimensions.height20,),

                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.width20,),
                  child: BigText(text: "Phone Number"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(hintText: "Your Phone", textEditingController: contactPersonNumber, icon: Icons.phone,),
              ],
            ),
          );
        },);
      },),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              height: Dimensions.height150,
              padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                ),
                color: AppColor.buttonBackgroundColor,

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      AddressModel _addressModel=AddressModel(
                          1,
                          contactPersonName.text,
                          contactPersonNumber.text,
                          addressController.text,
                          locationController.position.latitude.toString(),
                          locationController.position.longitude.toString(),
                          addressType:locationController.addressTypeList[locationController.addressTypeIndex],
                      );
                      locationController.addAddress(_addressModel).then((response){
                        if(response.isSuccess)
                          {
                           // Get.back();
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar("Address", "Address Added Successfully",backgroundColor: AppColor.mainColor,colorText: Colors.white);
                          }
                        else{
                          Get.snackbar("Address", "Couldn't save address ",backgroundColor: Colors.redAccent,colorText: Colors.white);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColor.mainColor,
                      ),
                      child: BigText(
                        text: "Save Address",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
