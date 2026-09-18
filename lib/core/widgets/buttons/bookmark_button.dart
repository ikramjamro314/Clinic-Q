import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/clinic_q_colors.dart';
import '../../../features/profile/data/local/interest_local_data_source.dart';

class BookmarkButton extends ConsumerStatefulWidget {
  final String entityId;
  final String entityType;
  final double size;

  const BookmarkButton({
    super.key,
    required this.entityId,
    required this.entityType,
    this.size = 22,
  });

  @override
  ConsumerState<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends ConsumerState<BookmarkButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool? _optimisticIsFav;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(bool currentIsFav) async {
    final originalState = currentIsFav;
    final newState = !originalState;
    setState(() {
      _optimisticIsFav = newState;
    });
    _controller.forward(from: 0.0);

    try {
      final source = ref.read(interestLocalDataSourceProvider);
      if (originalState) {
        await source.remove(widget.entityId, widget.entityType);
      } else {
        await source.add(widget.entityId, widget.entityType);
      }
      ref.invalidate(
        isInterestedProvider((
          entityId: widget.entityId,
          entityType: widget.entityType,
        )),
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _optimisticIsFav = originalState;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final queryArg = (entityId: widget.entityId, entityType: widget.entityType);
    final isFavAsync = ref.watch(isInterestedProvider(queryArg));

    final providerIsFav = isFavAsync.value ?? false;

    if (_optimisticIsFav != null && providerIsFav == _optimisticIsFav) {
      _optimisticIsFav = null;
    }

    final isFav = _optimisticIsFav ?? providerIsFav;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            isFav ? Icons.bookmark : Icons.bookmark_border,
            key: ValueKey<bool>(isFav),
            color: isFav
                ? ClinicQColors.primaryTeal
                : ClinicQColors.textPrimary,
            size: widget.size,
          ),
        ),
        onPressed: () => _handleTap(isFav),
      ),
    );
  }
}
