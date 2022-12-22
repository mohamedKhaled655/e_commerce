import 'package:e_commerce/base/custom_bottom.dart';
import 'package:e_commerce/controllers/location_controller.dart';
import 'package:e_commerce/pages/address/widgets/search_location_pages.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  PickAddressMap(
      {Key? key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(
        target: _initialPosition,
        zoom: 17,
      );
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["latitude"]));
        _cameraPosition = CameraPosition(
          target: _initialPosition,
          zoom: 17,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition),
                    zoomControlsEnabled: false,
                    onCameraMove: (cameraPosition) {
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>()
                          .updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController){
                      _mapController=mapController;
                    },
                  ),
                  Center(
                    child: !locationController.loading
                        ? Icon(
                            Icons.location_on_outlined,
                            size: 35,
                          )
                        : CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: InkWell(
                      onTap: ()=>Get.dialog(LocationDialogue(mapController: _mapController),),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimensions.width10),
                        height: Dimensions.height100 / 2,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                          color: AppColor.mainColor,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColor.yellowColor,
                            ),
                            Expanded(
                              child: Text(
                                locationController.pickPlaceMark.name ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font15 + 3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: Dimensions.width10,),
                            Icon(Icons.search,size: Dimensions.font20+Dimensions.font20/4,color: AppColor.yellowColor,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.height150,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: locationController.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                            buttonText: locationController.inZone
                                ? widget.fromAddress
                                    ? "Pick Address"
                                    : "Pick Location"
                                : "Service is not available in your area",
                            icon: Icons.location_on,
                            onPressed: (locationController.buttonDisable ||
                                    locationController.loading)
                                ? null
                                : () {
                                    if (locationController
                                                .pickPosition.latitude !=
                                            0 &&
                                        locationController.pickPlaceMark.name !=
                                            null) {
                                      if (widget.fromAddress == false) {
                                        if (widget.googleMapController !=
                                            null) {
                                          print("Now You Can Clicked on this");
                                          widget.googleMapController!
                                              .moveCamera(CameraUpdate
                                                  .newCameraPosition(
                                                      CameraPosition(
                                                          target: LatLng(
                                            locationController
                                                .pickPosition.latitude,
                                            locationController
                                                .pickPosition.longitude,
                                          ))));
                                          locationController
                                              .setAddAddressData();
                                        }
                                        Get.toNamed(
                                            RouteHelper.getAddAddressPage());
                                      }
                                    }
                                  },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
