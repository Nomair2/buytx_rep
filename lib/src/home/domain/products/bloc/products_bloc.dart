import 'package:bloc/bloc.dart';
import 'package:buytx/src/home/data/product.dart';
import 'package:buytx/src/home/data/products_data_source.dart';
import 'package:buytx/src/home/domain/products/product_manager.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  //The data source/repository later.
  RemoteProductsDataSource remoteProductsDataSource =
      RemoteProductsDataSource();
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) {});
    on<FetchProducts>(_fetchProducts);
    on<AddProduct>(_addProduct);
  }

  _fetchProducts(event, emit) async {
    List<Product> products =
        await remoteProductsDataSource.getProductsBasedOnFilters();
    print(products.length);
    emit(ProductsReady(products.map((e) => ProductManager(e)).toList()));
  }

  _addProduct(AddProduct event, emit) async {
    await remoteProductsDataSource.addProduct(event.product);
    //refetch products
    add(FetchProducts());
  }
}
