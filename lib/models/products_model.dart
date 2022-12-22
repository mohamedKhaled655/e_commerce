class ProductModel{
  int? totalSize;
  int? typeId;
  int? offset;
late  List<ProductData> _products;
  List<ProductData>get products=> _products;

  ProductModel({required totalSize, required typeId, required offset, required products}){
    this.totalSize=totalSize;
    this.typeId=typeId;
    this.offset=offset;
    this._products=products;

  }
  ProductModel.fromJson(Map<String,dynamic>json){
    totalSize=json["total_size"];
    typeId = json['type_id'];
    offset = json['offset'];
    if(json["products"] !=null){
      _products=<ProductData>[];
      json["products"].forEach((v){
        _products.add( ProductData.fromJson(v));
      });
    }
  }

}

class ProductData{
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductData(this.id, this.name, this.description, this.price, this.stars,
      this.img, this.location, this.createdAt, this.updatedAt, this.typeId);

  ProductData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }
  Map<String,dynamic>toJson(){
    return{
      "id":this.id,
      "name":this.name,
      "description":this.description,
      "price":this.price,
      "stars":this.stars,
      "img":this.img,
      "location":this.location,
      "created_at":this.createdAt,
      "updated_at":this.updatedAt,
      "type_id":this.typeId,
    };
  }
}