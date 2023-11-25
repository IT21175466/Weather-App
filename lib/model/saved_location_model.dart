class SavedLocation {
  var city_name;
  var icon;
  var condition;
  var temp;
  var wind;
  var humidity;

  SavedLocation({
    required this.city_name,
    required this.condition,
    required this.icon,
    required this.temp,
    required this.humidity,
    required this.wind,
  });

  Map toJson() => {
        "cityName": city_name,
        "condition": condition,
        "icon": icon,
        "temp": temp,
        "humidity": humidity,
        "wind": wind,
      };

  SavedLocation.fromJson(Map json) {
    city_name = json['cityName'];
    condition = json['condition'];
    icon = json['icon'];
    temp = json['temp'].toString();
    humidity = json['humidity'].toString();
    wind = json['wind'].toDoubble();
  }
}
