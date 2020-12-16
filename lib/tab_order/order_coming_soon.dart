import 'package:flutter/widgets.dart';
import 'package:zesty_chef/model/order.dart';
import 'package:zesty_chef/scoped_model/order_model.dart';
import 'package:zesty_chef/tab_order/order_card.dart';

class OrderComingSoon extends StatelessWidget {
  final OrderModel model;
  OrderComingSoon({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Widget content = Text('no order');
    // model.orders['coming_soon'] != null
    //     ? content = _buildListView()
    //     : content = Text('no order');
    return _buildListView();
  }

  Widget _buildListView() {
    // var data = model.orders['coming_soon'];
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return OrderCard(
            model: model,
            cardType: 2,
            orderData: Order(
                name: '客家小炒',
                id: 1,
                datetime: '2020-12-05 12:00:00',
                address: '台中市北屯區崇德路二段282號',
                count: 5,
                price: 699,
                postScript: '希望餐點越客家越好',
                status: 2,
                menuId: 1,
                path: 'app/image/vvBOj5rVMwzXKz751p0TwdIuTeUQv2Cx7HTxJ15l.jpeg',
                star: 0),
          );
        });
  }
}
