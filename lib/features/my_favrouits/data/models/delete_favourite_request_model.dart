class DeleteFavouriteRequestModel {
  DeleteFavouriteRequestModel({
    required this.favouriteId,
  });
  late final String favouriteId;

  DeleteFavouriteRequestModel.fromJson(Map<String, dynamic> json){
    favouriteId = json['favouriteId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['favouriteId'] = favouriteId;
    return _data;
  }
}