
class StateService {

  static List<String> states = [
    'ANDAMAN AND NICOBAR ISLANDS',
    'AasdsdxDS',
    'absgaskjas'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }


  static reloadData(data){
    states = data;
  }


}