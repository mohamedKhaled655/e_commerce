
import 'package:e_commerce/controllers/location_controller.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
   LocationDialogue({Key? key,required this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller=TextEditingController();

    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: "Search Location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
                hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  color: Theme.of(context).disabledColor,
                  fontSize: Dimensions.font20-4,
                ),
              )
            ),
            onSuggestionSelected: (Prediction suggestion){
               Get.find<LocationController>().setLocation(suggestion.placeId!,suggestion.description!,mapController);
               Get.back();
            },
            suggestionsCallback: (String pattern)async{
              return await Get.find<LocationController>().searchLocation(context, pattern);
            },
            itemBuilder: ( context,Prediction suggestion){
              return Padding(
                padding:  EdgeInsets.all(Dimensions.width10),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Expanded(child: Text(
                      suggestion.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:Theme.of(context).textTheme.headline2?.copyWith(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontSize: Dimensions.font20-4,
                      ) ,
                    )),
                  ],
                ),
              );
            },

          ),
        ),
      ),
    );
  }
}
