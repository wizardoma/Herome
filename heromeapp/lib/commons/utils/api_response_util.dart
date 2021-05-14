mixin ApiResponseUtil {

  bool isOk(int code){
    return code == 200;
  }

  bool isCreated(int code){
    return code == 201;
  }

  bool isForbidden(int code){
    return code == 401;
  }
  bool isUnAuthorized(int code){
    return code == 403;
  }

  bool isServer(int code){
    return code >=500;
  }

  bool isCredentials(int code) {
    return isUnAuthorized(code) || isForbidden(code);
  }

}