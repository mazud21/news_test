import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

// JSON format
// {"Response":"Success","Type":100,"Aggregated":false,"Data":
// [{"time":1279324800,"close":0.04951,"high":0.04951,"low":0.04951,"open":0.04951,"volumefrom":20,"volumeto":0.9902},

/// Time-series data type.
class TimeSeriesPrice {
  final String time;
  final String price;
  TimeSeriesPrice(this.time, this.price);
}

class ItemDetailsPage extends StatefulWidget {
  @override
  _ItemDetailsPageState createState() => new _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  String url =
      "https://hmazud.web.id/api_controller/Pdam_tarif";

  List dataJSON = [];

  getCoinsTimeSeries() async {
    var response = await http
        .get(Uri.parse(url), headers: {"Accept": "application/json"});

    if (this.mounted) {
      this.setState(() {
        var extractdata = json.decode(response.body);
        dataJSON = extractdata["data"];
        //dataJSON = extractdata;
        print('TEST_GAN: '+dataJSON.toString());
      });
    }
  }

  @override
  void initState() {
    this.getCoinsTimeSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Details")),
      body: chartWidget2(),
    );
  }

  /*Widget chartWidget() {
    List<TimeSeriesPrice> tsdata = [];
    if (dataJSON != null) {
      for (Map m in dataJSON) {
        try {
          tsdata.add(new TimeSeriesPrice(
              new DateTime.fromMillisecondsSinceEpoch(m['time'] * 1000, isUtc: true), m['close']+.0));
        } catch (e) {
          print(e.toString());
        }
      }
    } else {
      // Dummy list to prevent dataJSON = NULL
      tsdata.add(new TimeSeriesPrice(new DateTime.now(), 0.0));
    }

    var series = [
      new charts.Series<TimeSeriesPrice, DateTime>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesPrice coinsPrice, _) => coinsPrice.time,
        measureFn: (TimeSeriesPrice coinsPrice, _) => coinsPrice.price,
        data: tsdata,
      ),
    ];

    var chart = new charts.TimeSeriesChart(
      series,
      animate: true,
    );

    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(32.0),
            child: new SizedBox(
              height: 200.0,
              child: chart,
            ),
          ),
        ],
      ),
    );
  }*/

  Widget chartWidget2() {
    List<TimeSeriesPrice> tsdata = [];
    if (dataJSON.isNotEmpty) {
      for (Map m in dataJSON) {
        try {
          tsdata.add(new TimeSeriesPrice(m['id_tarif_air'], m['tarif']));
        } catch (e) {
          print(e.toString());
        }
      }
    } else {
      // Dummy list to prevent dataJSON = NULL
      //tsdata.add(new TimeSeriesPrice(new DateTime.now(), 0.0));
    }

    var series = [
      new charts.Series<TimeSeriesPrice, num>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesPrice coinsPrice, _) => int.parse(coinsPrice.time),
        measureFn: (TimeSeriesPrice coinsPrice, _) => int.parse(coinsPrice.price),
        data: tsdata,
      ),
    ];

    var chart = new charts.LineChart(
      series,
      animate: true,
      animationDuration: Duration(seconds: 2),
    );

    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(32.0),
            child: new SizedBox(
              height: 200.0,
              child: chart,
            ),
          ),
        ],
      ),
    );
  }
}