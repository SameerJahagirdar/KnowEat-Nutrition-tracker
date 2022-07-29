import 'package:flutter/material.dart';
import 'package:nutrifit/services/listofmeals.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 List<NutriVal> nutrival = [];
  @override
  Widget build(BuildContext context) {
    nutrival =[
      NutriVal(nutri: 'Protein', val: context.watch<ListOfMeals>().protein),
      NutriVal(nutri: 'Fat', val: context.watch<ListOfMeals>().fat),
      NutriVal(nutri: 'Carbs', val: context.watch<ListOfMeals>().carbs),
    ];
    return  SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
            children: [
              SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Protein',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Text('Fat',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text('Carbs',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text('Energy',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(context.watch<ListOfMeals>().protein.toStringAsFixed(2)+'g'),
                  Text(context.watch<ListOfMeals>().fat.toStringAsFixed(2)+'g'),
                  Text(context.watch<ListOfMeals>().carbs.toStringAsFixed(2)+'g'),
                  Text(context.watch<ListOfMeals>().energy.toStringAsFixed(2)+'kcal'),
                ],
              ),
              SfCircularChart(
                legend: Legend(isVisible: true,overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: [
                  DoughnutSeries<NutriVal,String>(
                    dataSource: nutrival,
                    xValueMapper: (NutriVal obj,_) => obj.nutri,
                    yValueMapper: (NutriVal obj,_) => double.parse(obj.val.toStringAsFixed(2)),
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                    )
                  ),
                ],
              ),
              SizedBox( height:  20.0,),
              SfCircularChart(
                legend: Legend(isVisible: true,overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: [
                  DoughnutSeries<NutriVal,String>(
                    dataSource: [
                      NutriVal(nutri: 'Energy', val: context.watch<ListOfMeals>().energy)
                    ],
                      xValueMapper: (NutriVal obj,_) => obj.nutri,
                      yValueMapper: (NutriVal obj,_) => double.parse(obj.val.toStringAsFixed(2)),
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                      )
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
class NutriVal{
 String nutri;
 double val;
 NutriVal({required this.nutri,required this.val});
}
