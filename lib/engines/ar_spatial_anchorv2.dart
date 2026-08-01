import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:developer' as developer;

class SpatialPoint {
  final double x, y, z;
  const SpatialPoint(this.x, this.y, this.z);

  @override
  String toString() => "X: ${x.toStringAsFixed(3)}, Y: ${y.toStringAsFixed(3)}, Z: ${z.toStringAsFixed(3)}";
}

class ArSpatialAnchor {
  // Clamped tracking limits prevent heap memory leak vectors entirely
  static const int maxActiveAnchorThreshold = 100;
  static final List<Map<String, dynamic>> _activeAnchors = [];

  static void pinFactToWall(String fact, SpatialPoint point) {
    final String cleanedFact = fact.trim();
    if (cleanedFact.isEmpty) return;

    // Proactively evict historical records when structural boundaries are crossed
    if (_activeAnchors.length >= maxActiveAnchorThreshold) {
      developer.log("⚙️ ArSpatialAnchor: Cache ceiling breached. Reclaiming oldest memory slots.");
      _activeAnchors.removeAt(0);
    }

    final Map<String, dynamic> anchor = {
      'id': 'ID-${DateTime.now().millisecondsSinceEpoch}',
      'fact': cleanedFact,
      'coords': point,
      'timestamp': DateTime.now().toUtc() 
    };

    _activeAnchors.add(anchor);

    developer.log("🌐 AR SPATIAL SYNC | SUCCESS | ID: ${anchor['id']} | COORDS: $point");
    
    stdout.writeln("\n--- 🌐 AR SPATIAL SYNC ---");
    stdout.writeln("STATUS: SUCCESS");
    stdout.writeln("ANCHOR_ID: ${anchor['id']}");
    stdout.writeln("CONTENT: '$cleanedFact'");
    stdout.writeln("LOCATION: $point");
    stdout.writeln("TOTAL ACTIVE ANCHORS: ${_activeAnchors.length}");
    stdout.writeln("--------------------------");
  }

  /// Returns an immutable view of active records to prevent external collection pollution
  static List<Map<String, dynamic>> get currentAnchors => List.unmodifiable(_activeAnchors);
}

/// Asynchronous event loop mapping processes sequential multi-line entries non-blocking
Future<void> main() async {
  stdout.writeln("🚀 Spatial Sync Initialized. Type your fact and coordinates safely.");
  stdout.writeln("Type 'exit' to terminate execution loops securely.");

  // Transform system standard input into a clean non-blocking stream listener contract context
  final Stream<String> inputStream = stdin
      .transform(utf8.decoder)
      .transform(const LineSplitter());

  int coordinateStateStep = 0;
  String activeFact = "";
  double xCoord = 0.0, yCoord = 0.0, zCoord = 0.0;

  stdout.write("\n[AR COORDINATE INPUT]\nFact string: ");

  await for (final String inputLine in inputStream) {
    final String line = inputLine.trim();

    if (line.toLowerCase() == 'exit') {
      stdout.writeln("Exiting spatial coordination stream gracefully.");
      break;
    }

    switch (coordinateStateStep) {
      case 0:
        if (line.isNotEmpty) {
          activeFact = line;
          coordinateStateStep = 1;
          stdout.write("X coordinate: ");
        } else {
          stdout.write("Fact string: ");
        }
        break;
      case 1:
        xCoord = double.tryParse(line) ?? 0.0;
        coordinateStateStep = 2;
        stdout.write("Y coordinate: ");
        break;
      case 2:
        yCoord = double.tryParse(line) ?? 0.0;
        coordinateStateStep = 3;
        stdout.write("Z coordinate: ");
        break;
      case 3:
        zCoord = double.tryParse(line) ?? 0.0;
        
        ArSpatialAnchor.pinFactToWall(activeFact, SpatialPoint(xCoord, yCoord, zCoord));
        
        coordinateStateStep = 0;
        activeFact = "";
        stdout.write("\n[AR COORDINATE INPUT]\nFact string: ");
        break;
    }
  }
}
