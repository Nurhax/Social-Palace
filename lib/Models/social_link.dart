class SocialLink {
  //Profile section
  final String url;
  final String iconPath;

  //Data section
  int levelOfLink;
  int totalLogs;

  List<String> logs = [];

  //Function section
  int getNumOfLogs() {
    return logs.length;
  }

  // Constructor
  SocialLink({
    required this.url,
    required this.iconPath,
    this.levelOfLink = 0, // Default value for levelOfLink
    this.totalLogs = 0, // Default value for totalLogs
    List<String>? logs, // Optional parameter for logs
  }) : logs = logs ?? []; // Initialize logs with an empty list if not provided
}
