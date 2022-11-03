import 'package:equatable/equatable.dart';



        class FeedbackResponseModel {
        FeedbackResponseModel({
        required this.msg,
        required this.data,
        });
        late final String msg;
        late final Data data;

        FeedbackResponseModel.fromJson(Map<String, dynamic> json){
        msg = json['msg'];
        data = Data.fromJson(json['data']);
        }

        Map<String, dynamic> toJson() {
        final _data = <String, dynamic>{};
        _data['msg'] = msg;
        _data['data'] = data.toJson();
        return _data;
        }
        }

        class Data {
        Data({
        required this.id,
        required this.customerId,
        required this.membershipCategoryId,
        required this.channel,
        required this.rating,
        required this.comments,
        required this.createdAt,
        required this.updatedAt,
        required this.V,
        });
        late final String id;
        late final String customerId;
        late final String membershipCategoryId;
        late final int channel;
        late final int rating;
        late final String comments;
        late final String createdAt;
        late final String updatedAt;
        late final int V;

        Data.fromJson(Map<String, dynamic> json){
        id = json['_id'];
        customerId = json['customerId'];
        membershipCategoryId = json['membershipCategoryId'];
        channel = json['channel'];
        rating = json['rating'];
        comments = json['comments'];
        createdAt = json['createdAt'];
        updatedAt = json['updatedAt'];
        V = json['__v'];
        }

        Map<String, dynamic> toJson() {
        final _data = <String, dynamic>{};
        _data['_id'] = id;
        _data['customerId'] = customerId;
        _data['membershipCategoryId'] = membershipCategoryId;
        _data['channel'] = channel;
        _data['rating'] = rating;
        _data['comments'] = comments;
        _data['createdAt'] = createdAt;
        _data['updatedAt'] = updatedAt;
        _data['__v'] = V;
        return _data;
        }
        }

