import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';

abstract class VendorProfileRepository {
  Future<Either<Failure , VendorProfileModel>> getVendorProfileDetails(String categoryId);
  Future<Either<Failure , List<Vendor>>> getBestVenodrProfile();
}