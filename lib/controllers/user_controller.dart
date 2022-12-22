
import 'package:e_commerce/models/user_model.dart';
import 'package:get/get.dart';

import '../data/repository/user_repo.dart';
import '../models/response_model.dart';


class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;

  UserController({required this.userRepo,});
  bool _isLoading=false;
  bool get isLoading=>_isLoading;

 late  UserModel userModel;
  // UserModel get userModer=>_userModel;

  Future<ResponseModel> getUserInfo()async{
     // _isLoading=true;
     // update();
    Response response=await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if(response.statusCode==200){
      userModel=UserModel.fromJson(response.body);
      _isLoading=true;
      responseModel=ResponseModel(true, "Successfully");

    }else{
      responseModel=ResponseModel(false, response.statusText!);

    }

    update();
    return responseModel;
  }
}