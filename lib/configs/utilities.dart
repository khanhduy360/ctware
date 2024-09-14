import 'package:intl/intl.dart';

DateTime parseRssDate(String rssDate) {
    // Define a list of possible date formats that RSS items might use
    List<String> dateFormats = [
      "EEE, dd MMM yyyy HH:mm:ss Z", // RFC822 format
      "yyyy-MM-dd'T'HH:mm:ssZ",      // ISO8601 format
    ];

    for (var format in dateFormats) {
      try {
        return DateFormat(format).parse(rssDate, true).toLocal();
      } catch (e) {
        // Continue trying the next format
      }
    }
    
    // If none of the formats work, throw an exception or return null
    throw FormatException("Cannot parse RSS date: $rssDate");
  }