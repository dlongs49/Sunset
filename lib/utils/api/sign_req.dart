import 'package:sunset/utils/request.dart';

Http http = new Http();



class Sign{

  codeLogin(params) async{
    Map<String, dynamic> data = params;
   return await http.post("/sign/code_login",data);
  }

}