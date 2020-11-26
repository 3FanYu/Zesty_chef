import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zesty_chef/model/add_menu.dart';
import 'package:zesty_chef/scoped_model/add_menu_model.dart';
import 'package:zesty_chef/service_locator.dart';
import 'package:http_parser/http_parser.dart';

class AddMenu2 extends StatefulWidget {
  List<Asset> images;
  Map<String, dynamic> addMenuInfo;
  AddMenu2({Key key, @required this.images, @required this.addMenuInfo})
      : super(key: key);

  @override
  _AddMenu2State createState() => _AddMenu2State();
}

class _AddMenu2State extends State<AddMenu2> {
  int _currentImageIndex = 0;
  List<Asset> get images => widget.images;
  Map<String, dynamic> get addMenuInfo => widget.addMenuInfo;
  List<TextEditingController> controllers;
  AddMenuModel addMenuModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controllers = _generateTextController(images.length);
    print(controllers);
    addMenuModel = locator<AddMenuModel>();
  }

  void _updateImageIndex(int index) {
    setState(() {
      _currentImageIndex = index;
      print(_currentImageIndex);
    });
  }

  List<TextEditingController> _generateTextController(int imgNum) {
    List<TextEditingController> textEditingControllers = [];
    for (int i = 0; i < imgNum; i++) {
      var textEditingController = new TextEditingController();
      textEditingControllers.add(textEditingController);
    }
    return textEditingControllers;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AddMenuModel>(
      model: addMenuModel,
      child: ScopedModelDescendant<AddMenuModel>(
        builder: (BuildContext context, Widget child, AddMenuModel model) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor('#F1F1F1'),
              iconTheme: IconThemeData(
                color: HexColor('#898888'),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () async {

                      AddMenuData data = await _collectData();
                      model.addMenu(data);
                    },
                    child: Icon(
                      Icons.navigate_next,
                      size: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            body: _buildBody(model),
          );
        },
      ),
    );
  }

  Widget _buildBody(AddMenuModel model) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              // flex: 40,
              height: 300,
              child: Column(
                children: [
                  Container(
                    // flex: 10,
                    height: 250,
                    child: Card(
                      child: _buildCarousel(images),
                    ),
                  ),
                  Container(
                    // flex: 2,
                    height: 50,
                    child: Container(
                      child: _buildCarouselIndicator(images),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                child: _makeBorderTextField(
                    _currentImageIndex, controllers[_currentImageIndex]),
              ),
            )
          ],
        ),
        model.isLoading
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container()
      ],
    );
  }

  //生成圖片輪播器
  Widget _buildCarousel(List<Asset> images) {
    if (widget.images != null) {
      return Container(
        child: Align(
            alignment: Alignment.center,
            child: _assetsToImageFutureBuilder(images[_currentImageIndex])),
      );
    }
  }

  //生成圖片輪播器下面的圖片
  Widget _buildCarouselIndicator(List<Asset> images) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                child: AssetThumb(
                  asset: images[index],
                  width: 5000,
                  height: 5000,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width: 3,
                    color: _currentImageIndex == index
                        ? HexColor('#3890BC')
                        : HexColor('#FFFFFF'),
                  ),
                ),
              ),
              onTap: () {
                _updateImageIndex(index);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _assetsToImageFutureBuilder(Asset asset) {
    return FutureBuilder(
      future: assetThumbToImage(asset),
      builder: (context, snapshot) =>
          snapshot.hasData ? snapshot.data : Container(),
    );
  }

  Future<Image> assetThumbToImage(Asset asset) async {
    final ByteData byteData = await asset.getByteData();
    final Image image = Image.memory(byteData.buffer.asUint8List());
    return image;
  }

  //生成帶框表格欄位
  Widget _makeBorderTextField(int index, TextEditingController controller) {
    index = index + 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            '介紹第$index張圖',
            style: TextStyle(
              fontSize: 20,
              color: HexColor('#575757'),
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(right: 20, left: 20, bottom: 50),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 99,
              textAlign: TextAlign.start,
              decoration: new InputDecoration(
                  hintText: '介紹你的餐點吧...',
                  alignLabelWithHint: true,
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal),
                  )),
              controller: controller,
              style: TextStyle(
                fontSize: 18,
                height: 1.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<AddMenuData> _collectData() async {
    String name = addMenuInfo["name"];
    int cate = 1;
    int price = int.parse(addMenuInfo["price"]);
    int maximum = int.parse(addMenuInfo["maximum"]);
    int minimum = int.parse(addMenuInfo["minimum"]);
    bool isVege = addMenuInfo["is_vege"];
    String allergic = addMenuInfo["allergic"];
    String devices = addMenuInfo["devices"];
    String ps = addMenuInfo["ps"];
    List<String> descriptions = _packDescriptions(controllers);
    var files = await _packImages(images);
    return AddMenuData(
      name: name,
      categoryId: cate,
      price: price,
      maximumPeople: maximum,
      minimumPeople: minimum,
      isVege: isVege,
      allergicFood: allergic,
      devices: devices,
      postScript: ps,
      descriptions: descriptions,
      imageData: files,
    );
  }

  Future<List<List<int>>> _packImages(List<Asset> images) async {
    List<List<int>> paths = new List();
    for (var i = 0; i < images.length; i++) {
      ByteData byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      // final buffer = byteData.buffer;
      var path =
          await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);

      // MultipartFile multipartFile = await MultipartFile.fromPath(
      //   'photo',
      //   path,
      //   filename: DateTime.now().millisecondsSinceEpoch.toString(),
      //   contentType: MediaType("image", "jpg"),
      // );
      paths.add(imageData);

      // var file =await File(path).writeAsBytes(
      //     buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      // files.add(file);
    }
    return paths;
  }

  List<String> _packDescriptions(List<TextEditingController> controllers) {
    List<String> descriptions = [];
    controllers.forEach((element) {
      var desc = element.text.isEmpty ? "" : element.text;
      descriptions.add(desc);
    });
    return descriptions;
  }
}
