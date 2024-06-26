class KMLMakers {
  static screenOverlayImage(String imageUrl, double factor) =>
      '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
    <Document id ="logo">
         <name>Smart City Dashboard</name>
             <Folder>
                  <name>Splash Screen</name>
                  <ScreenOverlay>
                      <name>Logo</name>
                      <Icon><href>$imageUrl</href> </Icon>                    
                      <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
                      <screenXY x="0.60" y="0.95" xunits="fraction" yunits="fraction"/>
                      <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
                      <size x="300" y="${300 * factor}" xunits="pixels" yunits="pixels"/>
                  </ScreenOverlay>
             </Folder>
    </Document>
</kml>''';

  static String convertMarkupToNormalString(String markupString) {
    markupString = markupString.replaceAll('*', '');
    markupString = markupString.replaceAll('\'', '');
    markupString = markupString.replaceAll('"', '');
    markupString = markupString.replaceAll('\n', '<br>');

    return markupString;
  }
  static String screenOverlayBaloon(String description, String activities, String city) {
    String activitiesHtml = convertMarkupToNormalString(activities);

    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
  <open>1</open>
  <Style id="purple_paddle">
    <BalloonStyle>
          <text><![CDATA[
          <div style="color:white">
          <h2> $city </h2> 
          $description
          <p> Suggested activities: </p>
          $activitiesHtml
          </div>
      ]]></text>
      <bgColor>ff1e1e1e</bgColor>
    </BalloonStyle>
  </Style>
    <styleUrl>#purple_paddle</styleUrl>
    <gx:balloonVisibility>1</gx:balloonVisibility>
</Document>
</kml>
''';
  }

  static String lookAtLinear(double latitude, double longitude, double zoom,
      double tilt, double bearing) =>
      '<LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><range>$zoom</range><tilt>$tilt</tilt><heading>$bearing</heading><gx:altitudeMode>relativeToGround</gx:altitudeMode></LookAt>';

  static String orbitLookAtLinear(double latitude, double longitude,
      double zoom, double tilt, double bearing) =>
      '<gx:duration>60</gx:duration><gx:flyToMode>smooth</gx:flyToMode><LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><range>$zoom</range><tilt>$tilt</tilt><heading>$bearing</heading><gx:altitudeMode>relativeToGround</gx:altitudeMode></LookAt>';

  static String lookAtLinearInstant(double latitude, double longitude,
      double zoom, double tilt, double bearing) =>
      '<gx:duration>0.5</gx:duration><gx:flyToMode>smooth</gx:flyToMode><LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><range>$zoom</range><tilt>$tilt</tilt><heading>$bearing</heading><gx:altitudeMode>relativeToGround</gx:altitudeMode></LookAt>';

}