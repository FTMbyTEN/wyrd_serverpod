/// Off the web there is no page to read.
String pageText() => '';

/// Off the web, nothing is kept between visits.
String? loadLocal(String key) => null;
void saveLocal(String key, String? value) {}
