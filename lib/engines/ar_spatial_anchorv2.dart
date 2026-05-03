import 'dart:io';

class SpatialPoint {
  final double x, y, z;
  SpatialPoint(this.x, this.y, this.z);

  @override
  String toString() => "X: $x, Y: $y, Z: $z";
}

class ArSpatialAnchor {
  static final List<Map<String, dynamic>> _activeAnchors = [];

  static void pinFactToWall(String fact, SpatialPoint point) {
    final anchor = {
      'id': 'ID-${DateTime.now().millisecondsSinceEpoch}',
      'fact': fact,
      'coords': point,
      'timestamp': DateTime.now()
    };
    
    _activeAnchors.add(anchor);
    
    print("\n--- 🌐 AR SPATIAL SYNC ---");
    print("STATUS: SUCCESS");
    print("ANCHOR_ID: ${anchor['id']}");
    print("CONTENT: '$fact'");
    print("LOCATION: ${point.toString()}");
    print("TOTAL ACTIVE ANCHORS: ${_activeAnchors.length}");
    print("--------------------------");
  }
}

void main() {
  while (true) {
    print("\n[AR COORDINATE INPUT]");
    
    stdout.write("Fact string: ");
    String? fact = stdin.readLineSync();

    stdout.write("X coordinate: ");
    double x = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;

    stdout.write("Y coordinate: ");
    double y = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;

    stdout.write("Z coordinate: ");
    double z = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;

    if (fact != null && fact.isNotEmpty) {
      ArSpatialAnchor.pinFactToWall(fact, SpatialPoint(x, y, z));
    }
  }
}
