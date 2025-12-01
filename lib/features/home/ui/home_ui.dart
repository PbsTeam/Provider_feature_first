import 'package:feature_base/common/exceptions/theme_exception.dart';
import 'package:feature_base/core/constants/color_constants.dart';
import 'package:feature_base/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/loader_widget.dart';
import '../../../core/local_storage/local_storage.dart';
import '../../../core/localization/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<HomeProvider>().fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 4.0,
        surfaceTintColor: context.theme.scaffoldBackgroundColor,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        title: Text(
          localization.movies,
          style: context.theme.textTheme.titleMedium!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorConstants.blue,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showLogoutBottomSheet(context, localization),
            icon: Icon(Icons.logout, color: ColorConstants.blue),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          final homeProvider = context.watch<HomeProvider>();

          _scrollController.addListener(() {
            final position = _scrollController.position;

            if (position.pixels >= position.maxScrollExtent - 200) {
              homeProvider.loadMoreMovies();
            }
          });

          if (homeProvider.loading) {
            return const Center(child: Loader());
          }

          if (homeProvider.movies.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: homeProvider.movies.length,
                    itemBuilder: (context, index) {
                      final tvShows = homeProvider.movies[index];

                      return Card(
                        color: context.theme.cardColor,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                child: Image.network(
                                  tvShows.imageThumbnail ?? '',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 6,
                              ),
                              child: Text(
                                tvShows.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.theme.textTheme.titleMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                if (homeProvider.isMoreLoading) ...[
                  const SizedBox(height: 15),
                  const Center(child: Loader()),
                  const SizedBox(height: 15),
                ],
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Future<bool?> showLogoutBottomSheet(
    BuildContext context,
    AppLocalizations localization,
  ) {
    return showModalBottomSheet<bool>(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),

              Text(
                localization.logoutText,
                style: context.theme.textTheme.titleMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),

                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              /// NO button
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: ColorConstants.blue,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text(
                          localization.no,
                          style: context.theme.textTheme.titleMedium!.copyWith(
                            fontSize: 16,
                            color: ColorConstants.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// YES button
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          LocalStorage.instance.clearAll(context);
                        },
                        child: Text(
                          localization.yes,
                          style: context.theme.textTheme.titleMedium!.copyWith(
                            fontSize: 16,
                            color: ColorConstants.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
