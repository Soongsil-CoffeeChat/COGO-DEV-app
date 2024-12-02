class MyPageInfo {
  final String name;
  /// part와 club을 합친 태그 리스트
  final List<String> tags; 
  final String? picture;

  MyPageInfo({
    required this.name,
    required this.tags,
    required this.picture,
  });
}
