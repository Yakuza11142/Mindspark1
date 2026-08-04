import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';
import 'package:uuid/uuid.dart';

/// Highly optimized knowledge structure featuring AR Asset detection and structural semantic maps.
class AdvancedKnowledgeNode {
  final String id;
  final String sourceUrl;
  final String pageTitle;
  final String mainTextContent;
  final List<String> childHtmlLinks;
  final List<String> detectedArModelUrls;
  final List<Map<String, dynamic>> extractedJsonLdSchemas;
  final Map<String, String> metaAttributes;
  final DateTime crawledAt;
  final int depth;

  AdvancedKnowledgeNode({
    required this.id,
    required this.sourceUrl,
    required this.pageTitle,
    required this.mainTextContent,
    required this.childHtmlLinks,
    required this.detectedArModelUrls,
    required this.extractedJsonLdSchemas,
    required this.metaAttributes,
    required this.crawledAt,
    required this.depth,
  });

  /// Serialized specifically to fit your Supabase PostgreSQL JSONB / Relational tables.
  Map<String, dynamic> toSupabaseJson() => {
        'id': id,
        'source_url': sourceUrl,
        'page_title': pageTitle,
        'main_content': mainTextContent,
        'child_links': childHtmlLinks,
        'ar_assets': detectedArModelUrls,
        'structured_schemas': extractedJsonLdSchemas,
        'meta_data': metaAttributes,
        'crawled_at': crawledAt.toIso8601String(),
        'depth_level': depth,
      };
}

/// Advanced configuration supporting concurrent worker pools and file type filters.
class AdvancedEngineConfig {
  final String seedUrl;
  final int maxDepth;
  final int maxPageBudget;
  final int maxConcurrentRequests;
  final Duration networkTimeout;
  final bool stayOnSeedDomain;

  AdvancedEngineConfig({
    required this.seedUrl,
    this.maxDepth = 3,
    this.maxPageBudget = 40,
    this.maxConcurrentRequests = 4, // Concurrent request worker pool size
    this.networkTimeout = const Duration(seconds: 10),
    this.stayOnSeedDomain = false, // Set false to crawl external reference resources
  });
}

class MindSparkAdvancedEngine {
  final AdvancedEngineConfig config;
  final Dio _dio = Dio();
  final Set<String> _visitedRegistry = {};
  final List<AdvancedKnowledgeNode> _storagePool = [];
  final _uuid = const Uuid();

  // Match target 3D assets supported by ar_flutter_plugin_plus / model_viewer_plus
  static const _arExtensions = ['.gltf', '.glb', '.obj', '.fbx', '.usdz'];

