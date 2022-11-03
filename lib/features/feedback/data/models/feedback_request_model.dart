import 'package:equatable/equatable.dart';



        class FeedbackRequestModel {
        FeedbackRequestModel({
        required this.customerId,
        required this.channel,
        required this.rating,
        required this.comments,
        });
        late final String customerId;
        late final int channel;
        late final int rating;
        late final String comments;

        FeedbackRequestModel.fromJson(Map<String, dynamic> json){
        customerId = json['customerId'];
        channel = json['channel'];
        rating = json['rating'];
        comments = json['comments'];
        }

        Map<String, dynamic> toJson() {
        final _data = <String, dynamic>{};
        _data['customerId'] = customerId;
        _data['channel'] = channel;
        _data['rating'] = rating;
        _data['comments'] = comments;
        return _data;
        }
        }