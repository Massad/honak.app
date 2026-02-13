import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';

/// Slide-to-confirm widget (like Uber/Careem).
/// Prevents accidental taps. User must drag thumb >=75% to confirm.
class SwipeButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color thumbColor;
  final VoidCallback onConfirm;

  const SwipeButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.thumbColor = AppColors.white,
    required this.onConfirm,
  });

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton>
    with SingleTickerProviderStateMixin {
  static const _thumbSize = 52.0;
  static const _trackHeight = 56.0;
  static const _padding = 4.0;
  static const _threshold = 0.75;

  double _dragX = 0;
  bool _isDragging = false;
  bool _confirmed = false;
  late AnimationController _resetController;
  late Animation<double> _resetAnimation;

  double get _maxDrag {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return 200;
    return box.size.width - _thumbSize - _padding * 2;
  }

  double get _progress => _maxDrag > 0 ? (_dragX / _maxDrag).clamp(0, 1) : 0;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _resetAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOut),
    );
    _resetController.addListener(() {
      setState(() => _dragX = _resetAnimation.value);
    });
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    if (_confirmed) return;
    setState(() => _isDragging = true);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging || _confirmed) return;
    setState(() {
      _dragX = (_dragX + details.delta.dx).clamp(0, _maxDrag);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_isDragging || _confirmed) return;
    _isDragging = false;

    if (_progress >= _threshold) {
      setState(() {
        _confirmed = true;
        _dragX = _maxDrag;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        widget.onConfirm();
        // Reset after callback
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              _confirmed = false;
              _dragX = 0;
            });
          }
        });
      });
    } else {
      _resetAnimation =
          Tween<double>(begin: _dragX, end: 0).animate(CurvedAnimation(
        parent: _resetController,
        curve: Curves.easeOut,
      ));
      _resetController
        ..reset()
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _trackHeight,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Label text — fades as thumb is dragged
          Positioned.fill(
            child: Center(
              child: Opacity(
                opacity: (1 - _progress * 2).clamp(0, 1),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.label,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '\u2190', // ←
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Confirmed check overlay
          if (_confirmed)
            const Positioned.fill(
              child: Center(
                child: Icon(Icons.check, color: Colors.white, size: 24),
              ),
            ),
          // Draggable thumb
          Positioned(
            top: _padding,
            left: _padding + _dragX,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                width: _thumbSize,
                height: _trackHeight - _padding * 2,
                decoration: BoxDecoration(
                  color: widget.thumbColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  _confirmed ? Icons.check : widget.icon,
                  color: _confirmed ? AppColors.success : widget.color,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
