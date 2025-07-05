import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:politic_news/src/models/news_model.dart';
import 'package:shimmer/shimmer.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  bool _isLoading = true;
  List<News> _bookmarkedNews = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _bookmarkedNews = _getDummyBookmarks();
          _isLoading = false;
        });
      }
    });
  }

  List<News> _getDummyBookmarks() {
    return [
      News(
        id: '1',
        title: 'Presiden Tinjau Pembangunan Infrastruktur di Kalimantan',
        slug: 'presiden-tinjau-pembangunan-infrastruktur-kalimantan',
        summary:
            'Presiden melakukan kunjungan kerja ke Kalimantan untuk meninjau progres pembangunan infrastruktur strategis.',
        content:
            'Presiden melakukan kunjungan kerja ke Kalimantan untuk meninjau progres pembangunan infrastruktur strategis. Dalam kunjungan tersebut, Presiden menekankan pentingnya percepatan pembangunan untuk pemerataan ekonomi di seluruh wilayah Indonesia.',
        featuredImageUrl:
            'https://images.unsplash.com/photo-1541726260-e6078c228b1d?q=80&w=1000',
        category: 'Politik',
        tags: ['Presiden', 'Infrastruktur', 'Kalimantan'],
        isPublished: true,
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
        viewCount: 1250,
        createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
        authorName: 'Budi Santoso',
        authorBio: 'Reporter Politik',
        authorAvatar: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
      News(
        id: '2',
        title: 'Menteri Keuangan: Ekonomi Indonesia Tumbuh di Atas Ekspektasi',
        slug: 'menteri-keuangan-ekonomi-indonesia-tumbuh-di-atas-ekspektasi',
        summary:
            'Menteri Keuangan menyatakan bahwa pertumbuhan ekonomi Indonesia pada kuartal ini melampaui prediksi para ekonom.',
        content:
            'Menteri Keuangan menyatakan bahwa pertumbuhan ekonomi Indonesia pada kuartal ini melampaui prediksi para ekonom. Hal ini didorong oleh peningkatan ekspor dan konsumsi domestik yang terus menguat pasca pandemi.',
        featuredImageUrl:
            'https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=1000',
        category: 'Ekonomi',
        tags: ['Ekonomi', 'Pertumbuhan', 'Menteri Keuangan'],
        isPublished: true,
        publishedAt: DateTime.now().subtract(const Duration(days: 5)),
        viewCount: 980,
        createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
        authorName: 'Siti Rahayu',
        authorBio: 'Analis Ekonomi',
        authorAvatar: 'https://randomuser.me/api/portraits/women/44.jpg',
      ),
      News(
        id: '3',
        title: 'DPR Sahkan UU Perlindungan Data Pribadi',
        slug: 'dpr-sahkan-uu-perlindungan-data-pribadi',
        summary:
            'DPR RI resmi mengesahkan Undang-Undang Perlindungan Data Pribadi dalam rapat paripurna.',
        content:
            'DPR RI resmi mengesahkan Undang-Undang Perlindungan Data Pribadi dalam rapat paripurna. UU ini akan menjadi landasan hukum untuk melindungi data pribadi warga negara Indonesia dari penyalahgunaan oleh pihak yang tidak bertanggung jawab.',
        featuredImageUrl:
            'https://images.unsplash.com/photo-1575505586569-646b2ca898fc?q=80&w=1000',
        category: 'Hukum',
        tags: ['UU', 'Data Pribadi', 'DPR'],
        isPublished: true,
        publishedAt: DateTime.now().subtract(const Duration(days: 7)),
        viewCount: 1560,
        createdAt: DateTime.now().subtract(const Duration(days: 7, hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 7)),
        authorName: 'Ahmad Fauzi',
        authorBio: 'Reporter Hukum',
        authorAvatar: 'https://randomuser.me/api/portraits/men/55.jpg',
      ),
      News(
        id: '4',
        title: 'Tim Nasional Indonesia Lolos ke Final Piala AFF',
        slug: 'tim-nasional-indonesia-lolos-ke-final-piala-aff',
        summary:
            'Timnas Indonesia berhasil mengalahkan Vietnam dan melaju ke final Piala AFF 2023.',
        content:
            'Timnas Indonesia berhasil mengalahkan Vietnam dengan skor 2-0 dan melaju ke final Piala AFF 2023. Gol-gol kemenangan dicetak oleh Witan Sulaeman dan Marselino Ferdinan pada babak kedua pertandingan.',
        featuredImageUrl:
            'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?q=80&w=1000',
        category: 'Olahraga',
        tags: ['Timnas', 'Sepak Bola', 'Piala AFF'],
        isPublished: true,
        publishedAt: DateTime.now().subtract(const Duration(days: 3)),
        viewCount: 2340,
        createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 4)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
        authorName: 'Rudi Hartono',
        authorBio: 'Jurnalis Olahraga',
        authorAvatar: 'https://randomuser.me/api/portraits/men/67.jpg',
      ),
      News(
        id: '5',
        title: 'Startup Indonesia Raih Pendanaan Seri B Senilai 100 Juta Dolar',
        slug: 'startup-indonesia-raih-pendanaan-seri-b-senilai-100-juta-dolar',
        summary:
            'Startup teknologi finansial asal Indonesia berhasil mendapatkan pendanaan Seri B dari investor global.',
        content:
            'Startup teknologi finansial asal Indonesia berhasil mendapatkan pendanaan Seri B senilai 100 juta dolar dari investor global. Dana ini akan digunakan untuk ekspansi ke pasar Asia Tenggara dan pengembangan produk baru.',
        featuredImageUrl:
            'https://images.unsplash.com/photo-1559136555-9303baea8ebd?q=80&w=1000',
        category: 'Teknologi',
        tags: ['Startup', 'Fintech', 'Investasi'],
        isPublished: true,
        publishedAt: DateTime.now().subtract(const Duration(days: 6)),
        viewCount: 1120,
        createdAt: DateTime.now().subtract(const Duration(days: 6, hours: 7)),
        updatedAt: DateTime.now().subtract(const Duration(days: 6)),
        authorName: 'Dewi Lestari',
        authorBio: 'Tech Journalist',
        authorAvatar: 'https://randomuser.me/api/portraits/women/22.jpg',
      ),
    ];
  }

  void _removeBookmark(String id) {
    setState(() {
      _bookmarkedNews.removeWhere((news) => news.id == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Artikel dihapus dari bookmark'),
        action: SnackBarAction(
          label: 'Batalkan',
          onPressed: () {
            setState(() {
              _bookmarkedNews = _getDummyBookmarks()
                  .where(
                    (news) =>
                        news.id == id ||
                        _bookmarkedNews.any((n) => n.id == news.id),
                  )
                  .toList();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Bookmark Saya'),
        centerTitle: true,
        actions: [
          if (_bookmarkedNews.isNotEmpty && !_isLoading)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                _showClearAllDialog();
              },
              tooltip: 'Hapus Semua',
            ),
        ],
      ),
      body: _isLoading
          ? _buildLoadingState()
          : _bookmarkedNews.isEmpty
          ? _buildEmptyState()
          : _buildBookmarkList(),
    );
  }

  Widget _buildBookmarkList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _bookmarkedNews.length,
      itemBuilder: (context, index) {
        final news = _bookmarkedNews[index];
        return _buildBookmarkItem(news);
      },
    );
  }

  Widget _buildBookmarkItem(News news) {
    return Dismissible(
      key: Key(news.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white, size: 30.sp),
      ),
      onDismissed: (direction) {
        _removeBookmark(news.id);
      },
      child: GestureDetector(
        onTap: () {
          context.push('/news/${news.slug}');
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar berita
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      news.featuredImageUrl ??
                      'https://via.placeholder.com/100x100?text=No+Image',
                  width: 120.w,
                  height: 120.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 30.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kategori
                      if (news.category != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A237E).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            news.category!,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1A237E),
                            ),
                          ),
                        ),
                      SizedBox(height: 6.h),
                      Text(
                        news.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12.sp,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            _formatDate(news.publishedAt ?? news.createdAt),
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Icon(
                            Icons.remove_red_eye,
                            size: 12.sp,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${news.viewCount}',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.bookmark_remove,
                            color: Colors.red.shade400,
                            size: 20.sp,
                          ),
                          onPressed: () => _removeBookmark(news.id),
                          tooltip: 'Hapus dari bookmark',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 80.sp, color: Colors.grey.shade400),
          SizedBox(height: 16.h),
          Text(
            'Belum Ada Bookmark',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Artikel yang Anda simpan akan muncul di sini',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () => context.go('/home'),
            icon: const Icon(Icons.explore),
            label: const Text('Jelajahi Berita'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A237E),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Semua Bookmark'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus semua bookmark?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _bookmarkedNews.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Semua bookmark telah dihapus')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = _getMonthName(date.month);
    final year = date.year;

    return '$day $month $year';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return months[month - 1];
  }
}
