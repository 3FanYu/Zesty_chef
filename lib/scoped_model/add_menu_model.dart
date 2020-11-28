import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zesty_chef/conf/config.inc.dart';
import 'package:zesty_chef/model/add_menu.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AddMenuModel extends Model {
  Conf config = new Conf();
  bool _isLoading = false;
  String _result = "";

  bool get isLoading {
    return _isLoading;
  }

  String get result {
    return _result;
  }

  void addMenu(AddMenuData data) async {
    _isLoading = true;
    notifyListeners();
    String api = "menus";
    Uri uri = Uri.parse(config.apiPath + api);
    MultipartRequest request = http.MultipartRequest("POST", uri);
    request.fields['name'] = data.name;
    request.fields['maximum_people'] = data.maximumPeople.toString();
    request.fields['minimum_people'] = data.minimumPeople.toString();
    request.fields['is_vagetarian'] = "0";
    request.fields['price'] = data.price.toString();
    request.fields['category_id'] = data.categoryId.toString();
    request.fields['user_detail_id'] = '3';
    for (var i = 0; i < data.imageData.length; i++) {
      request.fields['descriptions[$i]'] =
          (data.descriptions[i] != null ? data.descriptions[i] : " ");
      var file = http.MultipartFile.fromBytes(
        'images[$i]',
        data.imageData[i],
        filename: DateTime.now().millisecondsSinceEpoch.toString(),
        contentType: MediaType('image', 'jpg'),
      );
      request.files.add(file);
    }
    try {
      print(request.fields);
      var response = await request.send();
      // print(jsonEncode(data.toJnson()));
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        _result = "success";
        notifyListeners();
      } else {
        print(response.reasonPhrase);
        _isLoading = false;
        _result = "failed";
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
