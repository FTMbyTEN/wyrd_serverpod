import 'dart:math';

/// The island's landmarks the server sends players to for shifts and paid gigs: a name, what kind of place it is, and
/// the spot at its front door, in world units (the same map as web/index.html: the real Lagos, a tile is 10 units,
/// about 15 m across the ground). Written by tools/osm2world.py from the map itself, so the two always agree.
/// A stop counts as reached when the player's own position (from their ticks) is within [stopRadius] of it.
const stopRadius = 22.0;

const islandStops = <String, ({String name, String kind, double x, double z})>{
  'lagoscentralmosque': (name: 'Lagos Central Mosque', kind: 'mosque', x: 1335.0, z: 1683.0),
  'balogunmarket': (name: 'Balogun Market', kind: 'market', x: 1230.0, z: 1403.0),
  'idumota': (name: 'Idumota', kind: 'shops', x: 965.0, z: 1263.0),
  'obaspalace': (name: "Oba's Palace", kind: 'palace', x: 1450.0, z: 1493.0),
  'tinubusquare': (name: 'Tinubu Square', kind: 'fountain', x: 1480.0, z: 1873.0),
  'cathedralchurchofchrist': (name: 'Cathedral Church of Christ', kind: 'cathedral', x: 1490.0, z: 2163.0),
  'tafawabalewasquare': (name: 'Tafawa Balewa Square', kind: 'field', x: 2100.0, z: 2353.0),
  'necomhouse': (name: 'NECOM House', kind: 'towers', x: 1990.0, z: 2513.0),
  'freedompark': (name: 'Freedom Park', kind: 'park', x: 1970.0, z: 2303.0),
  'generalhospital': (name: 'General Hospital', kind: 'hospital', x: 1730.0, z: 2173.0),
  'marinajetty': (name: 'Marina Jetty', kind: 'jetty', x: 1390.0, z: 2323.0),
  'ikoyiclub1938': (name: 'Ikoyi Club 1938', kind: 'golf', x: 4000.0, z: 2203.0),
  'ikoyiwaterfront': (name: 'Ikoyi waterfront', kind: 'park', x: 5230.0, z: 1783.0),
  'falomoshoppingcentre': (name: 'Falomo Shopping Centre', kind: 'arcade', x: 4285.0, z: 2593.0),
  'obalendemotorpark': (name: 'Obalende Motor Park', kind: 'motorpark', x: 2755.0, z: 2243.0),
  'ikoyihomes': (name: 'Ikoyi homes', kind: 'houses', x: 4645.0, z: 1603.0),
  'oldikoyi': (name: 'Old Ikoyi', kind: 'houses', x: 3295.0, z: 2033.0),
  'ekohotel': (name: 'Eko Hotel', kind: 'hotel', x: 4420.0, z: 3923.0),
  'lagosciviccentre': (name: 'Lagos Civic Centre', kind: 'glass', x: 3695.0, z: 3313.0),
  'muriokunolapark': (name: 'Muri Okunola Park', kind: 'park', x: 4045.0, z: 3513.0),
  'federalpalacehotel': (name: 'Federal Palace Hotel', kind: 'hotel', x: 2845.0, z: 3643.0),
  'barbeach': (name: 'Bar Beach', kind: 'beach', x: 3605.0, z: 4583.0),
  'kuramobeach': (name: 'Kuramo Beach', kind: 'beach', x: 4860.0, z: 4403.0),
  'ekoatlanticcity': (name: 'Eko Atlantic City', kind: 'skyline', x: 3390.0, z: 5243.0),
  'ekopearltowers': (name: 'Eko Pearl Towers', kind: 'skyline', x: 3085.0, z: 4723.0),
  'lekkitollgate': (name: 'Lekki Toll Gate', kind: 'tollgate', x: 6260.0, z: 3253.0),
  'nikeartgallery': (name: 'Nike Art Gallery', kind: 'gallery', x: 7445.0, z: 2813.0),
  'lekkiconservationcentre': (name: 'Lekki Conservation Centre', kind: 'forest', x: 12190.0, z: 2783.0),
  'circlemall': (name: 'Circle Mall', kind: 'mall', x: 10910.0, z: 3073.0),
  'elegushibeach': (name: 'Elegushi Beach', kind: 'beach', x: 8705.0, z: 4013.0),
  'landmarkbeach': (name: 'Landmark Beach', kind: 'beach', x: 5745.0, z: 4323.0),
  'lekkiphase1': (name: 'Lekki Phase 1', kind: 'houses', x: 7525.0, z: 2483.0),
  'lekkiestates': (name: 'Lekki estates', kind: 'houses', x: 9215.0, z: 2593.0),
  'ajahmarket': (name: 'Ajah Market', kind: 'market', x: 14330.0, z: 893.0),
  'victoriagardencity': (name: 'Victoria Garden City', kind: 'houses', x: 13415.0, z: 1633.0),
  'clubozumba': (name: 'Club Ozumba', kind: 'club', x: 3845.0, z: 3383.0),
  'clublekki': (name: 'Club Lekki', kind: 'club', x: 7370.0, z: 3693.0),
  'quilox': (name: 'Quilox', kind: 'club', x: 4535.0, z: 3083.0),
  'secretspalace': (name: 'Secrets Palace', kind: 'club', x: 4055.0, z: 3633.0),
  'veinlagos': (name: 'VEIN Lagos', kind: 'club', x: 6635.0, z: 2903.0),
  'islandcasino': (name: 'Island Casino', kind: 'casino', x: 3805.0, z: 3853.0),
  'atlanticgardens': (name: 'Atlantic Gardens', kind: 'houses', x: 3760.0, z: 5613.0),
  'oceancrest': (name: 'Ocean Crest', kind: 'houses', x: 4490.0, z: 5613.0),
  'islandreservebank': (name: 'Island Reserve Bank', kind: 'bank', x: 1915.0, z: 2043.0),
  'polanco': (name: 'Polanco', kind: 'dealer', x: 9210.0, z: 273.0),
  'lekkiluxurycars': (name: 'Lekki Luxury Cars', kind: 'dealer', x: 13050.0, z: 273.0),
  'ekohomestore': (name: 'Eko Home Store', kind: 'homestore', x: 10685.0, z: 3013.0),
  'nationalgrid': (name: 'National Grid', kind: 'grid', x: 16220.0, z: 1823.0),
  'thearena': (name: 'The Arena', kind: 'arena', x: 4270.0, z: 4123.0),
  'hqrow': (name: 'HQ Row', kind: 'hqgate', x: 9960.0, z: 3163.0),
};

