import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 7 - Flutter Widgets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

// ─────────────────────────────────────────────
// HOME PAGE — menampilkan semua widget per section
// ─────────────────────────────────────────────
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F1A) : const Color(0xFFF4F4FF),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App Header ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF6C63FF), const Color(0xFF9C94FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                left: 24,
                right: 24,
                bottom: 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "TUGAS 7 • PRAKTIKUM ABP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Flutter UI Widgets",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Container • GridView • ListView • Stack",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── 1. CONTAINER ─────────────────────────────────────
          SliverToBoxAdapter(child: _SectionHeader(title: "1. Container", subtitle: "Kotak berwarna dengan dekorasi")),
          SliverToBoxAdapter(child: _ContainerSection()),

          // ── 2. GRIDVIEW ──────────────────────────────────────
          SliverToBoxAdapter(child: _SectionHeader(title: "2. GridView", subtitle: "Minimal 6 item dalam bentuk grid")),
          SliverToBoxAdapter(child: _GridViewSection()),

          // ── 3. LISTVIEW ──────────────────────────────────────
          SliverToBoxAdapter(child: _SectionHeader(title: "3. ListView", subtitle: "3 item: A, B, C")),
          SliverToBoxAdapter(child: _ListViewSection()),

          // ── 4. LISTVIEW.BUILDER ──────────────────────────────
          SliverToBoxAdapter(child: _SectionHeader(title: "4. ListView.builder", subtitle: "List dari data array")),
          SliverToBoxAdapter(child: _ListViewBuilderSection()),

          // ── 5. LISTVIEW.SEPARATED ────────────────────────────
          SliverToBoxAdapter(child: _SectionHeader(title: "5. ListView.separated", subtitle: "List dengan garis pembatas")),
          SliverToBoxAdapter(child: _ListViewSeparatedSection()),

          // ── 6. STACK ────────────────────────────────────────
          SliverToBoxAdapter(child: _SectionHeader(title: "6. Stack", subtitle: "Tampilan bertumpuk (kotak + teks)")),
          SliverToBoxAdapter(child: _StackSection()),

          // ── Footer ───────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Column(
                children: [
                  Divider(color: Colors.grey.withValues(alpha: 0.2)),
                  const SizedBox(height: 16),
                  Text(
                    "Muhammad Amir Saleh",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white70 : const Color(0xFF2E3A59),
                    ),
                  ),
                  Text(
                    "NIM: 2311102233",
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SECTION HEADER WIDGET
// ─────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF2E3A59),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white38 : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 1. CONTAINER SECTION
// ─────────────────────────────────────────────
class _ContainerSection extends StatelessWidget {
  const _ContainerSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Container sederhana berwarna
          Expanded(
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF9C94FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.widgets_rounded, color: Colors.white, size: 28),
                    SizedBox(height: 6),
                    Text("Container", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text("Ungu Gradasi", style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Container dengan border & shadow
          Expanded(
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6584), Color(0xFFFF9A9E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF6584).withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.color_lens_rounded, color: Colors.white, size: 28),
                    SizedBox(height: 6),
                    Text("Container", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text("Merah Muda", style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Container ketiga
          Expanded(
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF43E97B).withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.spa_rounded, color: Colors.white, size: 28),
                    SizedBox(height: 6),
                    Text("Container", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text("Hijau Teal", style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 2. GRIDVIEW SECTION
// ─────────────────────────────────────────────
class _GridViewSection extends StatelessWidget {
  final List<Map<String, dynamic>> _gridItems = const [
    {"label": "Flutter", "icon": Icons.flutter_dash, "color": Color(0xFF6C63FF)},
    {"label": "Dart", "icon": Icons.code_rounded, "color": Color(0xFFFF6584)},
    {"label": "Widget", "icon": Icons.widgets_rounded, "color": Color(0xFF43E97B)},
    {"label": "Layout", "icon": Icons.view_quilt_rounded, "color": Color(0xFFFFA726)},
    {"label": "State", "icon": Icons.sync_rounded, "color": Color(0xFF26C6DA)},
    {"label": "Route", "icon": Icons.alt_route_rounded, "color": Color(0xFFEC407A)},
  ];

  const _GridViewSection();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        itemCount: _gridItems.length,
        itemBuilder: (context, index) {
          final item = _gridItems[index];
          final color = item["color"] as Color;
          return Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E30) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: color.withValues(alpha: 0.25),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item["icon"] as IconData, color: color, size: 26),
                ),
                const SizedBox(height: 8),
                Text(
                  item["label"] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white70 : const Color(0xFF2E3A59),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. LISTVIEW SECTION (3 item: A, B, C)
// ─────────────────────────────────────────────
class _ListViewSection extends StatelessWidget {
  const _ListViewSection();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = [
      {"label": "A", "title": "Item A", "subtitle": "Ini adalah item pertama dalam ListView", "color": const Color(0xFF6C63FF)},
      {"label": "B", "title": "Item B", "subtitle": "Ini adalah item kedua dalam ListView", "color": const Color(0xFFFF6584)},
      {"label": "C", "title": "Item C", "subtitle": "Ini adalah item ketiga dalam ListView", "color": const Color(0xFF43E97B)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E30) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: items.map((item) {
            final color = item["color"] as Color;
            final isLast = items.last == item;
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color.withValues(alpha: 0.15),
                    child: Text(
                      item["label"] as String,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  title: Text(
                    item["title"] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF2E3A59),
                    ),
                  ),
                  subtitle: Text(
                    item["subtitle"] as String,
                    style: TextStyle(
                      color: isDark ? Colors.white38 : Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right_rounded, color: color),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    indent: 70,
                    endIndent: 16,
                    color: isDark ? Colors.white10 : Colors.black12,
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 4. LISTVIEW.BUILDER SECTION
// ─────────────────────────────────────────────
class _ListViewBuilderSection extends StatelessWidget {
  final List<Map<String, String>> _buahData = const [
    {"nama": "Apel", "deskripsi": "Buah segar berwarna merah atau hijau", "emoji": "🍎"},
    {"nama": "Mangga", "deskripsi": "Buah tropis manis berwarna kuning", "emoji": "🥭"},
    {"nama": "Pisang", "deskripsi": "Buah kuning yang kaya kalium", "emoji": "🍌"},
    {"nama": "Jeruk", "deskripsi": "Buah citrus sumber vitamin C", "emoji": "🍊"},
    {"nama": "Anggur", "deskripsi": "Buah kecil manis berbentuk bulat", "emoji": "🍇"},
  ];

  const _ListViewBuilderSection();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E30) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _buahData.length,
          itemBuilder: (context, index) {
            final item = _buahData[index];
            return Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(item["emoji"]!, style: const TextStyle(fontSize: 22)),
                    ),
                  ),
                  title: Text(
                    item["nama"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF2E3A59),
                    ),
                  ),
                  subtitle: Text(
                    item["deskripsi"]!,
                    style: TextStyle(
                      color: isDark ? Colors.white38 : Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "#${index + 1}",
                      style: const TextStyle(
                        color: Color(0xFF6C63FF),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                if (index < _buahData.length - 1)
                  Divider(
                    height: 1,
                    indent: 70,
                    endIndent: 16,
                    color: isDark ? Colors.white10 : Colors.black12,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 5. LISTVIEW.SEPARATED SECTION
// ─────────────────────────────────────────────
class _ListViewSeparatedSection extends StatelessWidget {
  final List<Map<String, String>> _kotaData = const [
    {"kota": "Jakarta", "provinsi": "DKI Jakarta", "emoji": "🏙️"},
    {"kota": "Purwokerto", "provinsi": "Jawa Tengah", "emoji": "🌳"},
    {"kota": "Bandung", "provinsi": "Jawa Barat", "emoji": "🌺"},
    {"kota": "Surabaya", "provinsi": "Jawa Timur", "emoji": "🌊"},
    {"kota": "Yogyakarta", "provinsi": "DIY", "emoji": "🏛️"},
  ];

  const _ListViewSeparatedSection();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E30) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _kotaData.length,
          separatorBuilder: (context, index) => Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isDark ? Colors.white24 : Colors.black12,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          itemBuilder: (context, index) {
            final item = _kotaData[index];
            return ListTile(
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA726).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(item["emoji"]!, style: const TextStyle(fontSize: 22)),
                ),
              ),
              title: Text(
                item["kota"]!,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF2E3A59),
                ),
              ),
              subtitle: Text(
                "Provinsi: ${item["provinsi"]!}",
                style: TextStyle(
                  color: isDark ? Colors.white38 : Colors.black45,
                  fontSize: 12,
                ),
              ),
              trailing: const Icon(Icons.location_on_rounded, color: Color(0xFFFFA726)),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 6. STACK SECTION
// ─────────────────────────────────────────────
class _StackSection extends StatelessWidget {
  const _StackSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Stack Demo 1: Kotak + teks bertumpuk
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                // Layer 1: Background container biru besar
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                // Layer 2: Kotak aksen kiri atas
                Positioned(
                  top: -20,
                  left: -20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.25),
                    ),
                  ),
                ),
                // Layer 3: Kotak aksen kanan bawah
                Positioned(
                  bottom: -30,
                  right: -10,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFF6584).withValues(alpha: 0.2),
                    ),
                  ),
                ),
                // Layer 4: Kotak kecil dekoratif
                Positioned(
                  top: 20,
                  right: 24,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(Icons.layers_rounded, color: Colors.white54, size: 28),
                  ),
                ),
                // Layer 5: Teks utama di atas semua layer
                Positioned(
                  bottom: 24,
                  left: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "STACK WIDGET",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Tampilan Bertumpuk",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        "Teks di atas beberapa kotak warna",
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                // Layer 6: Badge pojok kanan atas
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                        SizedBox(width: 4),
                        Text(
                          "Premium",
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Stack Demo 2: Card bertumpuk
          SizedBox(
            height: 130,
            child: Stack(
              children: [
                // Kartu belakang kanan
                Positioned(
                  top: 10,
                  left: 30,
                  right: 0,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6584).withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                // Kartu belakang tengah
                Positioned(
                  top: 5,
                  left: 15,
                  right: 15,
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      color: const Color(0xFF9C94FF).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                // Kartu depan utama
                Positioned(
                  top: 0,
                  left: 0,
                  right: 30,
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF5A52E5)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.layers_rounded, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text("Stack Kartu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text("Kartu Bertumpuk", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
