import 'package:e_commerce/data/api/api_client.dart';
import 'package:e_commerce/utills/app_constance.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;

  RecommendedProductRepo( {required this.apiClient});

  Future<Response>getRecommendedProductList ()async{

    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URL);
  }

}