import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zesty_chef/conf/config.inc.dart';
import 'package:zesty_chef/scoped_model/order_model.dart';
import 'package:zesty_chef/service_locator.dart';
import 'package:zesty_chef/tab_order/order_coming_soon.dart';
import 'package:zesty_chef/tab_order/order_completed.dart';
import 'package:zesty_chef/tab_order/order_pending.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<OrderPage> {
  Conf config = new Conf();
  OrderModel orderModel;
  @override
  void initState() {
    // 初始化数据
    super.initState();
    orderModel = locator<OrderModel>();
    orderModel.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<OrderModel>(
      model: orderModel,
      child: ScopedModelDescendant(
        rebuildOnChange: true,
        builder: (BuildContext context, Widget child, OrderModel model) {
          return _buildOrderBody(model);
        },
      ),
    );
  }

  Widget _buildOrderBody(OrderModel model) {
    return Stack(
      children: [
        Scaffold(
          body: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: new PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                  color: HexColor('#F1F1F1'),
                  child: SafeArea(
                    child: Column(
                      children: [
                        new Expanded(child: new Container()),
                        TabBar(
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                          ),
                          labelColor: HexColor('#727272'),
                          tabs: [
                            Tab(text: '待確認'),
                            Tab(text: '即將到來'),
                            Tab(text: '已完成'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  OrderPending(
                    model: model,
                  ),
                  OrderComingSoon(
                    model: model,
                  ),
                  OrderCompleted(
                    model: model,
                  ),
                ],
              ),
            ),
          ),
        ),
        // model.isLoading
        //     ? Container(
        //         color: Colors.black.withOpacity(0.5),
        //         child: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       )
        //     : Container(),
      ],
    );
  }
}
