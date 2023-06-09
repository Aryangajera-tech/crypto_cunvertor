import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

const String apiKey = 'D5A14DCA-186D-4AC6-896F-329CB1CE50B5';
const List<String> coinTypes = ['BTC', 'ETH', 'LTC'];

class NetworkHelper extends StatefulWidget {
  //const Spinner({Key? key}) : super(key: key);

  String value;
  NetworkHelper(this.value);
  @override
  _NetworkHelperState createState() => _NetworkHelperState();
}

class _NetworkHelperState extends State<NetworkHelper> {
  void initState() {
    getData();
  }

  void getData() async {
    List<String> exchangeData = ['', '', ''];
    for (int i = 0; i < coinTypes.length; i++) {
      String url =
          'https://rest.coinapi.io/v1/exchangerate/${coinTypes[i]}/${widget.value}?apikey=$apiKey';
      http.Response data = await http.get(Uri.parse(url));
      int temp = jsonDecode(data.body)['rate'].toInt();
      exchangeData[i] = temp.toString();
    }
    Navigator.pop(context, exchangeData);
    //return exchangeData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
      ),
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
          semanticsLabel: 'Linear progress indicator',
        ),
      ),
    );
  }
}
