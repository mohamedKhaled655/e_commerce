import 'package:e_commerce/data/repository/popular_product_repo.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/recomended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({ required this.recommendedProductRepo});

  List<dynamic>_recommendedProductList=[];
  List<dynamic>get recommendedProductList=>_recommendedProductList;

  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;

  Future<void>getRecommendedProductList()async{
    Response response =await recommendedProductRepo.getRecommendedProductList();

    if(response.statusCode==200){
      _recommendedProductList=[];
      _recommendedProductList.addAll(ProductModel.fromJson(response.body).products);
      print("get dattttta recom");
      print(_recommendedProductList);
      _isLoaded=true;
      update();
    }
    else{
      print("Dont get dattttta  rec" );
    }
  }


}