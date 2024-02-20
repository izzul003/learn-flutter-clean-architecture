class PageResponse<T> {
  final T? results;
  final int page;

  PageResponse({
    this.results,
    required this.page
  });
}