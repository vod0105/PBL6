import 'package:app_shipper/pages/char_page/char_footer.dart';
import 'package:app_shipper/themes/AppColor.dart';
import 'package:app_shipper/themes/AppDimention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

class CharPage extends StatefulWidget {
  const CharPage({Key? key}) : super(key: key);

  @override
  _CharPageState createState() => _CharPageState();
}

class _CharPageState extends State<CharPage> {
  String? _selectedOption = "Tuần";
  String? _selectedOptionText = "Tuần";
  String? typePage = "Đơn hàng đã giao";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
              width: AppDimention.screenWidth,
              height: AppDimention.size80,
              decoration: BoxDecoration(color: Appcolor.mainColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: AppDimention.screenWidth,
                      child: Center(
                        child: DropdownButton<String>(
                          hint: Text('Chọn'),
                          value: typePage,
                          items: <String>[
                            'Đơn hàng đã giao',
                            'Doanh thu của bạn'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              typePage = newValue;
                            });
                          },
                        ),
                      )),
                ],
              )),
          Expanded(
            child: SingleChildScrollView(child: mainPage(typePage!)),
          ),
          CharFooter(),
        ],
      ),
    );
  }

  Widget mainPage(String typePage) {
    if (typePage == "Đơn hàng đã giao")
      return Column(
        children: [
          SizedBox(
            height: AppDimention.size20,
          ),
          Row(
            children: [
              SizedBox(
                width: AppDimention.size10,
              ),
              Icon(
                Icons.line_axis_rounded,
                size: 45,
                color: Colors.green,
              ),
              SizedBox(
                width: AppDimention.size10,
              ),
              Text(
                "Biểu đồ đơn hàng",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                width: AppDimention.size110,
                padding: EdgeInsets.all(16.0),
                child: DropdownButton<String>(
                  hint: Text('Chọn'),
                  value: _selectedOption,
                  items:
                      <String>['Tuần', 'Tháng', 'Tất cả'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppDimention.size10,
          ),
          chartToRun(_selectedOption!),
          SizedBox(
            height: AppDimention.size20,
          ),
          Row(
            children: [
              SizedBox(
                width: AppDimention.size10,
              ),
              Icon(
                Icons.line_axis_rounded,
                size: 45,
                color: Colors.blue,
              ),
              SizedBox(
                width: AppDimention.size10,
              ),
              Text(
                "Danh sách đơn hàng",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                width: AppDimention.size110,
                padding: EdgeInsets.only(left: AppDimention.size15),
                child: DropdownButton<String>(
                  hint: Text('Chọn'),
                  value: _selectedOptionText,
                  items:
                      <String>['Tuần', 'Tháng', 'Tất cả'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOptionText = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
          Container(
            width: AppDimention.screenWidth,
            margin: EdgeInsets.all(AppDimention.size10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black26),
            ),
            child: textToRun(_selectedOptionText!),
          ),
        ],
      );
    else
      return Container();
  }

  Widget chartToRun(String typeDiagram) {
    List<double> value = [];
    List<String> valueLabel = [];
    if (typeDiagram == "Tuần") {
      value = [10.0, 20.0, 5.0, 30.0, 5.0, 20.0, 10.0];
      valueLabel = ['Mon', 'Tue', 'Wed', 'Thu', 'Sat', 'Fri', 'Sun'];
    } else if (typeDiagram == "Tháng") {
      value = [
        10.0,
        20.0,
        5.0,
        30.0,
        5.0,
        20.0,
        10.0,
        10.0,
        20.0,
        5.0,
        30.0,
        5.0,
        20.0,
        10.0,
        10.0,
        20.0,
        5.0,
        30.0,
        5.0,
        20.0,
        10.0,
        10.0,
        20.0,
        5.0,
        30.0,
        5.0,
        20.0,
        10.0,
        15.0,
        10.0
      ];
      valueLabel = [
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
        '17',
        '18',
        '19',
        '20',
        '21',
        '22',
        '23',
        '24',
        '25',
        '26',
        '27',
        '28',
        '29',
        '30',
      ];
    } else {
      value = [10.0, 20.0, 5.0, 30.0, 5.0, 20.0, 10.0];
      valueLabel = ['Mon', 'Tue', 'Wed', 'Thu', 'Sat', 'Fri', 'Sun'];
    }
    final chartOptions = const ChartOptions();
    final xContainerLabelLayoutStrategy = DefaultIterativeLabelLayoutStrategy(
      options: chartOptions,
    );
    final chartData = ChartData(
      dataRows: [
        value,
      ],
      xUserLabels: valueLabel,
      dataRowsLegends: const ['Số lượng đơn hàng'],
      chartOptions: chartOptions,
    );
    final lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );
    final lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: lineChart,
    );
  }

  Widget textToRun(String typeDiagram) {
    int valueIndex;
    if (typeDiagram == "Tuần") {
      valueIndex = 7;
    } else if (typeDiagram == "Tháng") {
      valueIndex = 30;
    } else {
      valueIndex = 30;
    }

    return Column(
      children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: valueIndex > 7 ? 10 : 7,
            itemBuilder: (context, index) {
              return Container(
                width: AppDimention.screenWidth,
                padding: EdgeInsets.only(
                    left: AppDimention.size20, right: AppDimention.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ngày ${index + 1}/9/2024",
                        style: TextStyle(
                          fontSize: AppDimention.size20,
                        )),
                    SizedBox(
                      height: AppDimention.size5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Số lượng : 5"),
                        Text("Tổng tiền : 500.000 vnđ"),
                      ],
                    ),
                    SizedBox(
                      height: AppDimention.size5,
                    ),
                    Container(
                      width: AppDimention.size100,
                      height: AppDimention.size40,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Appcolor.mainColor),
                          borderRadius:
                              BorderRadius.circular(AppDimention.size10)),
                      child: Center(
                        child: Text("Chi tiết"),
                      ),
                    ),
                    SizedBox(
                      height: AppDimention.size20,
                    ),
                  ],
                ),
              );
            }),
        if (valueIndex > 7)
          Center(
            child: Text("Xem thêm"),
          ),
        SizedBox(
          height: AppDimention.size20,
        )
      ],
    );
  }
}
