import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/models/category_model.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';

abstract class CategoryRepository {
  Future<Either<Failure,List<Categories>>> getCategories();

  Future<Either<Failure, List<Vendor>>> getVendorCategories({ required String categoryId , String search = ''});
}