class Video {
  Video({
    this.id,
    this.title,
    this.description,
    this.url,
    this.category,
    this.vidCode,
    this.isLiked,
    this.isWatched,
    this.timeStamps,
  });

  String id;
  String title;
  String description;
  String url;
  String category;
  String vidCode;
  bool isLiked;
  bool isWatched;
  List<String> timeStamps;
}
