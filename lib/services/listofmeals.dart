
import 'package:flutter/material.dart';

class ListOfMeals with ChangeNotifier{
  double protein=0;
  double fat=0;
  double carbs=0;
  double energy=0;

  double proteinAdd(val) => protein+=val;
  double fatAdd(val) => fat+=val;
  double carbsAdd(val) => carbs+=val;
  double energyAdd(val) => energy+=val;
}