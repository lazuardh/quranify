import 'package:flutter/material.dart';
import 'package:quranify/lib.dart';

class PlayQuranCard extends StatelessWidget {
  const PlayQuranCard({
    super.key,
    required this.name,
    required this.qori,
    required this.progress,
    required this.currentDuration,
    required this.totalDuration,
  });

  final String name;
  final String qori;
  final double progress;
  final String currentDuration;
  final String totalDuration;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.viewPaddingOf(context).bottom + 10,
      ),
      height: MediaQuery.sizeOf(context).height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorScheme.surface.withValues(alpha: .8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 25,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorScheme.primary.withValues(alpha: .15),
                ),
                child: const Icon(Icons.library_music, size: 20),
              ),

              const Gap(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyle.bold.copyWith(fontSize: 16)),
                    const Gap(height: 4),
                    Text(
                      qori.toUpperCase(),
                      style: AppTextStyle.regular.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.open_in_full, size: 18),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.repeat, size: 18),
              ),
            ],
          ),

          const Gap(height: 16),

          /// PROGRESS
          LinearProgressIndicator(value: progress),

          const Gap(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentDuration,
                style: AppTextStyle.regular.copyWith(fontSize: 12),
              ),
              Text(
                totalDuration,
                style: AppTextStyle.regular.copyWith(fontSize: 12),
              ),
            ],
          ),

          const Gap(height: 10),

          /// PLAYER CONTROL
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 24,
                onPressed: () {},
                icon: const Icon(Icons.fast_rewind),
              ),

              const Gap(width: 8),

              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.secondary,
                ),
                child: IconButton(
                  iconSize: 22,
                  color: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow_rounded),
                ),
              ),

              const Gap(width: 8),

              IconButton(
                iconSize: 24,
                onPressed: () {},
                icon: const Icon(Icons.fast_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
