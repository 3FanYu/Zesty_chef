import 'package:flutter/material.dart';
import 'package:zesty_chef/tab_order/order_card.dart';

class OrderPending extends StatefulWidget {
  OrderPending({Key key}) : super(key: key);

  @override
  _OrderPendingState createState() => _OrderPendingState();
}

class _OrderPendingState extends State<OrderPending> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (BuildContext context, int index) {
          return OrderCard(
            cardType: 1,
          );
        });
  }
}
