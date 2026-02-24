class SendFriendRequest {
  int? senderId;
  int? receiverId;
  String? requestSentBy;
  String? requestSentTo;
  String? type;

  SendFriendRequest(
      {this.senderId, this.receiverId, this.requestSentBy, this.requestSentTo, this.type});

  SendFriendRequest.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    requestSentBy = json['request_sent_by'];
    requestSentTo = json['request_sent_to'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['request_sent_by'] = requestSentBy;
    data['request_sent_to'] = requestSentTo;
    data['type'] = type;
    return data;
  }
}

class FollowRequest {
  int? senderId;
  int? receiverId;
  String? requestSentBy;
  String? requestSentTo;
  // String? type;

  FollowRequest(
      {this.senderId, this.receiverId, this.requestSentBy, this.requestSentTo,
        // this.type
      });

  FollowRequest.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    requestSentBy = json['follow_req_sent_by'];
    requestSentTo = json['follow_req_sent_to'];
    // type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['follow_req_sent_by'] = requestSentBy;
    data['follow_req_sent_to'] = requestSentTo;
    // data['type'] = type;
    return data;
  }
}

//
// "recipe_id":"2",
// "type":"kid",
// "status":"like"


class ReactionRequest {
  String? recipeid;
  String? type;
  String? status;
  // String? type;

  ReactionRequest(
      {this.recipeid, this.type, this.status,
        // this.type
      });

  ReactionRequest.fromJson(Map<String, dynamic> json) {
    recipeid = json['recipe_id'];
    type = json['type'];
    status = json['status'];
    // type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipe_id'] = recipeid;
    data['type'] = type;
    data['status'] = status;
    // data['type'] = type;
    return data;
  }
}