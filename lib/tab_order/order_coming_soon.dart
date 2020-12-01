import 'package:flutter/widgets.dart';
import 'package:zesty_chef/model/order.dart';
import 'package:zesty_chef/scoped_model/order_model.dart';
import 'package:zesty_chef/tab_order/order_card.dart';

class OrderComingSoon extends StatelessWidget {
  final OrderModel model;
  OrderComingSoon({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Text('no order');
    model.orders['coming_soon'] != null ? content = _buildListView() : content = Text('no order');
    return content;
  }

  Widget _buildListView() {
    var data = model.orders['coming_soon'];
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return OrderCard(
            model:model,
            cardType: 2,
            orderData: data[index],
          );
        });
  }
}
