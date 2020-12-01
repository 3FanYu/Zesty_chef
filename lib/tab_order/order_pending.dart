import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zesty_chef/model/order.dart';
import 'package:zesty_chef/scoped_model/order_model.dart';
import 'package:zesty_chef/tab_order/order_card.dart';

class OrderPending extends StatelessWidget {
  final OrderModel model;
  OrderPending({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Text('no order');
    model.orders['pending'] != null ? content = _buildListView() : content = Text('no order');
    return content;
  }

  Widget _buildListView() {
    var data = model.orders['pending'];
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return OrderCard(
            model: model,
            cardType: 1,
            orderData: data[index],
          );
        });
  }
}
