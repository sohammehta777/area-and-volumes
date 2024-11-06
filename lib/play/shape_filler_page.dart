// lib/play/shape_filler_page.dart

import 'package:flutter/material.dart';

class ShapeFillerPage extends StatefulWidget {
  const ShapeFillerPage({super.key});

  @override
  _ShapeFillerPageState createState() => _ShapeFillerPageState();
}

class _ShapeFillerPageState extends State<ShapeFillerPage> {
  final int gridSize = 4; // Changed to 4x4 grid
  final double cellSize = 40.0; // Adjusted size of each cell in the grid
  List<List<bool>> grid = [];
  List<Widget> draggableShapes = [];
  double filledArea = 0.0;
  List<List<bool>> hoverGrid = []; // To track hover state

  @override
    void initState() {
    super.initState();
    _initializeGrid();
    _initializeShapes();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showGameRulesDialog());
  }

  void _showGameRulesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Festival Wall Painters Needed!'),
        content: const Text(
          '1. You\'re helping to paint a big wall for an art festival! \n\n' 
          '2. Use your paint rollers to cover as much of the wall as you can.\n\n' 
          '3. You can leave two blocks of space putting up decorations, but not less than that.\n\n' 
          '4. If the wall is almost full, you win!\n',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Start Game'),
          ),
        ],
      ),
    );
  }

  // Initialize a 4x4 grid with all cells set to false (empty)
  void _initializeGrid() {
    grid = List.generate(gridSize, (_) => List.generate(gridSize, (_) => false));
    hoverGrid = List.generate(gridSize, (_) => List.generate(gridSize, (_) => false)); // Initialize hoverGrid
  }

  // Initialize draggable solid shapes
  void _initializeShapes() {
    draggableShapes = [
      _buildSolidShape(2, 2, Colors.red), // 2x2 square
      _buildSolidShape(3, 2, Colors.green), // 3x2 rectangle
      _buildSolidShape(1, 3, Colors.blue), // 1x3 rectangle
    ];
  }

  // Build a solid shape with dimensions and color
  Widget _buildSolidShape(int width, int height, Color color) {
    return Draggable<Map<String, int>>(
      data: {'width': width, 'height': height},
      feedback: _buildSolidRepresentation(width, height, color, 30.0), // Adjusted size for drag feedback
      child: _buildSolidRepresentation(width, height, color, 30.0), // Smaller size for display
    );
  }

  // Helper function to display a solid shape with internal lines
  Widget _buildSolidRepresentation(int width, int height, Color color, double size) {
    return Container(
      width: width * size,
      height: height * size,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 1), // Outer border
      ),
      child: CustomPaint(
        painter: GridLinesPainter(width, height, size),
      ),
    );
  }

  // Check if a shape fits in the grid without overlapping
  bool _canPlaceShape(int startX, int startY, int width, int height) {
    if (startX + width > gridSize || startY + height > gridSize) return false;
    for (int i = startX; i < startX + width; i++) {
      for (int j = startY; j < startY + height; j++) {
        if (grid[i][j]) return false; // Already filled
      }
    }
    return true;
  }

  // Place the shape in the grid and mark the cells as filled
  void _placeShape(int startX, int startY, int width, int height) {
    setState(() {
      for (int i = startX; i < startX + width; i++) {
        for (int j = startY; j < startY + height; j++) {
          grid[i][j] = true;
        }
      }
      filledArea += (width * height); // Update filled area
      if (filledArea >= (gridSize * gridSize) * 0.9) {
        _showWinDialog(); // Show win dialog when 90% is filled
      } else if (!_canFillToNinetyPercent()) {
        _showGameOverDialog(); // Show game over if can't fill 90%
      }
    });
  }

  // Check if there are enough empty cells and shapes to fill 90% of the grid
  bool _canFillToNinetyPercent() {
    int emptyCells = 0;

    // Count empty cells in the grid
    for (var row in grid) {
      emptyCells += row.where((cell) => !cell).length;
    }

    // If fewer than 10% empty, no need to check
    if (emptyCells <= (gridSize * gridSize * 0.1)) return true;

    // Check if any remaining shape fits in the grid
    for (var shape in draggableShapes) {
      // Extract shape size from data
      final shapeData = (shape as Draggable<Map<String, int>>).data;
      for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridSize; j++) {
          if (_canPlaceShape(i, j, shapeData!['width']!, shapeData['height']!)) {
            return true; // There's at least one valid placement
          }
        }
      }
    }

    return false; // No shapes can fit, so game over
  }

  // Display a game over dialog when 90% cannot be filled
  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Almost There!'),
        content: const Text('Great effort! You\'ve filled a lot of the wall, but there\'s just a little too much empty space left. Want to try painting it again?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame(); // Reset the game after the dialog
            },
            child: const Text('Let\'s paint again!'),
          ),
        ],
      ),
    );
  }

  // Reset the game by clearing the grid and resetting the filled area
  void _resetGame() {
    setState(() {
      _initializeGrid();
      filledArea = 0.0;
    });
  }

  // Build the grid with DragTargets
  Widget _buildGrid() {
    return Container(
      width: 250.0, // Set the desired width for the grid container
      height: 250.0, // Set the desired height for the grid container
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridSize, // 4x4 grid
          childAspectRatio: 1.0, // Square cells
        ),
        itemCount: gridSize * gridSize,
        itemBuilder: (context, index) {
          int x = index % gridSize; // Column index
          int y = index ~/ gridSize; // Row index

          return DragTarget<Map<String, int>>(
            onWillAccept: (data) {
              bool canPlace = _canPlaceShape(x, y, data!['width']!, data['height']!);
              setState(() {
                for (int i = x; i < x + data['width']!; i++) {
                  for (int j = y; j < y + data['height']!; j++) {
                    if (i < gridSize && j < gridSize) {
                      hoverGrid[i][j] = canPlace;
                    }
                  }
                }
              });
              return canPlace;
            },
            onAccept: (data) {
              if (_canPlaceShape(x, y, data['width']!, data['height']!)) {
                _placeShape(x, y, data['width']!, data['height']!);
              }
            },
            onLeave: (data) {
              setState(() {
                for (int i = x; i < x + data!['width']!; i++) {
                  for (int j = y; j < y + data['height']!; j++) {
                    if (i < gridSize && j < gridSize) {
                      hoverGrid[i][j] = false;
                    }
                  }
                }
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                margin: const EdgeInsets.all(1.0),
                width: cellSize,
                height: cellSize,
                color: grid[x][y] ? Colors.black : (hoverGrid[x][y] ? Colors.lightGreen : Colors.grey[300]),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paint the Wall!'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildGrid(),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: draggableShapes,
          ),
        ],
      ),
    );
  }

  // Display a win dialog when 90% is filled
  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: const Text('That is a piece of art!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame(); // Reset the game after the dialog
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }
}

// Custom painter for drawing grid lines inside shapes
class GridLinesPainter extends CustomPainter {
  final int width;
  final int height;
  final double cellSize;

  GridLinesPainter(this.width, this.height, this.cellSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    for (int i = 1; i < width; i++) {
      canvas.drawLine(Offset(i * cellSize, 0), Offset(i * cellSize, size.height), paint);
    }

    for (int i = 1; i < height; i++) {
      canvas.drawLine(Offset(0, i * cellSize), Offset(size.width, i * cellSize), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
