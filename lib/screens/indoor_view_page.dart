import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';
import '../../widgets/header/header_widget.dart';
import '../../screens/home/components/navigation_icons.dart';
import 'package:flutter/foundation.dart';

// Marker class moved to top level
class Marker {
  final String name;
  final String building;
  final String floor;
  final String type;
  final double x;
  final double y;
  Marker({
    required this.name,
    required this.building,
    required this.floor,
    required this.type,
    required this.x,
    required this.y,
  });
}

class IndoorViewPage extends StatefulWidget {
  const IndoorViewPage({Key? key}) : super(key: key);

  @override
  State<IndoorViewPage> createState() => _IndoorViewPageState();
}

class _IndoorViewPageState extends State<IndoorViewPage> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final String _svgAsset = 'assets/002-000.svg';
  String _highlightedSvg = '';
  String _currentRoomInfo = '';
  TransformationController _transformationController = TransformationController();
  double _currentScale = 1.0;
  Offset _currentPosition = Offset.zero;
  Size _viewSize = Size.zero;

  // Dropdown state and data
  String? _selectedBuilding = 'preparatory';
  String? _selectedFloor = 'ground';

  bool _markersVisible = true;
  String? _highlightedMarkerId;
  AnimationController? _markerAnimationController;
  Animation<double>? _markerAnimation;

  final List<String> _buildings = [
    'main',
    'preparatory',
    'electrical',
    'mechanical',
  ];

  final Map<String, List<String>> _buildingFloors = {
    'main': ['ground', 'first', 'second', 'third', 'forth', 'fifth'],
    'preparatory': ['basement', 'ground', 'first', 'second', 'third'],
    'electrical': ['ground', 'first', 'second', 'third', 'forth', 'fifth', 'sixth', 'seventh', 'eigth'],
    'mechanical': ['ground', 'first', 'second', 'third', 'forth', 'fifth'],
  };

  // Map building to code
  final Map<String, String> _buildingCodes = {
    'main': '001',
    'preparatory': '002',
    'electrical': '003',
    'mechanical': '004',
  };

  // Map floor name to code for each building
  final Map<String, Map<String, String>> _floorCodes = {
    'main': {
      'ground': '000',
      'first': '001',
      'second': '002',
      'third': '003',
      'forth': '004',
      'fifth': '005',
    },
    'preparatory': {
      'basement': '00A',
      'ground': '000',
      'first': '001',
      'second': '002',
      'third': '003',
    },
    'electrical': {
      'ground': '000',
      'first': '001',
      'second': '002',
      'third': '003',
      'forth': '004',
      'fifth': '005',
      'sixth': '006',
      'seventh': '007',
      'eigth': '008',
    },
    'mechanical': {
      'ground': '000',
      'first': '001',
      'second': '002',
      'third': '003',
      'forth': '004',
      'fifth': '005',
    },
  };

  List<Marker> _markers = [];
  Marker? _selectedMarker;

  String? _getSvgAssetForSelection(String building, String floor) {
    final code = _buildingCodes[building];
    final floorCode = _floorCodes[building]?[floor];
    if (code != null && floorCode != null) {
      return 'assets/maps/${building}_building/$code-$floorCode.svg';
    }
    return null;
  }

  Future<void> _loadSvgForSelection(String building, String floor) async {
    final assetPath = _getSvgAssetForSelection(building, floor);
    final markerPath = assetPath?.replaceAll('.svg', '.txt');
    if (assetPath != null) {
      try {
        final rawSvg = await rootBundle.loadString(assetPath);
        setState(() {
          _highlightedSvg = rawSvg;
        });
        // Try to load markers
        if (markerPath != null) {
          try {
            final markerString = await rootBundle.loadString(markerPath);
            final blocks = markerString.split(RegExp(r'\n\s*\n'));
            final markers = <Marker>[];
            for (final block in blocks) {
              if (block.trim().isEmpty) continue;
              final lines = block.split('\n');
              String? name, buildingId, floorId, type;
              double? x, y;
              for (final line in lines) {
                final parts = line.split(':');
                if (parts.length < 2) continue;
                final key = parts[0].trim().toLowerCase();
                final value = parts.sublist(1).join(':').trim();
                switch (key) {
                  case 'name':
                    name = value;
                    break;
                  case 'building':
                    buildingId = value;
                    break;
                  case 'floor':
                    floorId = value;
                    break;
                  case 'type':
                    type = value;
                    break;
                  case 'x':
                    x = double.tryParse(value);
                    break;
                  case 'y':
                    y = double.tryParse(value);
                    break;
                }
              }
              if (name != null && buildingId != null && floorId != null && type != null && x != null && y != null) {
                markers.add(Marker(
                  name: name,
                  building: buildingId,
                  floor: floorId,
                  type: type,
                  x: x,
                  y: y,
                ));
              }
            }
            setState(() {
              _markers = markers;
            });
          } catch (e) {
            setState(() {
              _markers = [];
            });
          }
        } else {
          setState(() {
            _markers = [];
          });
        }
        // Reset zoom and pan to default (centered, scale 1.0)
        _currentScale = 1.0;
        _transformationController.value = Matrix4.identity();
      } catch (e) {
        setState(() {
          _highlightedSvg = '';
          _markers = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('SVG not found for $building $floor')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _transformationController.addListener(() {
      setState(() {
        _currentPosition = Offset(
          _transformationController.value.getTranslation().x,
          _transformationController.value.getTranslation().y,
        );
      });
    });
    // Load default image: preparatory building, ground floor
    _loadSvgForSelection('preparatory', 'ground');
    _markerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _markerAnimation = Tween<double>(begin: 0, end: -2).chain(CurveTween(curve: Curves.easeInOut)).animate(_markerAnimationController!);
  }

  Future<void> _highlightRoom(String prefix) async {
    try {
      final rawSvg = await rootBundle.loadString(_svgAsset);
      final document = XmlDocument.parse(rawSvg);

      final target = document.findAllElements('rect').firstWhere(
            (element) => element.getAttribute('id')?.startsWith(prefix) ?? false,
        orElse: () => XmlElement(XmlName('')),
      );

      if (target.name.local == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Room with ID starting "$prefix" not found')),
        );
        return;
      }

      final id = target.getAttribute('id') ?? '';
      final parts = id.split('-');
      if (parts.length >= 3) {
        setState(() {
          _currentRoomInfo = 'Room ${parts[0]} Floor ${parts[2]} Building ${parts[1]}';
        });
      }

      final style = target.getAttribute('style');
      if (style != null) {
        final styles = style.split(';').where((s) => s.trim().isNotEmpty).toList();
        bool hasFill = false;
        for (int i = 0; i < styles.length; i++) {
          if (styles[i].trim().startsWith('fill:')) {
            styles[i] = 'fill:#FF8888';
            hasFill = true;
            break;
          }
        }
        if (!hasFill) styles.add('fill:#FF8888');
        target.setAttribute('style', styles.join(';'));
      } else {
        target.setAttribute('fill', '#FF8888');
      }

      setState(() {
        _highlightedSvg = document.toXmlString(pretty: true);
        _currentScale = 1.0;
        _currentPosition = Offset.zero;
        _applyScale(1.0);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error highlighting room: $e')),
      );
    }
  }

  Future<void> _searchAndHighlightMarker(String query) async {
    final indexString = await rootBundle.loadString('assets/markers_index.txt');
    final lines = indexString.split('\n').where((l) => l.trim().isNotEmpty).toList();
    String? foundLine;
    for (final line in lines) {
      final parts = line.split('-');
      if (parts.length >= 3) {
        final markerName = parts.sublist(2).join('-').toLowerCase().trim();
        if (markerName == query.toLowerCase().trim()) {
          foundLine = line;
          break;
        }
      }
    }
    if (foundLine == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No marker found for "$query"')),
      );
      return;
    }
    // Parse building, floor, and marker name
    final parts = foundLine.split('-');
    final building = parts[0].trim();
    final floor = parts[1].trim();
    final markerName = parts.sublist(2).join('-').trim();
    // Load the SVG
    final svgPath = 'assets/maps/preparatory_building/$building-$floor.svg';
    // Load markers for the new map
    await _loadSvgForSelection('preparatory', 'ground');
    String rawSvg;
    try {
      rawSvg = await rootBundle.loadString(svgPath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SVG not found for $building-$floor')),
      );
      return;
    }
    // Highlight the rect with id = building-floor-markerName
    final document = XmlDocument.parse(rawSvg);
    final targetId = '$building-$floor-$markerName';
    final target = document.findAllElements('rect').firstWhere(
      (element) => (element.getAttribute('id') ?? '').trim().toLowerCase() == targetId.toLowerCase(),
      orElse: () => XmlElement(XmlName('')),
    );
    if (target.name.local == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Room with ID "$targetId" not found in SVG')),
      );
    } else {
      // Change fill color to highlight
      final style = target.getAttribute('style');
      if (style != null) {
        final styles = style.split(';').where((s) => s.trim().isNotEmpty).toList();
        bool hasFill = false;
        for (int i = 0; i < styles.length; i++) {
          if (styles[i].trim().startsWith('fill:')) {
            styles[i] = 'fill:#FF8888';
            hasFill = true;
            break;
          }
        }
        if (!hasFill) styles.add('fill:#FF8888');
        target.setAttribute('style', styles.join(';'));
      } else {
        target.setAttribute('fill', '#FF8888');
      }
      setState(() {
        _highlightedSvg = document.toXmlString(pretty: true);
        _selectedBuilding = 'preparatory';
        _selectedFloor = 'ground';
        _highlightedMarkerId = targetId;
      });
      // Animate the marker
      _markerAnimationController?.reset();
      _markerAnimationController?.repeat(reverse: true);
    }
  }

  void _zoomIn() {
    setState(() {
      final double oldScale = _currentScale;
      _currentScale *= 1.2;
      _applyScale(oldScale);
    });
  }

  void _zoomOut() {
    setState(() {
      final double oldScale = _currentScale;
      _currentScale /= 1.2;
      _applyScale(oldScale);
    });
  }

  void _applyScale(double oldScale) {
    if (_viewSize == Size.zero) return;

    final Offset center = Offset(_viewSize.width / 2, _viewSize.height / 2);
    final Offset focalPoint = Offset(
      (center.dx - _currentPosition.dx) / oldScale,
      (center.dy - _currentPosition.dy) / oldScale,
    );

    final Offset newPosition = Offset(
      center.dx - focalPoint.dx * _currentScale,
      center.dy - focalPoint.dy * _currentScale,
    );

    final Matrix4 matrix = Matrix4.identity()
      ..translate(newPosition.dx, newPosition.dy)
      ..scale(_currentScale);

    _transformationController.value = matrix;
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _controller.dispose();
    _markerAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderWidget(),

          // Search Bar + Dropdowns (now on separate lines)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    // Building Dropdown with label
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Building', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            value: _selectedBuilding,
                            hint: const Text('Building'),
                            items: _buildings
                                .map<DropdownMenuItem<String>>((b) => DropdownMenuItem<String>(value: b, child: Text(b[0].toUpperCase() + b.substring(1))))
                                .toList(),
                            onChanged: (value) async {
                              if (value != null) {
                                setState(() {
                                  _selectedBuilding = value;
                                  // Default to ground floor
                                  _selectedFloor = _buildingFloors[value]!.contains('ground') ? 'ground' : _buildingFloors[value]!.first;
                                });
                                await _loadSvgForSelection(value, _selectedFloor!);
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Floor Dropdown with label
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Floor', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            value: _selectedFloor,
                            hint: const Text('Floor'),
                            items: (_selectedBuilding != null
                                    ? _buildingFloors[_selectedBuilding] ?? []
                                    : [])
                                .map<DropdownMenuItem<String>>((f) => DropdownMenuItem<String>(value: f, child: Text(f[0].toUpperCase() + f.substring(1))))
                                .toList(),
                            onChanged: (_selectedBuilding == null)
                                ? null
                                : (value) async {
                                    if (value != null) {
                                      setState(() {
                                        _selectedFloor = value;
                                      });
                                      await _loadSvgForSelection(_selectedBuilding!, value);
                                    }
                                  },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Markers visibility toggle button
                    Column(
                      children: [
                        const Text('Markers', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: _markersVisible ? Colors.teal : Colors.grey[400],
                          child: IconButton(
                            icon: Icon(_markersVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _markersVisible = !_markersVisible;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter room ID prefix (e.g. 001)',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              final prefix = _controller.text.trim();
                              if (prefix.isNotEmpty) {
                                _searchAndHighlightMarker(prefix);
                              }
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Room Information Display
          if (_currentRoomInfo.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                _currentRoomInfo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),

          // SVG Viewer + Zoom Controls
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        _viewSize = Size(constraints.maxWidth, constraints.maxHeight);
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: _highlightedSvg.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : InteractiveViewer(
                                  transformationController: _transformationController,
                                  minScale: 0.5,
                                  maxScale: 10.0,
                                  child: Stack(
                                    children: [
                                      SvgPicture.string(
                                        _highlightedSvg,
                                        fit: BoxFit.contain,
                                        width: _viewSize.width,
                                        height: _viewSize.height,
                                      ),
                                      ...(_markersVisible ? _markers.map((marker) {
                                        double svgWidth = 1024.0;
                                        double svgHeight = 768.0;
                                        double boxWidth = _viewSize.width;
                                        double boxHeight = _viewSize.height;
                                        double markerSize = 6.0;
                                        double scale, offsetX = 0, offsetY = 0;
                                        double aspectRatioSvg = svgWidth / svgHeight;
                                        double aspectRatioBox = boxWidth / boxHeight;
                                        if (aspectRatioBox > aspectRatioSvg) {
                                          // Box is wider than SVG: pad left/right
                                          scale = boxHeight / svgHeight;
                                          double usedWidth = svgWidth * scale;
                                          offsetX = (boxWidth - usedWidth) / 2;
                                          offsetY = 0;
                                        } else {
                                          // Box is taller than SVG: pad top/bottom
                                          scale = boxWidth / svgWidth;
                                          double usedHeight = svgHeight * scale;
                                          offsetX = 0;
                                          offsetY = (boxHeight - usedHeight) / 2;
                                        }
                                        double markerLeft = marker.x * scale + offsetX - markerSize / 2;
                                        double markerTop = marker.y * scale + offsetY - markerSize / 2;
                                        final markerId = '002-000-${marker.name.trim()}';
                                        Widget markerWidget = GestureDetector(
                                          onTap: () async {
                                            // Highlight the room in the SVG
                                            _controller.text = marker.name.trim();
                                            final svgPath = 'assets/maps/preparatory_building/002-000.svg';
                                            String rawSvg;
                                            try {
                                              rawSvg = await rootBundle.loadString(svgPath);
                                            } catch (e) {
                                              rawSvg = _highlightedSvg;
                                            }
                                            final document = XmlDocument.parse(rawSvg);
                                            final target = document.findAllElements('rect').firstWhere(
                                              (element) => (element.getAttribute('id') ?? '').trim().toLowerCase() == markerId.toLowerCase(),
                                              orElse: () => XmlElement(XmlName('')),
                                            );
                                            if (target.name.local != '') {
                                              final style = target.getAttribute('style');
                                              if (style != null) {
                                                final styles = style.split(';').where((s) => s.trim().isNotEmpty).toList();
                                                bool hasFill = false;
                                                for (int i = 0; i < styles.length; i++) {
                                                  if (styles[i].trim().startsWith('fill:')) {
                                                    styles[i] = 'fill:#FF8888';
                                                    hasFill = true;
                                                    break;
                                                  }
                                                }
                                                if (!hasFill) styles.add('fill:#FF8888');
                                                target.setAttribute('style', styles.join(';'));
                                              } else {
                                                target.setAttribute('fill', '#FF8888');
                                              }
                                              setState(() {
                                                _highlightedSvg = document.toXmlString(pretty: true);
                                                _highlightedMarkerId = markerId;
                                              });
                                              _markerAnimationController?.reset();
                                              _markerAnimationController?.repeat(reverse: true);
                                            }
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                // Convert building and floor IDs to names
                                                String buildingName = _buildingCodes.entries.firstWhere(
                                                  (e) => e.value == marker.building,
                                                  orElse: () => MapEntry(marker.building, marker.building),
                                                ).key;
                                                String floorName = marker.floor;
                                                // Try to get floor name from _floorCodes
                                                final buildingFloors = _floorCodes[buildingName];
                                                if (buildingFloors != null) {
                                                  final found = buildingFloors.entries.firstWhere(
                                                    (e) => e.value == marker.floor,
                                                    orElse: () => MapEntry(marker.floor, marker.floor),
                                                  );
                                                  floorName = found.key;
                                                }
                                                return AlertDialog(
                                                  title: Text(marker.name),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Type: [200~[0m[200~${marker.type}'),
                                                      Text('Building: $buildingName'),
                                                      Text('Floor: $floorName'),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () => Navigator.of(context).pop(),
                                                      child: const Text('Close'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Tooltip(
                                            message: marker.name,
                                            child: _getMarkerIcon(marker.type),
                                          ),
                                        );
                                        if (_highlightedMarkerId != null && markerId.toLowerCase() == _highlightedMarkerId!.toLowerCase()) {
                                          markerWidget = AnimatedBuilder(
                                            animation: _markerAnimationController!,
                                            builder: (context, child) {
                                              return Transform.translate(
                                                offset: Offset(0, _markerAnimation?.value ?? 0),
                                                child: child,
                                              );
                                            },
                                            child: markerWidget,
                                          );
                                        }
                                        return Positioned(
                                          left: markerLeft,
                                          top: markerTop,
                                          child: markerWidget,
                                        );
                                      }).toList() : []),
                                    ],
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                  // Zoom Controls
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final Matrix4 matrix = _transformationController.value;
                            final Offset center = Offset(_viewSize.width / 2, _viewSize.height / 2);
                            final Offset focalPoint = Offset(
                              (center.dx - matrix.getTranslation().x) / _currentScale,
                              (center.dy - matrix.getTranslation().y) / _currentScale,
                            );
                            setState(() {
                              _currentScale *= 1.2;
                              final Offset newPosition = Offset(
                                center.dx - focalPoint.dx * _currentScale,
                                center.dy - focalPoint.dy * _currentScale,
                              );
                              _transformationController.value = Matrix4.identity()
                                ..translate(newPosition.dx, newPosition.dy)
                                ..scale(_currentScale);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(14),
                            backgroundColor: Colors.teal,
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _currentScale = 1.0;
                              _transformationController.value = Matrix4.identity();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(14),
                            backgroundColor: Colors.teal,
                          ),
                          child: const Icon(Icons.center_focus_strong, color: Colors.white),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            final Matrix4 matrix = _transformationController.value;
                            final Offset center = Offset(_viewSize.width / 2, _viewSize.height / 2);
                            final Offset focalPoint = Offset(
                              (center.dx - matrix.getTranslation().x) / _currentScale,
                              (center.dy - matrix.getTranslation().y) / _currentScale,
                            );
                            setState(() {
                              _currentScale /= 1.2;
                              final Offset newPosition = Offset(
                                center.dx - focalPoint.dx * _currentScale,
                                center.dy - focalPoint.dy * _currentScale,
                              );
                              _transformationController.value = Matrix4.identity()
                                ..translate(newPosition.dx, newPosition.dy)
                                ..scale(_currentScale);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(14),
                            backgroundColor: Colors.teal,
                          ),
                          child: const Icon(Icons.remove, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Navigation
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFFA5D7C2),
            ),
            child: const NavigationIcons(),
          ),
        ],
      ),
    );
  }

  // Helper to get icon and color by marker type
  Widget _getMarkerIcon(String type) {
    // Pin color and icon by type
    Color pinColor;
    IconData innerIcon;
    Color innerColor = Colors.white;
    switch (type.toLowerCase()) {
      case 'class':
        pinColor = Colors.red;
        innerIcon = Icons.class_;
        break;
      case 'office':
        pinColor = Colors.green;
        innerIcon = Icons.work;
        break;
      case 'women bathroom':
        pinColor = Colors.yellow[700]!;
        innerIcon = Icons.woman;
        innerColor = Colors.black;
        break;
      case 'men bathroom':
        pinColor = Colors.yellow[700]!;
        innerIcon = Icons.man;
        innerColor = Colors.black;
        break;
      case 'laboratory':
        pinColor = Colors.blue;
        innerIcon = Icons.science;
        break;
      default:
        pinColor = Colors.grey;
        innerIcon = Icons.location_on;
        break;
    }
    return SizedBox(
      width: 6,
      height: 6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: pinColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
          Icon(innerIcon, color: innerColor, size: 4),
        ],
      ),
    );
  }
}
