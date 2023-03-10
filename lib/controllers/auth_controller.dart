import 'package:e_commerce/data/repository/auth_repo.dart';
import 'package:e_commerce/models/response_model.dart';
import 'package:e_commerce/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});
  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  Future<ResponseModel> registration(SignUpBodyModel signUpBodyModel)async{
    _isLoading=true;
    update();
   Response response=await authRepo.registration(signUpBodyModel);
   late ResponseModel responseModel;
   if(response.statusCode==200){
    authRepo.saveUserToken(response.body["token"]);
    responseModel=ResponseModel(true, response.body["token"]);

  }else{
     responseModel=ResponseModel(false, response.statusText!);

   }
    _isLoading=false;
   update();
   return responseModel;
  }


  
  Future<ResponseModel> login(String phone,String password )async{
    print("token="+authRepo.getUserToken().toString());
    _isLoading=true;
    update();
    Response response=await authRepo.login(phone, password);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      print("backend token");
      authRepo.saveUserToken(response.body["token"]);
      print("token="+response.body["token"].toString());
      responseModel=ResponseModel(true, response.body["token"]);

    }else{
      responseModel=ResponseModel(false, response.statusText!);

    }
    _isLoading=false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number,String password){
   authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }

  }