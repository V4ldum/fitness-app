abstract class Converter {
  static String durationToString(Duration d) {
    StringBuffer out = StringBuffer();

    if (d.inMinutes > 0) {
      out.write("${d.inMinutes}'");
    }
    if ((d.inSeconds % 60) > 0) {
      out.write("${d.inSeconds % 60}\"");
    }

    return "$out";
  }
}
