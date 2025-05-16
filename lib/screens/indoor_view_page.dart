import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';
import '../../widgets/header/header_widget.dart';
import '../../screens/home/components/navigation_icons.dart';

class IndoorViewPage extends StatefulWidget {
  const IndoorViewPage({Key? key}) : super(key: key);

  @override
  State<IndoorViewPage> createState() => _IndoorViewPageState();
}

class _IndoorViewPageState extends State<IndoorViewPage> {
  final TextEditingController _controller = TextEditingController();
  final String _svgAsset = 'assets/002-000.svg';
  String _highlightedSvg = '';
  String _currentRoomInfo = '';
  TransformationController _transformationController = TransformationController();
  double _currentScale = 1.0;
  Offset _currentPosition = Offset.zero;
  Size _viewSize = Size.zero;

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
    _loadInitialSvg();
  }

  Future<void> _loadInitialSvg() async {
    final rawSvg = await rootBundle.loadString(_svgAsset);
    setState(() {
      _highlightedSvg = rawSvg;
    });
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
            styles[i] = 'fill:#0000FF';
            hasFill = true;
            break;
          }
        }
        if (!hasFill) styles.add('fill:#0000FF');
        target.setAttribute('style', styles.join(';'));
      } else {
        target.setAttribute('fill', '#0000FF');
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderWidget(),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                      _highlightRoom(prefix);
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
                            child: SvgPicture.string(
                              _highlightedSvg,
                              fit: BoxFit.contain,
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
}
