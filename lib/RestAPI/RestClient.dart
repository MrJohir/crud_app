import 'dart:convert';
import 'package:crud_app/Style/Style.dart';
import 'package:http/http.dart' as http;

Future<bool> createProductRequest(formValue) async {
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var postBody = jsonEncode(formValue);
  var postHeaders = {"Content-Type": "application/json"};
  var response = await http.post(url, headers: postHeaders, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);

  if (resultCode == 200 && resultBody['status'] == "success") {
    successToast("Request Success");
    return true;
  } else {
    errorToast("Request fail try again!");
    return false;
  }
}

Future<List> createGridViewRequest() async {
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var getHeader = {"Content-Type": "application/json"};
  var response = await http.get(url, headers: getHeader);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);

  if (resultCode == 200 && resultBody['status'] == "success") {
    successToast('Request Success');
    return resultBody['data'];
  } else {
    errorToast('Request fail try again!');
    return [];
  }
}

Future<bool> deleteProductRequest(id)async{
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/"+id);
  var getHeader = {"Content-Type": "application/json"};
  var response = await http.get(url,headers: getHeader);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  
  if(resultCode == 200 && resultBody['status']=="success"){
  successToast('Request Success');
  return true;
  }else{
    errorToast('Request fail try again!');
    return false;
  }
}

Future<bool> createUpdateRequest(formValue) async {
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct");
  var postBody = jsonEncode(formValue);
  var postHeaders = {"Content-Type": "application/json"};
  var response = await http.post(url, headers: postHeaders, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);

  if (resultCode == 200 && resultBody['status'] == "success") {
    successToast("Request Success");
    return true;
  } else {
    errorToast("Request fail try again!");
    return false;
  }
}
