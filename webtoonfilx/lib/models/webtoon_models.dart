//Json파일에서 {String, dynamic(object)}로 된 리스트를 받아오기 위한 클래스.
//named constructor를 이용하여 각각의 부분을 받아옴

class WebToonModel {
  final String title, thumb, id;

  //named constructor 부분
  WebToonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
