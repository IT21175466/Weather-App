class Forecast {
  var f_date;
  var f_icon;
  var f_temp;
  var f_wind;

  Forecast({
    required this.f_date,
    required this.f_icon,
    required this.f_temp,
    required this.f_wind,
  });

  Forecast.fromJson(Map<String, dynamic> json) {
    f_date = json['day']['date'];
    f_icon = json['day']['condition']['icon'];
    f_temp = json['day']['avgtemp_c'];
    f_wind = json['day']['maxwind_kph'];
  }
}
