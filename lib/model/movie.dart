class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
      this.popularity, 
      this.voteCount, 
      this.video, 
      this.posterPath, 
      this.id, 
      this.adult, 
      this.backdropPath, 
      this.originalLanguage, 
      this.originalTitle, 
      this.genreIds, 
      this.title, 
      this.voteAverage, 
      this.overview, 
      this.releaseDate});

  Movie.fromJson(Map<String, dynamic> json) {
    popularity = json["popularity"];
    voteCount = json["vote_count"];
    video = json["video"];
    posterPath = json["poster_path"];
    id = json["id"];
    adult = json["adult"];
    backdropPath = json["backdrop_path"];
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
    genreIds = json["genre_ids"] != null ? json["genre_ids"].cast<int>() : [];
    title = json["title"];
    // voteAverage = json["vote_average"];
    overview = json["overview"];
    releaseDate = json["release_date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["popularity"] = popularity;
    map["vote_count"] = voteCount;
    map["video"] = video;
    map["poster_path"] = posterPath;
    map["id"] = id;
    map["adult"] = adult;
    map["backdrop_path"] = backdropPath;
    map["original_language"] = originalLanguage;
    map["original_title"] = originalTitle;
    map["genre_ids"] = genreIds;
    map["title"] = title;
    // map["vote_average"] = voteAverage;
    map["overview"] = overview;
    map["release_date"] = releaseDate;
    return map;
  }

}