class NetworkUtil{
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance; //makes class singleton

  Future<dynamic> get(){
    return null;
  }


}