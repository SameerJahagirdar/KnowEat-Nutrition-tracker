
import 'package:flutter/material.dart';
import '/services/meal.dart';
class AddMeal extends StatefulWidget {
  const AddMeal({Key? key}) : super(key: key);

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  Meal_Nutri nut = Meal_Nutri();
  List data = [];
  Map formdata={};
  final _text = TextEditingController();
  var currval;
  String currfieldval='0';

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _submit(){
    if(_errorText==null){
      formdata.addAll({
        'id' : currval['id'],
        'name' : currval['name'],
        'fat' : nut.conFat(double.parse(currfieldval), currval['id']),
        'protein' : nut.conProtein(double.parse(currfieldval), currval['id']),
        'carbs' : nut.conCarbs(double.parse(currfieldval), currval['id']),
        'energy' : nut.conEnergy(double.parse(currfieldval), currval['id']),
        'size' : currfieldval
      });
      Navigator.pop(context,formdata);
    }
  }
  String ? get _errorText{
    var text = _text.value.text;
    if(text.isEmpty){
      return 'Can\'t be empty';
    }
    if(double.parse(text)<0){
      return'Can\'t be negative';
    }
    return null;
  }

  @override
  void initState(){
    super.initState();
    Meal_Nutri mealdata = Meal_Nutri();
    mealdata.items.forEach((element) {
      data.add({
        'id': element.id,
        'name' : element.name,
        'carbs' : element.carbs,
        'fat' : element.fat,
        'energy' : element.energy,
        'protein' : element.protein
      });

    });
     currval=data[0];
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Meal'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                const Text('Choose a Meal : ',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                const SizedBox(width: 20.0),
                DropdownButton(

                  focusColor: Colors.red,
                    value: currval,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: data.map((e){
                      return DropdownMenuItem(
                          value: e,
                          child: Text(e['name']));
                    }).toList(),
                    onChanged: (newVal){
                      setState((){
                        currval = newVal ;
                      });
                    })
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Text('Serving size : ',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                const SizedBox(width: 20.0),
                SizedBox(
                  width: 150.0,
                  height: 50.0,
                  child: TextField(
                    controller: _text,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      labelText: 'Size',
                      errorText: _errorText,
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (fieldval){
                      currfieldval=fieldval;
                      setState(()=>_text);
                    },
                  ),
                ),
                const SizedBox(width: 20.0,),
                const Text('grams',
                style: TextStyle(
                  fontSize: 20.0,
                ),
                )
              ],
            ),
            const SizedBox(height: 40.0),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red),
              ),
                onPressed: _errorText==null? _submit: null,
                icon: Icon(Icons.add),
                label: Text('Add'))
          ],
        ),
      ),
    );
  }
}
