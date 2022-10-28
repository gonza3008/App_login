import 'package:flutter/material.dart';



class LoginFormProvider extends ChangeNotifier {
  
  GlobalKey<FormState> formKey = new GlobalKey();
  
  String email = '';
  String password = '';
 
  
  bool _isLoading = false;
  bool get isLoadding => _isLoading;

  set isLoadding (bool value){
    _isLoading = value;
    notifyListeners();
  }
  
//hago un geter y seter para setear el valor de la variable. 
bool _conexionFail = false;
bool get conexionFail => _conexionFail;

set conexionFail (bool value){
  _conexionFail = value;
  notifyListeners();
}

  bool isValidForm() {
    
    print(formKey.currentState?.validate());
    print('$email -- $password');
    return formKey.currentState?.validate() ?? false;
  }
}
