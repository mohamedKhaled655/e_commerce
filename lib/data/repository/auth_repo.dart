import 'package:e_commerce/data/api/api_client.dart';
import 'package:e_commerce/models/signup_body_model.dart';
import 'package:e_commerce/utills/app_constance.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient,required this.sharedPreferences});
///for registration
 Future<Response> registration(SignUpBodyModel signUpBodyModel)async{
  return await apiClient.postData(
        AppConstants.RESGISTRATION_URL,
        signUpBodyModel.toJson(),
    );
  }

 Future<bool> saveUserToken(String token)async{
   apiClient.token=token;
   apiClient.updateHeader(token);
   return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  //login

  bool userLoggedIn(){
   return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<String> getUserToken()async{
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  Future<Response> login(String phone,String password)async{
    return await apiClient.postData(
      AppConstants.LOGIN_URL,
      {
        "phone":phone,
        "password":password,
      },
    );
  }

  Future<void >saveUserNumberAndPassword(String number,String password)async{
   try{
     await sharedPreferences.setString(AppConstants.PHONE, number);
     await sharedPreferences.setString(AppConstants.PASSWORD, password);
   }catch(e){
     print(e.toString());
     throw e;
   }
  }

  bool clearSharedData(){
   sharedPreferences.remove(AppConstants.TOKEN);
   sharedPreferences.remove(AppConstants.PASSWORD);
   sharedPreferences.remove(AppConstants.PHONE);
   apiClient.token='';
   apiClient.updateHeader("");
   return true;
  }

}