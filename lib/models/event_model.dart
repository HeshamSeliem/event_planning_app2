
class EventModel {
  static const String collectionName = 'Events';
  String id;
  String eventName;
  String image;
  String title;
  String descreption;
  DateTime date;
  String time;
  bool isFavorite;
   
    EventModel({
     this.id = "",
     required this.eventName,
     required this.image,
     required this.title,
     required this.descreption,
     required this.date,
     required this.time,
     this.isFavorite = false
    });  

    EventModel.fromJson(Map<String, dynamic> json) 
       :this(
    id: json['id'] ?? "",
    eventName: json['eventName'] ?? "",
    image: json['image'] ?? "" ,
    title: json['title'] ?? "" ,
    descreption: json['descreption'] ?? "",
    date: DateTime.fromMillisecondsSinceEpoch(json['date'] ?? 0 ),
    time: json['time'] ?? "" ,
    isFavorite: json['isFavorite'] ?? false ,
  );

    
     Map<String, dynamic> toJson() {
    return {
     // 'id': id,
      'eventName': eventName,
      'image': image,
      'title': title,
      'descreption': descreption,
      'date': date.millisecondsSinceEpoch,
      'time': time,
      'isFavorite': isFavorite,
    };
  }
}