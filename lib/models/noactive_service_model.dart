class NoActiveServiceModel
{
  late final String result;
  late final int totalresults;
  late final int startnumber;
  late final int numreturned;

  NoActiveServiceModel.fromJson(Map<String, dynamic> json){
    result = json['result'];
    totalresults = json['totalresults'];
    startnumber = json['startnumber'];
    numreturned = json['numreturned'];
  }
}