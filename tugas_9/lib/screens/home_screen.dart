import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import '../services/fcm_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _fabAnimController;
  late Animation<double> _fabScaleAnim;
  String? _fcmToken;
  String? _lastFcmMessage;

  @override
  void initState() {
    super.initState();

    // Animasi FAB
    _fabAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fabScaleAnim = CurvedAnimation(
      parent: _fabAnimController,
      curve: Curves.elasticOut,
    );
    _fabAnimController.forward();

    // Setup FCM callback untuk tampilkan banner di UI
    FcmService().onMessageReceived = (title, body) {
      if (mounted) {
        setState(() {
          _lastFcmMessage = '🔔 $title: $body';
        });
        _showFcmSnackBar(title, body);
      }
    };

    // Load FCM token
    _loadFcmToken();
  }

  Future<void> _loadFcmToken() async {
    final token = await FcmService().getToken();
    if (mounted) setState(() => _fcmToken = token);
  }

  void _showFcmSnackBar(String title, String body) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Text('🔔', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(body,
                      style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF6C63FF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    _controller.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E30) : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Tambah Tugas Baru',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF2E3A59),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Nama tugas...',
                    filled: true,
                    fillColor: isDark
                        ? Colors.white.withValues(alpha: 0.07)
                        : const Color(0xFFF4F4FF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color(0xFF6C63FF), width: 2),
                    ),
                    prefixIcon: const Icon(Icons.task_alt_rounded,
                        color: Color(0xFF6C63FF)),
                  ),
                  onSubmitted: (_) => _submitTask(ctx),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () => _submitTask(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Tambah Tugas',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitTask(BuildContext ctx) {
    if (_controller.text.trim().isNotEmpty) {
      context.read<TodoProvider>().addTodo(_controller.text);
      Navigator.pop(ctx);
    }
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Semua Tugas?',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content:
            const Text('Semua tugas akan dihapus secara permanen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TodoProvider>().clearAll();
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Hapus Semua'),
          ),
        ],
      ),
    );
  }

  void _showFcmTokenDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.key_rounded, color: Color(0xFF6C63FF)),
            SizedBox(width: 8),
            Text('FCM Token', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gunakan token ini di Firebase Console untuk uji notifikasi:',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                _fcmToken ?? 'Token belum tersedia...',
                style: const TextStyle(
                    fontSize: 11, fontFamily: 'Courier', color: Color(0xFF2E3A59)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _fabAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F0F1A) : const Color(0xFFF4F4FF),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF9C94FF)],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "TUGAS 9 • PRAKTIKUM ABP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      // Tombol lihat FCM Token
                      IconButton(
                        onPressed: _showFcmTokenDialog,
                        icon: const Icon(Icons.vpn_key_rounded,
                            color: Colors.white70),
                        tooltip: 'Lihat FCM Token',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "To-Do List",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Text(
                    "Provider + Firebase Cloud Messaging",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  // Stats card
                  Consumer<TodoProvider>(
                    builder: (ctx, provider, _) => Row(
                      children: [
                        _StatChip(
                          label: 'Total',
                          value: provider.todos.length,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        _StatChip(
                          label: 'Aktif',
                          value: provider.pendingCount,
                          color: Colors.amberAccent,
                        ),
                        const SizedBox(width: 8),
                        _StatChip(
                          label: 'Selesai',
                          value: provider.doneCount,
                          color: const Color(0xFF43E97B),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── FCM Banner (jika ada pesan masuk) ───────────────
          if (_lastFcmMessage != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Text('📩', style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _lastFcmMessage!,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : const Color(0xFF2E3A59),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        onPressed: () =>
                            setState(() => _lastFcmMessage = null),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // ── Toolbar: judul section + tombol hapus semua ──────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daftar Tugas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF2E3A59),
                    ),
                  ),
                  Consumer<TodoProvider>(
                    builder: (ctx, provider, _) => provider.todos.isNotEmpty
                        ? TextButton.icon(
                            onPressed: () => _showClearDialog(context),
                            icon: const Icon(Icons.delete_sweep_rounded,
                                size: 18, color: Colors.redAccent),
                            label: const Text('Hapus Semua',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 13)),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),

          // ── To-Do List ───────────────────────────────────────
          Consumer<TodoProvider>(
            builder: (ctx, provider, _) {
              if (provider.todos.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF)
                                .withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.checklist_rounded,
                            size: 64,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Belum Ada Tugas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF2E3A59),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tekan tombol + untuk menambah tugas baru',
                          style: TextStyle(
                            color: isDark ? Colors.white38 : Colors.black38,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) {
                    final todo = provider.todos[index];
                    return _TodoCard(
                      todo: todo,
                      onToggle: () =>
                          provider.toggleTodo(todo.id),
                      onDelete: () =>
                          provider.removeTodo(todo.id),
                    );
                  },
                  childCount: provider.todos.length,
                ),
              );
            },
          ),

          // ── Bottom padding ───────────────────────────────────
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),

      // ── FAB: Tambah Tugas ───────────────────────────────────
      floatingActionButton: ScaleTransition(
        scale: _fabScaleAnim,
        child: FloatingActionButton.extended(
          onPressed: () => _showAddDialog(context),
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          elevation: 8,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Tambah Tugas',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),

      // ── Footer: identitas ───────────────────────────────────
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: isDark ? const Color(0xFF0F0F1A) : const Color(0xFFF4F4FF),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Muhammad Amir Saleh — NIM: 2311102233',
              style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Colors.white38 : Colors.black38),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat Chip Widget ─────────────────────────────────────────
class _StatChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatChip(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '$value',
            style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.w800),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

// ── To-Do Card Widget ────────────────────────────────────────
class _TodoCard extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _TodoCard({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_rounded, color: Colors.white, size: 28),
            Text('Hapus', style: TextStyle(color: Colors.white, fontSize: 11)),
          ],
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E30) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: todo.isDone
                ? const Color(0xFF43E97B).withValues(alpha: 0.4)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: todo.isDone
                    ? const Color(0xFF43E97B)
                    : Colors.transparent,
                border: Border.all(
                  color: todo.isDone
                      ? const Color(0xFF43E97B)
                      : const Color(0xFF6C63FF),
                  width: 2.5,
                ),
              ),
              child: todo.isDone
                  ? const Icon(Icons.check_rounded,
                      color: Colors.white, size: 18)
                  : null,
            ),
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: todo.isDone
                  ? (isDark ? Colors.white38 : Colors.black38)
                  : (isDark ? Colors.white : const Color(0xFF2E3A59)),
              decoration:
                  todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          subtitle: Text(
            '${todo.isDone ? "✅ Selesai" : "⏳ Belum selesai"} • ${_formatTime(todo.createdAt)}',
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline_rounded,
                color: Colors.redAccent, size: 22),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
