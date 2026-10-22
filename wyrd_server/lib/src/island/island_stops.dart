import 'dart:math';

/// The island's landmarks the server sends players to for shifts and paid gigs: a name, what kind of place it is, and
/// the spot at its front door, in world units (the same map as web/index.html: a tile is 10 units, a unit is 3 m).
/// A stop counts as reached when the player's own position (from their ticks) is within [stopRadius] of it.
const stopRadius = 22.0;

const islandStops = <String, ({String name, String kind, double x, double z})>{
  'lagoscentralmosque': (name: 'Lagos Central Mosque', kind: 'mosque', x: 65.0, z: 103.0),
  'balogunmarket': (name: 'Balogun Market', kind: 'market', x: 120.0, z: 103.0),
  'idumota': (name: 'Idumota', kind: 'shops', x: 65.0, z: 63.0),
  'obaspalace': (name: "Oba's Palace", kind: 'palace', x: 120.0, z: 63.0),
  'tinubusquare': (name: 'Tinubu Square', kind: 'fountain', x: 30.0, z: 103.0),
  'cathedralchurchofchrist': (name: 'Cathedral Church of Christ', kind: 'cathedral', x: 120.0, z: 143.0),
  'tafawabalewasquare': (name: 'Tafawa Balewa Square', kind: 'field', x: 70.0, z: 143.0),
  'necomhouse': (name: 'NECOM House', kind: 'towers', x: 30.0, z: 143.0),
  'freedompark': (name: 'Freedom Park', kind: 'park', x: 70.0, z: 163.0),
  'generalhospital': (name: 'General Hospital', kind: 'hospital', x: 120.0, z: 163.0),
  'marinajetty': (name: 'Marina Jetty', kind: 'jetty', x: 30.0, z: 163.0),
  'ikoyiclub1938': (name: 'Ikoyi Club 1938', kind: 'golf', x: 250.0, z: 93.0),
  'ikoyiwaterfront': (name: 'Ikoyi waterfront', kind: 'park', x: 250.0, z: 63.0),
  'falomoshoppingcentre': (name: 'Falomo Shopping Centre', kind: 'arcade', x: 215.0, z: 123.0),
  'obalendemotorpark': (name: 'Obalende Motor Park', kind: 'motorpark', x: 175.0, z: 93.0),
  'ikoyihomes': (name: 'Ikoyi homes', kind: 'houses', x: 215.0, z: 63.0),
  'oldikoyi': (name: 'Old Ikoyi', kind: 'houses', x: 175.0, z: 63.0),
  'ekohotel': (name: 'Eko Hotel', kind: 'hotel', x: 260.0, z: 193.0),
  'lagosciviccentre': (name: 'Lagos Civic Centre', kind: 'glass', x: 215.0, z: 163.0),
  'muriokunolapark': (name: 'Muri Okunola Park', kind: 'park', x: 175.0, z: 193.0),
  'federalpalacehotel': (name: 'Federal Palace Hotel', kind: 'hotel', x: 175.0, z: 163.0),
  'barbeach': (name: 'Bar Beach', kind: 'beach', x: 215.0, z: 233.0),
  'kuramobeach': (name: 'Kuramo Beach', kind: 'beach', x: 260.0, z: 233.0),
  'ekoatlanticcity': (name: 'Eko Atlantic City', kind: 'skyline', x: 170.0, z: 283.0),
  'ekopearltowers': (name: 'Eko Pearl Towers', kind: 'skyline', x: 215.0, z: 283.0),
  'lekkitollgate': (name: 'Lekki Toll Gate', kind: 'tollgate', x: 340.0, z: 203.0),
  'nikeartgallery': (name: 'Nike Art Gallery', kind: 'gallery', x: 355.0, z: 133.0),
  'lekkiconservationcentre': (name: 'Lekki Conservation Centre', kind: 'forest', x: 400.0, z: 143.0),
  'circlemall': (name: 'Circle Mall', kind: 'mall', x: 400.0, z: 193.0),
  'elegushibeach': (name: 'Elegushi Beach', kind: 'beach', x: 355.0, z: 233.0),
  'landmarkbeach': (name: 'Landmark Beach', kind: 'beach', x: 315.0, z: 233.0),
  'lekkiphase1': (name: 'Lekki Phase 1', kind: 'houses', x: 315.0, z: 133.0),
  'lekkiestates': (name: 'Lekki estates', kind: 'houses', x: 355.0, z: 193.0),
  'ajahmarket': (name: 'Ajah Market', kind: 'market', x: 450.0, z: 143.0),
  'victoriagardencity': (name: 'Victoria Garden City', kind: 'houses', x: 485.0, z: 143.0),
  'clubozumba': (name: 'Club Ozumba', kind: 'club', x: 215.0, z: 193.0),
  'clublekki': (name: 'Club Lekki', kind: 'club', x: 400.0, z: 223.0),
  'quilox': (name: 'Quilox', kind: 'club', x: 315.0, z: 153.0),
  'secretspalace': (name: 'Secrets Palace', kind: 'club', x: 355.0, z: 153.0),
  'veinlagos': (name: 'VEIN Lagos', kind: 'club', x: 175.0, z: 123.0),
  'islandcasino': (name: 'Island Casino', kind: 'casino', x: 315.0, z: 193.0),
  'atlanticgardens': (name: 'Atlantic Gardens', kind: 'houses', x: 420.0, z: 293.0),
  'oceancrest': (name: 'Ocean Crest', kind: 'houses', x: 490.0, z: 293.0),
  'islandreservebank': (name: 'Island Reserve Bank', kind: 'bank', x: 125.0, z: 273.0),
  'polanco': (name: 'Polanco', kind: 'dealer', x: 570.0, z: 193.0),
  'lekkiluxurycars': (name: 'Lekki Luxury Cars', kind: 'dealer', x: 680.0, z: 193.0),
  'ekohomestore': (name: 'Eko Home Store', kind: 'homestore', x: 675.0, z: 293.0),
  'nationalgrid': (name: 'National Grid', kind: 'grid', x: 880.0, z: 303.0),
  'thearena': (name: 'The Arena', kind: 'arena', x: 320.0, z: 303.0),
  'hqrow': (name: 'HQ Row', kind: 'hqgate', x: 540.0, z: 223.0),
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

  /// a random stop between [lo] and [hi] units from [from], not one of [not], of one of [kinds] if given
  static String? around(Random r, String from, double lo, double hi, {Set<String> not = const {}, Set<String>? kinds}) {
    final c = [for (final e in islandStops.entries) if (!not.contains(e.key) && e.key != from && (kinds == null || kinds.contains(e.value.kind)) && dist(from, e.key) >= lo && dist(from, e.key) <= hi) e.key];
    return c.isEmpty ? null : c[r.nextInt(c.length)];
  }
}
