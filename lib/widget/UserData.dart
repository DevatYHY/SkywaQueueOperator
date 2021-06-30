class UserData {

  static List<String> users = [];

  static List<String> getSuggestions(String query) {
    return List.of(users).where((user) {
      final lowerQuery = query.toLowerCase();
      final lowerUser = user.toLowerCase();
      return lowerUser.contains(lowerQuery);
    }).toList();
  }
}
