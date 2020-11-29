import 'package:flutter/widgets.dart';
import 'package:zesty_chef/tab_order/order_card.dart';

class OrderCompleted extends StatefulWidget {
  OrderCompleted({Key key}) : super(key: key);

  @override
  _OrderCompletedState createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (BuildContext context, int index) {
          return OrderCard(
            cardType: 3,
          );
        });
  }
}