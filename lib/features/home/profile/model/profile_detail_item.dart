class ProfileDetailModel {
  final String imagePath;
  final String name;
  final String tittle;
  final String description;
  final String clubName;
  final List<String> tags;

  final String answer1;
  final String answer2;

  ProfileDetailModel({
    required this.imagePath,
    required this.name,
    required this.tittle,
    required this.description,
    required this.clubName,
    required this.tags,

    required this.answer1,
    required this.answer2,
  });
}