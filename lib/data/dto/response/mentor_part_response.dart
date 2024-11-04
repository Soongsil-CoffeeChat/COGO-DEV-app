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
      picture: json['picture'] as String,
      mentorName: json['mentorName'] as String,
      part: json['part'] as String,
      club: json['club'] as String,
      username: json['username'] as String,
      mentorId: json['mentorId'].toString(),
      title: json['title'] as String,
      description: json['description'] as String,
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
}