
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/domain/entities/payment_method.dart';
sealed class PaymentSelectEvent extends Equatable {

  const PaymentSelectEvent();

  @override
  List<Object?> get props => [];
}

class SelectPaymentMethodEvent extends PaymentSelectEvent{
  final PaymentMethods selectedMethod;

const  SelectPaymentMethodEvent({required this.selectedMethod});

 @override
  List<Object?> get props => [selectedMethod];

}


