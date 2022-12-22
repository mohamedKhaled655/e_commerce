import 'package:e_commerce/base/show_custom_snakbar.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker{
  static void checkApi(Response response){
    if(response.statusCode==401)
      {
        Get.offNamed(RouteHelper.getSignInPage());
      }
    else{
      ShowCustomSnackBar(response.statusText!);
    }
  }
}