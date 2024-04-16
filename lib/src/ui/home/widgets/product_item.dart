import 'package:flutter/material.dart';
import 'package:innotest/src/constants/colors.dart';
import 'package:innotest/src/models/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Seller : ${product.id}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.lightTextColor,
                    ),
                  ),
                  Row(
                    children: [
                      ...[1, 2, 3, 4, 5]
                          .map(
                            (e) => Icon(
                              Icons.star,
                              size: 16,
                              color: e <= product.rating.rate
                                  ? Colors.amber
                                  : AppColors.lightTextColor,
                            ),
                          )
                          .toList(),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '(${product.rating.rate})  (${product.rating.count})',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.lightTextColor,
                          ),
                        ),
                      ),
                      Text(
                        product.price == 0 ? 'Free' : '\$${product.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
