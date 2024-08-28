class ProfileDetailModel {
  final String imagePath;
  final String name;
  final String clubName;
  final List<String> tags;
  final String intro;
  final String description1;
  final String description2;

  ProfileDetailModel({
    required this.imagePath,
    required this.name,
    required this.clubName,
    required this.tags,
    required this.intro,
    required this.description1,
    required this.description2,
  });
}