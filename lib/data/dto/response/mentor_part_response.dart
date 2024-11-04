class MentorPartResponse {
  final String? picture;
  final String? mentorName;
  final String? part;
  final String? club;
  final String? username;
  final int mentorId;
  final String? title;
  final String? description;

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
      picture: json['picture'],
      mentorName: json['mentorName'],
      part: json['part'],
      club: json['club'],
      username: json['username'],
      mentorId: json['mentorId'],
      title: json['title'],
      description: json['description'],
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
