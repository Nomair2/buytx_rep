part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

final class FetchProducts extends ProductsEvent {
  //Params for later
}

final class AddProduct extends ProductsEvent {
  final Product product;
  const AddProduct(this.product);
}
