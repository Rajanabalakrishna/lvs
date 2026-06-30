import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';

/// Stream card that maps a [PostEntity] to the Alive Stream Discovery card UI.
/// The thumbnail is faked with a deterministic Picsum image based on post id.
class StreamCardWidget extends StatelessWidget {
  final PostEntity post;

  const StreamCardWidget({super.key, required this.post});

  // Cycle through a set of country flags for visual variety
  static const _flags = ['🇵🇭', '🇮🇳', '🇧🇷', '🇺🇸', '🇯🇵', '🇰🇷', '🇬🇧', '🇩🇪'];

  @override
  Widget build(BuildContext context) {
    final flag = _flags[post.id % _flags.length];
    // Fake viewer count: cycle through some plausible values
    final viewers = ['8.2K', '5.1K', '12.4K', '3.7K', '9.9K'];
    final viewerCount = viewers[post.id % viewers.length];
    final imageUrl =
        'https://picsum.photos/seed/${post.id + 10}/300/400';

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: AspectRatio(
        aspectRatio: 3.4 / 4.5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Thumbnail
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: const Color(0xFFE5E7EB),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFA3E635),
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFE5E7EB),
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
            // Viewer count badge (top-left)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.visibility,
                        color: Colors.white, size: 12),
                    const SizedBox(width: 3),
                    Text(
                      viewerCount,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Streamer info + follow button (bottom)
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // Truncate the title to use as a display name
                          post.title.split(' ').take(2).join(' '),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(flag, style: const TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA3E635),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        '+ Follow',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
