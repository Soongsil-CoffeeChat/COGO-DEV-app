class MentorPartResponse {
  final String picture;
  final String mentorName;
  final String part;
  final String club;
  final String username;
  final String mentorId;
  final String title;
  final String description;

  MentorPartResponse({
    required this.picture,
    required this.mentorName,
    required this.part,
    required this.club,
    required this.username,
    required this.mentorId,
    required this.title,
    required this.description,
  });

  factory MentorPartResponse.fromJson(Map<String, dynamic> json) {
    return MentorPartResponse(
      picture: json['picture'] != null ? json['picture'] as String : '',
      mentorName: json['mentorName'] != null ? json['mentorName'] as String : '',
      part: json['part'] != null ? json['part'] as String : '',
      club: json['club'] != null ? json['club'] as String : '',
      username: json['username'] != null ? json['username'] as String : '',
      mentorId: json['mentorId'].toString(),
      title: json['title'] != null ? json['title'] as String : '',
      description: json['description'] != null ? json['description'] as String : '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "picture": picture,
      "mentorName": mentorName,
      "part": part,
      "club": club,
      "username": username,
      "mentorId": mentorId,
      "title": title,
      "description": description
    };
  }

  @override
  String toString() {
    return 'MentorDetailResponse{picture: $picture, mentorName: $mentorName, part: $part, club: $club, username: $username, mentorId: $mentorId, title: $title, description: $description';
  }
}