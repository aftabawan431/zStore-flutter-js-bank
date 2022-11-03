

            class GetFeedbackResponseModel {
        GetFeedbackResponseModel({
        required this.msg,
        required this.data,
        });
        late final String msg;
        late final List<Data> data;

        GetFeedbackResponseModel.fromJson(Map<String, dynamic> json){
        msg = json['msg'];
        data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
        }

        Map<String, dynamic> toJson() {
        final _data = <String, dynamic>{};
        _data['msg'] = msg;
        _data['data'] = data.map((e)=>e.toJson()).toList();
        return _data;
        }
        }

        class Data {
        Data({
        required this.id,
        required this.customerId,
        required this.channel,
        required this.rating,
        required this.comments,
        });
        late final String id;
        late final CustomerId customerId;
        late final int channel;
        late final int rating;
        late final String comments;

        Data.fromJson(Map<String, dynamic> json){
        id = json['_id'];
        customerId = CustomerId.fromJson(json['customerId']);
        channel = json['channel'];
        rating = json['rating'];
        comments = json['comments'];
        }

        Map<String, dynamic> toJson() {
        final _data = <String, dynamic>{};
        _data['_id'] = id;
        _data['customerId'] = customerId.toJson();
        _data['channel'] = channel;
        _data['rating'] = rating;
        _data['comments'] = comments;
        return _data;
        }
        }

        class CustomerId {
        CustomerId({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.contact,
        });
        late final String id;
        late final String firstName;
        late final String lastName;
        late final String contact;

        CustomerId.fromJson(Map<String, dynamic> json){
        id = json['_id'];
        firstName = json['firstName'];
        lastName = json['lastName'];
        contact = json['contact'];
        }

        Map<String, dynamic> toJson() {
        final _data = <String, dynamic>{};
        _data['_id'] = id;
        _data['firstName'] = firstName;
        _data['lastName'] = lastName;
        _data['contact'] = contact;
        return _data;
        }
        }