import 'package:flutter/material.dart';
import 'package:signzy/core/messageMethods.dart';
import 'package:signzy/helper/base_widget.dart';
import 'package:signzy/helper/contants.dart';
import 'package:signzy/view/tabs/earningTabView.dart';
import 'package:signzy/view/tabs/overviewTabView.dart';
import 'package:signzy/view/tabs/creditTabView.dart';
import 'package:signzy/view/tabs/debitTabView.dart';
import 'package:signzy/viewModel/transaction_viewModel.dart';
import 'package:sms/sms.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:signzy/viewModel/base_viewModel.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  DashboardPageState createState() => new DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  List<MessageModel> messages = [];
  Methods methods = Methods();
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.yellowAccent,
    Color(0xff303146),

  ];
  double debitAmount =5.0;
  double creditAmount = 3.0;
  List<double> transactionResponse;

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Credit", () => Constants.creditAmount );
    dataMap.putIfAbsent("Debit", () => Constants.debitAmount);
    }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TransactionViewModel>(
        model: TransactionViewModel(transactionRepository: Provider.of(context)),
    builder: (context, model, child) =>DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Color(0xff303645),
                expandedHeight: 400,
                floating: true,
                pinned: true,
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: EdgeInsets.all(30),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        _createRevenueSources(model),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Color(0X80FFFFFF),
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 3.0),
                    ),
                  ),
                  tabs: [
                    Tab(text: "Credit"),
                    Tab(text: "Debit"),
                     Tab(text: "Overview"),
                     Tab(text: "Period"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              CreditTabView(),
              DebitTabView(),
              EarningTabView(),
              OverviewTabView()
            ],
          ),
        ),
    ),
      );
  }
  Widget _createRevenueSources(TransactionViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 14.0, left: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Revenue Sources",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    FlatButton(
                      child: Text("Refresh"),
                      onPressed: ()async{
                         model.transactions().then((value) => transactionResponse = model.getTransaction);
                        setState(() {
                          debitAmount = transactionResponse[0];
                          creditAmount = transactionResponse[1];
                        });
                      },
                    )
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: Center(
                  child: PieChart(
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 1000),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 3.5,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.values[1],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

