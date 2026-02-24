class AddStoriesRequest {
  String? storyid;
  String? title;
  String? description;
  String? storiesVideolink;
  AddStoriesRequest({this.storyid,this.title, this.description,this.storiesVideolink});

  AddStoriesRequest.fromJson(Map<String, dynamic> json) {
    storyid = json['story_id'];
    title = json['title'];
    description = json['description'];
    storiesVideolink = json['video_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['story_id'] =storyid;
    data['title'] = title;
    data['description'] = description;
    data['video_link'] =storiesVideolink;
    return data;
  }
}