/// A route the server dealt: the stops in order and how far along the player is. A stop counts only when the player
/// is really there (their own position, from their ticks), got there by moving (at least 70% of the straight line
/// walked or ridden since the last stop: a jump across the map moves nothing) and no faster than a car.
class WorkRoute {
  WorkRoute(this.stops, {this.task = '', DateTime? started}) : started = started ?? DateTime.now().toUtc();
  final List<String> stops;
  final String task;
  final DateTime started;
  int at = 0;
  DateTime? lastAt;
  double? movedAt;

  bool get done => at >= stops.length;
  String? get next => done ? null : stops[at];

  Map<String, dynamic> json() => {
    'task': task, 'at': at, 'total': stops.length, 'done': done,
    'stops': [for (final id in stops) {'id': id, 'name': islandStops[id]!.name, 'x': islandStops[id]!.x, 'z': islandStops[id]!.z}],
  };

  /// Advance if [here] is at the next stop. Returns why not, or null when the stop was reached (or the route is done).
  String? step(({double x, double z, double moved})? here) {
    if (done) return null;
    if (here == null) return 'Be on the island, out in the street, to work this.';
    final s = islandStops[stops[at]]!;
    if (sqrt(pow(here.x - s.x, 2) + pow(here.z - s.z, 2)) > stopRadius) return 'Head to ${s.name}.';
    if (at > 0) {
      final p = islandStops[stops[at - 1]]!, line = sqrt(pow(s.x - p.x, 2) + pow(s.z - p.z, 2));
      final moved = here.moved - (movedAt ?? 0), secs = DateTime.now().toUtc().difference(lastAt ?? started).inMilliseconds / 1000;
      if (moved < line * 0.7) return 'You got to ${s.name} without travelling there. Go the whole way.';
      if (secs < line / 45) return 'Too fast to be real. Go again, the way anyone would.';
    }
    at++;
    lastAt = DateTime.now().toUtc();
    movedAt = here.moved;
    return null;
  }

  static double dist(String a, String b) { final p = islandStops[a]!, q = islandStops[b]!; return sqrt(pow(p.x - q.x, 2) + pow(p.z - q.z, 2)); }

  /// the stop of [kind] nearest a point (or anywhere, if [x] is null)
  static String nearestOf(String kind, double? x, double? z) {
    final c = islandStops.entries.where((e) => e.value.kind == kind).toList();
    if (x == null || z == null) return c.first.key;
    c.sort((a, b) => (pow(a.value.x - x, 2) + pow(a.value.z - z, 2)).compareTo(pow(b.value.x - x, 2) + pow(b.value.z - z, 2)));
    return c.first.key;
  }

  /// How much further apart the real map's places are than the first island's, which the distances below were set on.
  static const scale = 8.0;

  /// a random stop between [lo] and [hi] units (on the first island's scale) from [from], not one of [not], of one of
  /// [kinds] if given. With none that far, the reach doubles until one is found, so a route can always be dealt (null
  /// only when no such stop exists at all)
  static String? around(Random r, String from, double lo, double hi, {Set<String> not = const {}, Set<String>? kinds}) {
    lo *= scale;
    hi *= scale;
    for (var reach = hi; reach < 1e6; reach *= 2) {
      final c = [for (final e in islandStops.entries) if (!not.contains(e.key) && e.key != from && (kinds == null || kinds.contains(e.value.kind)) && dist(from, e.key) >= (reach == hi ? lo : 0) && dist(from, e.key) <= reach) e.key];
      if (c.isNotEmpty) return c[r.nextInt(c.length)];
    }
    return null;
  }
}
