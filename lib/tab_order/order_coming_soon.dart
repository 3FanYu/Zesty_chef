import 'package:flutter/widgets.dart';
import 'package:zesty_chef/tab_order/order_card.dart';

class OrderComingSoon extends StatefulWidget {
  OrderComingSoon({Key key}) : super(key: key);

  @override
  _OrderComingSoonState createState() => _OrderComingSoonState();
}

class _OrderComingSoonState extends State<OrderComingSoon> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (BuildContext context, int index) {
          return OrderCard(
            cardType: 2,
          );
        });
  }
}
