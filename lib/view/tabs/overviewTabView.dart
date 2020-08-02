import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';


class OverviewTabView extends StatefulWidget {
  @override
  _OverviewTabViewState createState() => _OverviewTabViewState();
}

class _OverviewTabViewState extends State<OverviewTabView> {
  String dateRange = "Select Dates";
  String periodicRevenue = "-";
  var formatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Text(
              "My Earnings",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          Expanded(
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Card(
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    margin: new EdgeInsets.only(
                        left: 15.0, right: 8.0, top: 10.0, bottom: 10.0),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                            child: Text(
                              "Monthly",
                              style: TextStyle(
                                  color: Color(0xff303645),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            "Rs. 16,700",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: new EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                            child: Text(
                              "Yearly",
                              style: TextStyle(
                                  color: Color(0xff303645),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            "Rs. 2,09,453",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectDate();
                    },
                    child: Card(
                      margin: new EdgeInsets.only(
                          left: 8.0, right: 25.0, top: 10.0, bottom: 10.0),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                              child: Text(
                                dateRange,
                                style: TextStyle(
                                    color: Color(0xff303645),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              "Rs. $periodicRevenue",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void selectDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: new DateTime.now(),
      initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
      firstDate: new DateTime(2015),
      lastDate: new DateTime(2021),
    );
    print(picked);

    if (picked != null && picked.length == 2) {
      setState(() {
        dateRange = formatter.format(picked[0]).toString() +
            " - " +
            formatter.format(picked[1]).toString();
        periodicRevenue = "15,892";
      });
      print(picked);
    }
  }
}