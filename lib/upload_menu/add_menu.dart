import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:zesty_chef/conf/config.inc.dart';
import 'package:zesty_chef/upload_menu/add_menu2.dart';

class AddMenu extends StatefulWidget {
  List<Asset> images;
  AddMenu({Key key, @required this.images}) : super(key: key);
  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final _formKey = GlobalKey<FormState>();
  Conf config = new Conf();
  String reason = '';
  int mealIndex = 0;
  int _currentImageIndex = 0;
  List<Asset> get images => widget.images;
  bool is_vege = false;
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _cateEditingController = TextEditingController();
  TextEditingController _priceEditingController = TextEditingController();
  TextEditingController _maximumEditingController = TextEditingController();
  TextEditingController _minimumEditingController = TextEditingController();
  TextEditingController _vegeEditingController = TextEditingController();
  TextEditingController _allergicEditingController = TextEditingController();
  TextEditingController _deviceEditingController = TextEditingController();
  TextEditingController _psEditingController = TextEditingController();

  void _updateImageIndex(int index) {
    setState(() {
      _currentImageIndex = index;
      print(_currentImageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                //檢查表單是否有漏填
                if (_formKey.currentState.validate()) {
                  Map<String, dynamic> addMenuInfo = {
                    "name": _nameEditingController.text,
                    "cate": _cateEditingController.text,
                    "price": _priceEditingController.text,
                    "maximum": _maximumEditingController.text,
                    "minimum": _minimumEditingController.text,
                    "is_vege": is_vege,
                    "allergic": _allergicEditingController.text,
                    "devices": _deviceEditingController.text,
                    "ps": _psEditingController.text,
                  };
                  print(addMenuInfo);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMenu2(
                        images: images,
                        addMenuInfo: addMenuInfo,
                      ),
                    ),
                  );
                }
              },
              child: Icon(
                Icons.navigate_next,
                size: 40.0,
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
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
        Container(
          // flex: 50,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _makeTextField("商品名稱", _nameEditingController, "此欄位為必填"),
                _makeTextField("類別", _cateEditingController, "此欄位為必填"),
                _makeNumField("價格", _priceEditingController, "此欄位為必填"),
                _makeNumField("最大份數", _maximumEditingController, "此欄位為必填"),
                _makeNumField("最小份數", _minimumEditingController, "此欄位為必填"),
                _makeRadioButtons("是否提供素食", "是", "否"),
                _makeTextField("可能過敏食材", _allergicEditingController),
                _makeTextField(
                  "廚房設備需求",
                  _deviceEditingController,
                ),
                SizedBox(height: 20),
                _makeBorderTextField("備註", _psEditingController),
              ],
            ),
          ),
        )
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

//生成表格欄位
  Widget _makeTextField(String text, TextEditingController controller,
      [String validatorText]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: HexColor('#575757'),
            ),
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.only(right: 20),
          width: 200,
          child: TextFormField(
            textAlign: TextAlign.end,
            decoration: InputDecoration(),
            controller: controller,
            style: TextStyle(
              fontSize: 18,
              height: 1.0,
              color: Colors.black,
            ),
            validator: (value) {
              if ((validatorText != null) & (value.isEmpty)) {
                return validatorText;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

//生成填寫數字欄位
  Widget _makeNumField(String text, TextEditingController controller,
      [String validatorText]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: HexColor('#575757'),
            ),
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.only(right: 20),
          width: 200,
          child: TextFormField(
            textAlign: TextAlign.end,
            decoration: InputDecoration(),
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
            style: TextStyle(
              fontSize: 18,
              height: 1.0,
              color: Colors.black,
            ),
            validator: (value) {
              if ((validatorText != null) & (value.isEmpty)) {
                return validatorText;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

//生成帶框表格欄位
  Widget _makeBorderTextField(String text, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: HexColor('#575757'),
            ),
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.only(right: 20),
          width: 200,
          child: TextField(
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: 4,
            textAlign: TextAlign.start,
            decoration: new InputDecoration(
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
      ],
    );
  }

  //生成Radio Buttons
  Widget _makeRadioButtons(String text, String op1, String op2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: HexColor('#575757'),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: RadioListTile<bool>(
              title: Text(
                '是',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  color: HexColor('#575757'),
                ),
              ),
              value: true,
              groupValue: is_vege,
              onChanged: (val) {
                setState(() {
                  is_vege = val;
                });
              }),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: RadioListTile<bool>(
              title: Text(
                '否',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  color: HexColor('#575757'),
                ),
              ),
              value: false,
              groupValue: is_vege,
              onChanged: (val) {
                setState(() {
                  is_vege = val;
                });
              }),
        ),
      ],
    );
  }
}
