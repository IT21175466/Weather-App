class Weather {
  var name;
  var icon;
  var condition;
  var temp;
  var wind;
  var humidity;
  var feelsLike;
  // var wind_dir;
  // var gust;
  // var uv;
  // var preassure;
  // var princip;
  var last_update;

  Weather({
    required this.name,
    required this.icon,
    required this.condition,
    required this.temp,
    required this.wind,
    required this.humidity,
    required this.feelsLike,
    // required this.wind_dir,
    // required this.gust,
    // required this.uv,
    // required this.preassure,
    // required this.princip,
    required this.last_update,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    name = json['location']['name'].toString();
    icon = json['current']['condition']['icon'];
    condition = json['current']['condition']['text'];
    temp = json['current']['temp_c'];
    wind = json['current']['wind_kph'];
    humidity = json['current']['humidity'];
    feelsLike = json['current']['feelslike_c'];
    last_update = json['current']['last_updated'];
    // wind_dir = json['current']['wind_dir'];
    // gust = json['current']['gust_kph'];
    // uv = json['current']['uv'];
    // preassure = json['current']['pressure_mb'];
    // princip = json['current']['precip_mm'];
  }
}
