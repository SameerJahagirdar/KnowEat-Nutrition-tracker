class  Meal {
  int id;
  double carbs;
  double fat;
  double protein;
  double energy;
  String name;
  Meal({ required this.id,required this.name,required this.carbs, required this.fat, required this.energy,required this.protein});
}

class Meal_Nutri{
  List<Meal> items = [
    Meal(id:0,name:'Banana',carbs : 23,fat: 0.3,energy: 89,protein: 1.1),
    Meal(id:1,name:'Chicken',carbs : 0,fat: 14,energy: 239,protein: 27),
    Meal(id:2,name:'Curd',carbs : 3.4,fat: 4.3,energy: 98,protein: 11),
    Meal(id:3,name :'Egg',carbs : 1.1 ,fat: 11,energy: 124,protein: 13),
    Meal(id:4,name:'Oat',carbs : 66.3,fat:6.9,energy:389,protein:11.8),
    Meal(id:5,name:'Paneer',carbs : 3.57,fat:25.0,energy:321.0,protein:25),
    Meal(id:6,name:'PeanutButter',carbs : 24,fat: 50 ,energy: 588,protein: 22),
    Meal(id:7,name:'Rice',carbs : 28,fat: 0.3,energy: 130,protein: 2.7),
    Meal(id:8,name:'Soya',carbs : 33,fat:0.5,energy:345.0,protein:52),
    Meal(id:9,name:'Sprouts',carbs : 4.69,fat: 0.48,energy: 29,protein: 3.56),
    Meal(id:10,name:'Tofu',carbs : 1.2,fat: 5.3,energy: 83,protein: 10),
  ];

   double conCarbs(val,id) => (val/100)*items[id].carbs;

   double conFat(val,id) => (val/100)*items[id].fat;

   double conEnergy(val,id) => (val/100)*items[id].energy;

   double conProtein(val,id) => (val/100)*items[id].protein;

}