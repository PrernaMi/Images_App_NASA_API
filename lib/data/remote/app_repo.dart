import 'api_helper.dart';

class AppRepo {
  ApiHelper? apiHelper;

  AppRepo({required this.apiHelper});

  Future<dynamic> getImages() async {
    try{
      var data = await apiHelper!.getApi(
          url:
          "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=4oxEw7By70ZQyIqXdytKNTWD9taYaNeDThpwEdR7");
      return data;
    }catch(e){
      rethrow;
    }
  }
}
