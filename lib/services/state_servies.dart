
import '../data/food_data.dart';

class StateService {

  static List<String> states = [
    'ANDAMAN AND NICOBAR ISLANDS',
    'AasdsdxDS',
    'absgaskjas'
  ];
  static List<FoodData> statesObj = [];


  static List<FoodData> getSuggestions(String query) {
    List<FoodData> matches = [];
    matches.addAll(statesObj);
    matches.retainWhere((s) => s.name.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }


  static reloadData(data){
    states = data;
  }


  static reloadDataObj(data){
    statesObj = data;
  }
}