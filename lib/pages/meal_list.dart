
import 'package:flutter/material.dart';
import 'package:nutrifit/pages/addmeal.dart';
import 'package:nutrifit/services/listofmeals.dart';
import 'package:nutrifit/services/meal.dart';
import 'package:provider/provider.dart';
import '/services/mealpreference.dart';
import 'dart:convert';
class MealList extends StatefulWidget {
  const MealList({Key? key}) : super(key: key);

  @override
  State<MealList> createState() => _MealListState();
}

class _MealListState extends State<MealList> with AutomaticKeepAliveClientMixin {
  Map data ={};
  List daymeal=[];
  List<String> predaymeal=[];
  bool get wantKeepAlive =>true;
  bool reset=false;
  void resetapp(reset){
    if(reset){
      daymeal=[];
      predaymeal=[];
    }
  }
  void getDailyMeals(){
    final previousStartupTime=MealPref().getTime().toString()!='null'?
        DateTime.parse(MealPref().getTime().toString()): DateTime.now();
    final nextMidnight = DateTime(
        previousStartupTime.year,
        previousStartupTime.month,
        previousStartupTime.day + 1);
    if(DateTime.now().isAfter(nextMidnight)){
      reset=true;
    }
    MealPref.setTime(DateTime.now().toString());
  }
  void initState(){
    super.initState();
    getDailyMeals();
    MealPref().getMeal()?.forEach((element) {
      daymeal.add(
        jsonDecode(element)
      );
      predaymeal.add(element);
      setState((){
        context.read<ListOfMeals>().protein+=jsonDecode(element)['protein'];
        context.read<ListOfMeals>().carbs+=jsonDecode(element)['carbs'];
        context.read<ListOfMeals>().fat+=jsonDecode(element)['fat'];
        context.read<ListOfMeals>().energy+=jsonDecode(element)['energy'];
      });
    });
    resetapp(reset);
  }
  void getRemove(index)async{
    setState((){
      predaymeal.removeAt(index);
    });
    await MealPref.setMeal(predaymeal);
  }
  void getMeal()async{
    dynamic result =  await Navigator.pushNamed(context, '/addmeal');
    setState(() {
      data = {
        'id': result['id'],
        'name': result['name'],
        'carbs': result['carbs'],
        'fat': result['fat'],
        'energy': result['energy'],
        'protein': result['protein'],
        'size': result['size']
      };
      daymeal.add(data);
      context.read<ListOfMeals>().protein+=data['protein'];
      context.read<ListOfMeals>().carbs+=data['carbs'];
      context.read<ListOfMeals>().fat+=data['fat'];
      context.read<ListOfMeals>().energy+=data['energy'];
    });
    daymeal.forEach((element) {
      predaymeal.add(json.encode(element));
    });
    await MealPref.setMeal(predaymeal);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    //data = ModalRoute.of(context)!.settings.arguments as Map<dynamic,dynamic>;
    //print(data);
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(

          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemCount: daymeal.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text( daymeal[index]['name'] + '   ' +daymeal[index]['size']+' g'),
                        subtitle: Text('Protein = '+daymeal[index]['protein'].toStringAsFixed(1)
                        +'g  '+'Fat = '+daymeal[index]['fat'].toStringAsFixed(1)+'g  '+
                            'Energy = '+daymeal[index]['energy'].toStringAsFixed(1)+'kcal'
                        ),
                        onTap: (){
                        },
                        trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: (){
                                  setState((){
                                   context.read<ListOfMeals>().protein-=daymeal[index]['protein'];
                                   context.read<ListOfMeals>().carbs-=daymeal[index]['carbs'];
                                   context.read<ListOfMeals>().fat-=daymeal[index]['fat'];
                                   context.read<ListOfMeals>().energy-=daymeal[index]['energy'];
                                    getRemove(index);
                                    daymeal.removeAt(index);
                                  });
                                },
                              ),
                          ),
                    );
                  }),
            SizedBox(height: 20.0,),
            FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              onPressed: ()async{
                getMeal();
              },
            ),
          ],
      ),
    );
  }
}
