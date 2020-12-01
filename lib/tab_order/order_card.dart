import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:zesty_chef/conf/config.inc.dart';
import 'package:zesty_chef/model/order.dart';
import 'package:zesty_chef/scoped_model/order_model.dart';
import 'package:zesty_chef/widgets/star_rating.dart';

class OrderCard extends StatelessWidget {
  final int cardType;
  final Order orderData;
  final OrderModel model;
  Conf config = new Conf();
  OrderCard({Key key, this.cardType, this.orderData, this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cardType == 1) {
      return _builPendingCard();
    } else if (cardType == 2) {
      return _builComingCard();
    } else if (cardType == 3) {
      return _builCompletedCard();
    } else
      return Text('error');
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
                config.imagePath + orderData.path,
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
                        orderData.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        orderData.address,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                      ),
                      Text(
                        orderData.datetime,
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
                                  model.acceptOrder(orderData.id);
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
                                  model.denyOrder(orderData.id);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: Column(
                                children: [
                                  Text(
                                    '\$' + orderData.price.toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        orderData.count.toString(),
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
                                    '\$' +
                                        (orderData.price * orderData.count)
                                            .toString(),
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
                config.imagePath + orderData.path,
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
                        orderData.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        orderData.address,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                      ),
                      Text(
                        orderData.datetime,
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
                                    '\$' + orderData.price.toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        orderData.count.toString(),
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
                                    '\$' +
                                        (orderData.price * orderData.count)
                                            .toString(),
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
                config.imagePath + orderData.path,
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
                        orderData.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        orderData.address,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5), fontSize: 10),
                      ),
                      Text(
                        orderData.datetime,
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
                                    orderData.price.toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        orderData.count.toString(),
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
                                    '\$' +
                                        (orderData.price * orderData.count)
                                            .toString(),
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      StarRating(
                        starCount: 5,
                        rating: orderData.star.toDouble(),
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
