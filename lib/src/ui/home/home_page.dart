import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innotest/src/constants/colors.dart';
import 'package:innotest/src/logic/repo/app_repository.dart';
import 'package:innotest/src/models/product_model.dart';
import 'package:innotest/src/ui/home/home_page_model.dart';
import 'package:innotest/src/ui/home/widgets/product_item.dart';
import 'package:innotest/src/utils/text_style.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _pageSize = 10;

  final PagingController<int, ProductModel> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ref
          .read(homePageModelProvider.notifier)
          .fetchProducts(_pageSize, pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ref.watch(homePageModelProvider.select((value) => value.notes));
    final status =
        ref.watch(homePageModelProvider.select((value) => value.status));

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Academy',
              style: AppTextStyles.customStyle(
                size: 20,
                weight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  ref.read(appRepositoryProvider.notifier).logout();
                },
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              PagedSliverList<int, ProductModel>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<ProductModel>(
                  itemBuilder: (context, item, index) => ProductItem(
                    product: item,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
