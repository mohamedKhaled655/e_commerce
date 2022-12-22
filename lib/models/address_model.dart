class AddressModel{
  late int id;
  late String addressType;
  late String contactPersonName;
  late String contactPersonNumber;
  late String address;
  late String latitude;
  late String longitude;

  AddressModel(
      this.id,this.contactPersonName,
      this.contactPersonNumber,
      this.address, this.latitude,
      this.longitude,
      {required this.addressType}
      );

  AddressModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    contactPersonName=json['contact_person_name']??"";
    contactPersonNumber=json['contact_person_number']??"";
    latitude=json['latitude']??"";
    address=json['address']??"";
    longitude=json['longitude']??"";
    addressType=json['address_type']??"";
  }
  Map<String,dynamic>toJson(){
    final Map<String,dynamic>data=new Map<String,dynamic>();
    data['id']=this.id;
    data['contact_person_name']=this.contactPersonName;
    data['contact_person_number']=this.contactPersonNumber;
    data['latitude']=this.latitude;
    data['address']=this.address;
    data['longitude']=this.longitude;
    data['address_type']=this.addressType;
    return data;
  }
}