  MindSparkAdvancedEngine(this.config) {
    _dio.options.connectTimeout = config.networkTimeout;
    _dio.options.receiveTimeout = config.networkTimeout;
    _dio.options.headers = {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) MindSparkAI/2.0',
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9',
    };
  }

  /// Executes concurrent async crawl operations using a parallelized worker pool pattern.
  Future<List<AdvancedKnowledgeNode>> executeEngine() async {
    final List<MapEntry<String, int>> queue = [MapEntry(config.seedUrl, 0)];
    final Uri seedUri = Uri.parse(config.seedUrl);

    while (queue.isNotEmpty && _visitedRegistry.length < config.maxPageBudget) {
      // Pull tasks up to the max concurrent worker size limit
      final currentBatch = <MapEntry<String, int>>[];
      while (queue.isNotEmpty && currentBatch.length < config.maxConcurrentRequests) {
        final item = queue.removeAt(0);
        if (!_visitedRegistry.contains(item.key) && item.value <= config.maxDepth) {
          currentBatch.add(item);
          _visitedRegistry.add(item.key);
        }
      }

      if (currentBatch.isEmpty) break;

      // Execute network tasks concurrently across the active request pool
      final futures = currentBatch.map((task) async {
        try {
          return await _processPage(task.key, task.value, seedUri);
        } catch (e) {
          debugPrint('[Worker Error] Link drop: ${task.key} | $e');
          return null;
        }
      });

      final results = await Future.wait(futures);

      // Consume results and dynamically hydrate future task queues
      for (final node in results) {
        if (node != null) {
          _storagePool.add(node);
          for (final link in node.childHtmlLinks) {
            if (!_visitedRegistry.contains(link)) {
              queue.add(MapEntry(link, node.depth + 1));
            }
          }
        }
      }
    }
    return _storagePool;
  }

  Future<AdvancedKnowledgeNode?> _processPage(String url, int currentDepth, Uri seedUri) async {
    final response = await _dio.get(url, options: Options(responseType: ResponseType.plain));
    if (response.statusCode != 200 || response.data == null) return null;

    final Document doc = parser.parse(response.data);
    final Uri currentUri = Uri.parse(url);

    // 1. Strip UI presentation elements to reduce data noise
    doc.querySelectorAll('script:not([type="application/ld+json"]), style, iframe, footer, nav, header, noscript, svg, .ads').forEach((e) => e.remove());

    // 2. Parse structural text content
    final rawTextBlocks = doc.querySelectorAll('h1, h2, h3, p, li, article, blockquote')
        .map((e) => e.text.trim())
        .where((text) => text.isNotEmpty && text.length > 8);
    final cleanMainText = rawTextBlocks.join('\n\n');

    // 3. Extract Metadata Attributes
    final Map<String, String> metaMap = {};
    doc.querySelectorAll('meta').forEach((element) {
      final name = element.attributes['name'] ?? element.attributes['property'];
      final content = element.attributes['content'];
      if (name != null && content != null) {
        metaMap[name] = content;
      }
    });

    // 4. Extract Structured JSON-LD Data for deeper AI contextual inference
    final List<Map<String, dynamic>> structuredSchemas = [];
    doc.querySelectorAll('script[type="application/ld+json"]').forEach((element) {
      try {
        final decoded = jsonDecode(element.text.trim());
        if (decoded is Map<String, dynamic>) {
          structuredSchemas.add(decoded);
        } else if (decoded is List) {
          structuredSchemas.addAll(decoded.whereType<Map<String, dynamic>>());
        }
      } catch (_) {}
    });

    // 5. Unified links and AR Engine resource detection sweep
    final List<String> childHtmlLinks = [];
    final List<String> detectedArModels = [];
    final allResourceElements = doc.querySelectorAll('a[href], source[src], model-viewer[src], mesh[src]');

    for (final element in allResourceElements) {
      final rawPath = element.attributes['href'] ?? element.attributes['src'];
      if (rawPath == null || rawPath.isEmpty) continue;

      try {
        final absoluteUri = currentUri.resolve(rawPath);
        final cleanUrl = absoluteUri.replace(fragment: '').toString();
        final lowerUrl = cleanUrl.toLowerCase();

        // Separate 3D engine objects from traditional text links
        if (_arExtensions.any((ext) => lowerUrl.endsWith(ext))) {
          detectedArModels.add(cleanUrl);
        } else if (absoluteUri.scheme == 'http' || absoluteUri.scheme == 'https') {
          if (!config.stayOnSeedDomain || absoluteUri.host == seedUri.host) {
            childHtmlLinks.add(cleanUrl);
          }
        }
      } catch (_) {}
    }

    return AdvancedKnowledgeNode(
      id: _uuid.v4(),
      sourceUrl: url,
      pageTitle: doc.querySelector('title')?.text.trim() ?? 'Untitled Resource',
      mainTextContent: cleanMainText,
      childHtmlLinks: childHtmlLinks.toSet().toList(),
      detectedArModelUrls: detectedArModels.toSet().toList(),
      extractedJsonLdSchemas: structuredSchemas,
      metaAttributes: metaMap,
      crawledAt: DateTime.now(),
      depth: currentDepth,
    );
  }
}

/// Web-safe Orchestrator: Safely uses isolates on Native mobile systems, 
/// but drops down to an async event micro-task loop seamlessly on Flutter Web.
class WebSafeCrawlerExecutor {
  static Future<List<AdvancedKnowledgeNode>> spawnCrawler(AdvancedEngineConfig config) async {
    if (kIsWeb) {
      final engine = MindSparkAdvancedEngine(config);
      return await engine.executeEngine();
    } else {
      return await compute(_isolateEntrypoint, config);
    }
  }

  static Future<List<AdvancedKnowledgeNode>> _isolateEntrypoint(AdvancedEngineConfig config) async {
    final engine = MindSparkAdvancedEngine(config);
    return await engine.executeEngine();
  }
}
