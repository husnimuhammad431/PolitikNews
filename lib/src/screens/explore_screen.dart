import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:politic_news/src/controllers/news_controller.dart';
import 'package:politic_news/src/models/news_model.dart';
import 'package:shimmer/shimmer.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  final NewsController _newsController = NewsController();
  late TabController _tabController;

  final List<String> _categories = [
    'Semua',
    'Politik',
    'Ekonomi',
    'Sosial',
    'Hukum',
    'Olahraga',
    'Teknologi',
  ];

  final _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  late Future<NewsResponse> _newsFuture;
  List<News> _allNews = [];
  List<News> _filteredNews = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(_handleTabChange);
    _loadAllNews();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      _filterNewsByCategory(_categories[_tabController.index]);
    }
  }

  Future<void> _loadAllNews() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      _newsFuture = _newsController.getPublishedNews(limit: 50);
      final response = await _newsFuture;

      setState(() {
        _allNews = response.data;
        _filterNewsByCategory(_categories[_tabController.index]);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterNewsByCategory(String category) {
    setState(() {
      if (category == 'Semua') {
        _filteredNews = List.from(_allNews);
      } else {
        _filteredNews = _allNews
            .where((news) => news.category == category)
            .toList();
      }
    });
  }

  void _performSearch() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
      if (_searchQuery.isNotEmpty) {
        _isSearching = true;
        _filteredNews = _allNews
            .where(
              (news) =>
                  news.title.toLowerCase().contains(_searchQuery) ||
                  (news.summary?.toLowerCase().contains(_searchQuery) ??
                      false) ||
                  (news.content?.toLowerCase().contains(_searchQuery) ??
                      false) ||
                  news.tags.any(
                    (tag) => tag.toLowerCase().contains(_searchQuery),
                  ),
            )
            .toList();
      } else {
        _isSearching = false;
        _filterNewsByCategory(_categories[_tabController.index]);
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _isSearching = false;
      _filterNewsByCategory(_categories[_tabController.index]);
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari berita...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                onSubmitted: (_) => _performSearch(),
                autofocus: true,
              )
            : const Text('Jelajahi'),
        centerTitle: !_isSearching,
        leading: _isSearching
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _clearSearch,
              )
            : null,
        actions: [
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
          if (_isSearching)
            IconButton(icon: const Icon(Icons.clear), onPressed: _clearSearch),
        ],
        bottom: !_isSearching
            ? TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: _categories.map((category) {
                  return Tab(text: category);
                }).toList(),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.7),
                indicatorColor: Colors.white,
                indicatorWeight: 3,
              )
            : null,
      ),
      body: _isLoading
          ? _buildLoadingState()
          : _error != null
          ? _buildErrorState(_error!)
          : _isSearching
          ? _buildSearchResults()
          : TabBarView(
              controller: _tabController,
              children: _categories.map((category) {
                return _buildNewsList();
              }).toList(),
            ),
    );
  }

  Widget _buildNewsList() {
    if (_filteredNews.isEmpty) {
      return _buildEmptyState(
        'Tidak ada berita di kategori ${_categories[_tabController.index]}',
      );
    }

    return RefreshIndicator(
      onRefresh: _loadAllNews,
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: _filteredNews.length,
        itemBuilder: (context, index) {
          return _buildNewsItem(_filteredNews[index]);
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_filteredNews.isEmpty) {
      return _buildEmptyState('Tidak ada hasil untuk "$_searchQuery"');
    }

    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            'Hasil pencarian untuk "$_searchQuery"',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        ...(_filteredNews.map((news) => _buildNewsItem(news)).toList()),
      ],
    );
  }

  Widget _buildNewsItem(News news) {
    return GestureDetector(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar berita
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    news.featuredImageUrl ??
                    'https://via.placeholder.com/800x400?text=No+Image',
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(height: 180.h, color: Colors.white),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 180.h,
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.image_not_supported,
                    size: 40.sp,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),

            // Konten berita
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (news.category != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
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
                      const Spacer(),
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
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    news.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (news.summary != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      news.summary!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        news.authorName ?? 'Admin',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.remove_red_eye,
                        size: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${news.viewCount}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  if (news.tags.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 24.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: news.tags.length > 3 ? 3 : news.tags.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Text(
                              '#${news.tags[index]}',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
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
              height: 280.h,
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

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
            SizedBox(height: 16.h),
            Text(
              'Terjadi Kesalahan',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              error,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: _loadAllNews,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A237E),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 60.sp, color: Colors.grey.shade400),
            SizedBox(height: 16.h),
            Text(
              'Tidak Ada Hasil',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} menit yang lalu';
      }
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else {
      final day = date.day.toString().padLeft(2, '0');
      final month = _getMonthName(date.month);
      final year = date.year;
      return '$day $month $year';
    }
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
