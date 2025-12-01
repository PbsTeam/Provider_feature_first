import 'dart:developer';

import '../../../../core/api/network_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../service_locator.dart';
import '../model/movies/movie_modal.dart';

class HomeRepository {
  final _networkServices = getIt.get<NetworkApiService>();

  Future<MovieModal> getMovies({required int page}) async {
    final response = await _networkServices.getApiService(
      url: '${ApiConstants.getMovies}?page=$page',
    );


    return MovieModal.fromJson(response);
  }
}
