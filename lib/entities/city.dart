
class City{
  final String name;
  final String state;
  final String country;

  String description = "";
  String activities = "";

  double longitude = 0.0;
  double latitude = 0.0;

  City({required this.name, required this.state, required this.country});

  void setCoordinate(String coords) {
    if(coords != "Unknown") {
      var split = coords.split(",");
      latitude = double.tryParse(split[0]) ?? 0.0;
      longitude = double.tryParse(split[1]) ?? 0.0;
    }
  }
}