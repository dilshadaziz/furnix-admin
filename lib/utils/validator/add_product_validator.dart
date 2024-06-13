String? productValidator({String? value,required String labelText}){

  if(value == null || value.isEmpty){
    return '$labelText can\'t be empty';
  }

}