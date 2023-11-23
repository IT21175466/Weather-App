class City {
  var city_name;

  City({
    required this.city_name,
  });

  Map toJson() => {
        "cityName": city_name,
      };

  City.fromJson(Map json) {
    city_name = json['cityName'];
  }
}
