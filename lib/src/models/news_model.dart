class NewsResponse {
  final bool success;
  final List<News> data;
  final String message;
  final Pagination? pagination;

  NewsResponse({
    required this.success,
    required this.data,
    required this.message,
    this.pagination,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    final body = json['body'] as Map<String, dynamic>;

    return NewsResponse(
      success: body['success'] as bool? ?? false,
      data: (body['data'] as List<dynamic>? ?? [])
          .map((e) => News.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: body['message'] as String? ?? '',
      pagination: body['pagination'] != null
          ? Pagination.fromJson(body['pagination'] as Map<String, dynamic>)
          : null,
    );
  }
}

class SingleNewsResponse {
  final bool success;
  final News data;
  final String message;

  SingleNewsResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SingleNewsResponse.fromJson(Map<String, dynamic> json) {
    final body = json['body'] as Map<String, dynamic>;

    return SingleNewsResponse(
      success: body['success'] as bool,
      data: News.fromJson(body['data'] as Map<String, dynamic>),
      message: body['message'] as String,
    );
  }
}

class News {
  final String id;
  final String title;
  final String slug;
  final String? summary;
  final String? content;
  final String? featuredImageUrl;
  final String? authorId;
  final String? category;
  final List<String> tags;
  final bool isPublished;
  final DateTime? publishedAt;
  final int viewCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? authorName;
  final String? authorBio;
  final String? authorAvatar;

  News({
    required this.id,
    required this.title,
    required this.slug,
    this.summary,
    this.content,
    this.featuredImageUrl,
    this.authorId,
    this.category,
    required this.tags,
    required this.isPublished,
    this.publishedAt,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
    this.authorName,
    this.authorBio,
    this.authorAvatar,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      summary: json['summary'] as String?,
      content: json['content'] as String?,
      featuredImageUrl: json['featured_image_url'] as String?,
      authorId: json['author_id'] as String?,
      category: json['category'] as String?,
      tags: (json['tags'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      isPublished: json['is_published'] as bool? ?? false,
      publishedAt: json['published_at'] != null
          ? DateTime.parse(json['published_at'] as String)
          : null,
      viewCount: json['view_count'] as int? ?? 0,
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? DateTime.now().toString(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] as String? ?? DateTime.now().toString(),
      ),
      authorName: json['author_name'] as String?,
      authorBio: json['author_bio'] as String?,
      authorAvatar: json['author_avatar'] as String?,
    );
  }
}

class CreateNewsRequest {
  final String title;
  final String summary;
  final String content;
  final String? featuredImageUrl;
  final String category;
  final List<String> tags;
  final bool isPublished;

  CreateNewsRequest({
    required this.title,
    required this.summary,
    required this.content,
    this.featuredImageUrl,
    required this.category,
    required this.tags,
    required this.isPublished,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'summary': summary,
      'content': content,
      'featuredImageUrl': featuredImageUrl,
      'category': category,
      'tags': tags,
      'isPublished': isPublished,
    };
  }
}

class UpdateNewsRequest {
  final String? title;
  final String? summary;
  final String? content;
  final String? featuredImageUrl;
  final String? category;
  final List<String>? tags;
  final bool? isPublished;

  UpdateNewsRequest({
    this.title,
    this.summary,
    this.content,
    this.featuredImageUrl,
    this.category,
    this.tags,
    this.isPublished,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (title != null) map['title'] = title;
    if (summary != null) map['summary'] = summary;
    if (content != null) map['content'] = content;
    if (featuredImageUrl != null) map['featuredImageUrl'] = featuredImageUrl;
    if (category != null) map['category'] = category;
    if (tags != null) map['tags'] = tags;
    if (isPublished != null) map['isPublished'] = isPublished;

    return map;
  }
}

class Pagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] as int,
      limit: json['limit'] as int,
      total: json['total'] as int,
      totalPages: json['totalPages'] as int,
      hasNext: json['hasNext'] as bool,
      hasPrev: json['hasPrev'] as bool,
    );
  }
}
