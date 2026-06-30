import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/post_provider.dart';
import '../widgets/stream_card_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedTab = 0;
  int _selectedFilter = 0;
  int _selectedNavItem = 0;

  static const _tabs = ['Stream', 'Hot', 'Follow'];
  static const _filters = [
    {'label': 'Global', 'flag': null, 'icon': 'globe'},
    {'label': 'India', 'flag': '🇮🇳', 'icon': null},
    {'label': 'Philippines', 'flag': '🇵🇭', 'icon': null},
    {'label': 'Brazil', 'flag': '🇧🇷', 'icon': null},
  ];

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: postsAsync.when(
                loading: () => _buildLoadingGrid(),
                error: (err, _) => _buildError(err),
                data: (posts) => _buildGrid(posts),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopRow(),
          const SizedBox(height: 20),
          _buildTabs(),
          const SizedBox(height: 16),
          _buildFilterChips(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFA3E635),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'A',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          children: [
            // Notification
            Stack(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF64748B),
                    size: 22,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            // Shopping bag
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFA3E635),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 22,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Row(
      children: List.generate(_tabs.length, (i) {
        final isActive = _selectedTab == i;
        return GestureDetector(
          onTap: () => setState(() => _selectedTab = i),
          child: Padding(
            padding: const EdgeInsets.only(right: 28),
            child: Column(
              children: [
                Text(
                  _tabs[i],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        isActive ? FontWeight.bold : FontWeight.w500,
                    color: isActive
                        ? const Color(0xFFA3E635)
                        : const Color(0xFF9CA3AF),
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 4,
                  width: isActive ? 32 : 0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA3E635),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final f = _filters[i];
          final isActive = _selectedFilter == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFA3E635).withOpacity(0.15)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive
                      ? const Color(0xFFA3E635)
                      : const Color(0xFFE5E7EB),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black08,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (f['icon'] == 'globe')
                    const Icon(Icons.public,
                        color: Color(0xFF3B82F6), size: 16)
                  else
                    Text(f['flag'] as String,
                        style: const TextStyle(fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(
                    f['label'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isActive
                          ? const Color(0xFF1E293B)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── Grid ──────────────────────────────────────────────────────────────────

  Widget _buildGrid(posts) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: (posts.length / 2).ceil(),
        itemBuilder: (context, rowIndex) {
          final leftIndex = rowIndex * 2;
          final rightIndex = leftIndex + 1;
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                Expanded(
                  child: StreamCardWidget(post: posts[leftIndex]),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: rightIndex < posts.length
                      ? StreamCardWidget(post: posts[rightIndex])
                      : const SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 3.4 / 4.5,
        ),
        itemCount: 6,
        itemBuilder: (_, __) => ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFA3E635),
                strokeWidth: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError(Object err) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off_rounded,
              size: 48, color: Color(0xFF94A3B8)),
          const SizedBox(height: 12),
          Text(
            'Failed to load streams',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF475569)),
          ),
          const SizedBox(height: 6),
          Text(
            err.toString(),
            style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => ref.invalidate(postsProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA3E635),
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Bottom Nav ────────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 88,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFD9F99D), Color(0xFFA3E635)],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Go Live elevated button
              Positioned(
                top: -32,
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xFFA3E635), width: 2),
                          ),
                          child: const Icon(
                            Icons.sensors,
                            color: Color(0xFFA3E635),
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Nav items row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(Icons.home_rounded, 'Home', 0),
                    _navItem(Icons.celebration_outlined, 'Party', 1),
                    // center spacer for go-live button
                    const SizedBox(width: 72),
                    _navItem(Icons.send_outlined, 'Chats', 3),
                    _navItem(Icons.person_outline_rounded, 'Profile', 4),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Home indicator bar
        Container(
          height: 24,
          color: const Color(0xFFA3E635),
          child: Center(
            child: Container(
              width: 120,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isActive = _selectedNavItem == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedNavItem = index),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isActive ? 1.0 : 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
