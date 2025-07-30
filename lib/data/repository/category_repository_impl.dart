import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/data_source/category_remote_data_source.dart';
import 'package:zyra_momments_app/data/models/category_model.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';
import 'package:zyra_momments_app/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryRemoteDataSource categoryRemoteDataSource = CategoryRemoteDataSourceImpl();
  @override
  Future<Either<Failure, List<Categories>>> getCategories() async{
     return await categoryRemoteDataSource.getCategories();
  
  }

  @override
Future<Either<Failure, List<Vendor>>> getVendorCategories({required String categoryId , String search = ''})async {
   return categoryRemoteDataSource.getvendorCategory(categoryId: categoryId , search: search);
  }
}