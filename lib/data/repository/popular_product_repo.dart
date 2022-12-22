import 'package:e_commerce/data/api/api_client.dart';
import 'package:e_commerce/utills/app_constance.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopularProductRepo( {required this.apiClient});

  Future<Response>getPopularProductList ()async{

    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  }

}