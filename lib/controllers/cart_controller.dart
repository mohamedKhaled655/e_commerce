import 'package:e_commerce/data/repository/cart_repo.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utills/colors.dart';

class CartController extends GetxController{

  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int,CartModel>_items={};
  Map<int,CartModel>get items=>_items;

  void addItem(ProductData product,int quantity){

    print("item len= "+_items.length.toString());
var totalQuantity=0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {
        totalQuantity=(value.quantity!+quantity);
        return CartModel(
          id: value.id,
          img: value.img,
          name: value.name,
          price: value.price,
          quantity: value.quantity!+quantity,
          isExit:true ,
          time:DateTime.now().toString() ,
          product: product,
        );

      });
      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    }
    else{
      if(quantity>0)
        {
          _items.putIfAbsent(product.id!, () {
            print("add item to cart"+"id="+product.id.toString()+" Quant="+quantity.toString());
            _items.forEach((key, value) {
              print("quantity is = "+value.quantity.toString());
            });
            return CartModel(
              id: product.id,
              img: product.img,
              name: product.name,
              price: product.price,
              quantity: quantity,
              isExit:true ,
              time:DateTime.now().toString() ,
              product: product,
            );
          },);
        }
      else
        {
            Get.snackbar(
              "Item Count ",
              "You should at least add an item in the cart !",
              backgroundColor: AppColor.mainColor,
              colorText: Colors.white,
              duration: Duration(seconds: 2),
            );
        }

    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductData product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

 int getQuantity(ProductData product){
    var quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity=value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity=totalQuantity+value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
  int get totalAmount{
    var total=0;
    _items.forEach((key, value) {
      total +=value.quantity!*value.price!;
    });
    return total;
  }

  //عشان اخزن الداتا في sharedpreference
  List<CartModel>storageItems=[];
  List<CartModel>getCartData(){
    setCart=cartRepo.getCartList();
    return storageItems;
  }
  set setCart(List<CartModel>items){
    storageItems=items;
print("length o cart items ${storageItems.length}");
   for(int i=0;i<storageItems.length;i++){
     _items.putIfAbsent(storageItems[i].id!, () => storageItems[i]);
   }
  }

  ///////////////دي بتاعت الاضافه الي السجل
  void addToHistory(){
    cartRepo.addToCartHistory();
    clear();
  }
  //to remove from cart
  void clear(){
    _items={};
    update();
  }
  List<CartModel>getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  //دي معمله عشان احط فيها الitems بتاع ال one more
  set setItems(Map<int,CartModel>setItems){
    _items={};
    _items=setItems;
  }
  void addToCartList(){
    cartRepo.addToCartList(getItems);
update();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }
}