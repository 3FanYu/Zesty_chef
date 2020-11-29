import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class OrderCard extends StatelessWidget {
  final int cardType;
  const OrderCard({Key key, @required this.cardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cardType == 1) {
      return _builPendingCard();
    } else if (cardType == 2) {
      return _builComingCard();
    } else if (cardType == 3) {
      return _builCompletedCard();
    }
  }

//建構待確認卡片
  Widget _builPendingCard() {
    return Card(
      color: HexColor('#E5E5E5'),
      child: new InkWell(
        onTap: () {
          print('lol');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(
                'https://scontent.frmq2-1.fna.fbcdn.net/v/t1.15752-9/s1080x2048/127186554_135161574736988_6575687442504209669_n.jpg?_nc_cat=110&ccb=2&_nc_sid=ae9488&_nc_ohc=dyo5UZ2T5xEAX9Uj61E&_nc_oc=AQnmdBnkWtTprf_yA98IZAPw81O6Eg2IvlJogl53HqW9Awp3Jc1U5UJhX6bY8KeTzEg&_nc_ht=scontent.frmq2-1.fna&tp=7&oh=51af49149c90906ad375e9a0bcdc610a&oe=5FE7949B',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                new Container(
                  // color: Colors.orange,
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '菜名',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '臺中市北屯區大里路太平巷田中弄69號',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                      ),
                      Text(
                        '2020/08/26(二)18:00',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                      ),
                      SizedBox(
                        width: 200, // Some height
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '剩餘3日',
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                            ButtonTheme(
                              minWidth: 1,
                              height: 1,
                              buttonColor: HexColor('#57AE80'),
                              child: RaisedButton(
                                child: Text(
                                  '接受',
                                  style: TextStyle(fontSize: 10),
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            ButtonTheme(
                              buttonColor: HexColor('#B75353'),
                              minWidth: 1,
                              height: 1,
                              child: RaisedButton(
                                child: Text(
                                  '取消',
                                  style: TextStyle(fontSize: 10),
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: Column(
                                children: [
                                  Text(
                                    '\$998',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '2',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.person,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    indent: 2,
                                    height: 2,
                                    thickness: 2,
                                  ),
                                  Text(
                                    '\$1996',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

//建構即將到來卡片
  Widget _builComingCard() {
    return Card(
      color: HexColor('#E5E5E5'),
      child: new InkWell(
        onTap: () {
          print('lol');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(
                'https://scontent.frmq2-1.fna.fbcdn.net/v/t1.15752-9/s1080x2048/127186554_135161574736988_6575687442504209669_n.jpg?_nc_cat=110&ccb=2&_nc_sid=ae9488&_nc_ohc=dyo5UZ2T5xEAX9Uj61E&_nc_oc=AQnmdBnkWtTprf_yA98IZAPw81O6Eg2IvlJogl53HqW9Awp3Jc1U5UJhX6bY8KeTzEg&_nc_ht=scontent.frmq2-1.fna&tp=7&oh=51af49149c90906ad375e9a0bcdc610a&oe=5FE7949B',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                new Container(
                  // color: Colors.orange,
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '菜名',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '臺中市北屯區大里路太平巷田中弄69號',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                      ),
                      Text(
                        '2020/08/26(二)18:00',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                      ),
                      SizedBox(
                        width: 200, // Some height
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '剩餘3日',
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                            SizedBox(
                              width: 35,
                              child: Column(
                                children: [
                                  Text(
                                    '\$998',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '2',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.person,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    indent: 2,
                                    height: 2,
                                    thickness: 2,
                                  ),
                                  Text(
                                    '\$1996',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

//建構已完成菜單
  Widget _builCompletedCard() {
    return Card(
      color: HexColor('#E5E5E5'),
      child: new InkWell(
        onTap: () {
          print('lol');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(
                'https://scontent.frmq2-1.fna.fbcdn.net/v/t1.15752-9/s1080x2048/127186554_135161574736988_6575687442504209669_n.jpg?_nc_cat=110&ccb=2&_nc_sid=ae9488&_nc_ohc=dyo5UZ2T5xEAX9Uj61E&_nc_oc=AQnmdBnkWtTprf_yA98IZAPw81O6Eg2IvlJogl53HqW9Awp3Jc1U5UJhX6bY8KeTzEg&_nc_ht=scontent.frmq2-1.fna&tp=7&oh=51af49149c90906ad375e9a0bcdc610a&oe=5FE7949B',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                new Container(
                  // color: Colors.orange,
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '菜名',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '臺中市北屯區大里路太平巷田中弄69號',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                      ),
                      Text(
                        '2020/08/26(二)18:00',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                      ),
                      SizedBox(
                        width: 200, // Some height
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '剩餘3日',
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                            SizedBox(
                              width: 35,
                              child: Column(
                                children: [
                                  Text(
                                    '\$998',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '2',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.person,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    indent: 2,
                                    height: 2,
                                    thickness: 2,
                                  ),
                                  Text(
                                    '\$1996',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
