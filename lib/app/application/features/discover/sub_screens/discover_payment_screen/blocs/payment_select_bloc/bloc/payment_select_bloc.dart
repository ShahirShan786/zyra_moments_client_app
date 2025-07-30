import 'package:bloc/bloc.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/blocs/payment_select_bloc/bloc/payment_select_event.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/blocs/payment_select_bloc/bloc/payment_select_state.dart';

import 'package:zyra_momments_app/app/domain/usecases/select_payment_method.dart';




class PaymentSelectBloc extends Bloc<PaymentSelectEvent, PaymentSelectState> {
  final SelectPaymentMethod selectPaymentMethod;
  PaymentSelectBloc(this.selectPaymentMethod) : super(PaymentSelectInitial()) {
    on<SelectPaymentMethodEvent>((event, emit) {
     final selectedMethod = selectPaymentMethod.execute(event.selectedMethod);
     emit(PaymentMethodSelected(selectedMethod: selectedMethod));
    });
  }
}
