class NotificationModel {
  String type;
  String reportId;
  NotificationModel({required this.reportId, required this.type});

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map={};
    map['type']=type;
    map['reportId']=reportId;
    return map;
  }

}
