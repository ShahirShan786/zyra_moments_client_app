import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/models/category_model.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';
import 'package:zyra_momments_app/data/repository/category_repository_impl.dart';
import 'package:zyra_momments_app/domain/repository/category_repository.dart';

class CategoryUsecases {
  final CategoryRepository categoryRepository = CategoryRepositoryImpl();
  Future<Either<Failure, List<Categories>>> getCategories(){
    return categoryRepository.getCategories();

  }

  Future<Either<Failure , List<Vendor>>> getVendorsCategories({ required String categoryId  , String search = ''}){
    return categoryRepository.getVendorCategories(categoryId: categoryId ,search: search);
  }
}