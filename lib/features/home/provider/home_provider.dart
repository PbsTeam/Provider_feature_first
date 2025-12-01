import 'dart:developer';

import 'package:feature_base/common/widgets/custom_toast.dart';
import 'package:feature_base/features/home/data/repository/hom_respository.dart';
import 'package:flutter/material.dart';

import '../data/model/movies/movie_modal.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepository homeRepository;
  HomeProvider({required this.homeRepository});
  bool loading = false;
  bool isMoreLoading = false;
  bool isRequesting = false;
  bool hasMore = true;
  int page = 1;
  int totalPages = 1;

  List<TVShows> movies = <TVShows>[];

  Future<void> fetchMovies({int page = 1}) async {
    // If no more data → do nothing
    if (!hasMore) return;

    // First page → show main loader
    if (page == 1) {
      loading = true;
      notifyListeners();
    } else {
      isMoreLoading = true;
      notifyListeners();
    }

    try {
      final movieResponse = await homeRepository.getMovies(page: page);

      List<TVShows> newMovies = [...movies, ...movieResponse.tvShows ?? []];
      movies = newMovies;
    } catch (e) {
      CustomToast.showToast(e.toString());
    } finally {
      loading = false;
      isMoreLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreMovies() async {
    if (isRequesting || isMoreLoading || !hasMore) return;

    isRequesting = true;
    isMoreLoading = true;

    final nextPage = page + 1;
    page = nextPage;

    await fetchMovies(page: page);

    try {
      final response = await homeRepository.getMovies(page: nextPage);
      List<TVShows> newMovies = [...movies, ...response.tvShows ?? []];
      movies = newMovies;
    } catch (e) {
      isMoreLoading = false;
    } finally {
      isMoreLoading = false;
      isRequesting = false;

      notifyListeners();
    }
  }
}
