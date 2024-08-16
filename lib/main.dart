import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop/addproduct/bloc/create_product_bloc_bloc.dart';
import 'package:new_shop/addproduct/datasource/addproduct_datasource.dart';
import 'package:new_shop/addproduct/view/add_product.dart';
import 'package:new_shop/app_bloc_observer.dart';
import 'package:new_shop/home/bloc/home_bloc.dart';
import 'package:new_shop/home/datasource/profile_datasource.dart';
import 'package:new_shop/home/view/home_page.dart';
import 'package:new_shop/login/bloc/login_bloc.dart';
import 'package:new_shop/login/datasource/login_datasource.dart';
import 'package:new_shop/login/view/login_page.dart';
import 'package:new_shop/productimageupload/bloc/productimageupload_bloc.dart';
import 'package:new_shop/productimageupload/datasource/productimageupload_datasource.dart';
import 'package:new_shop/productlist/bloc/productlist_bloc.dart';
import 'package:new_shop/productlist/datasource/product_list_datasource.dart';
import 'package:new_shop/register/bloc/register_bloc.dart';
import 'package:new_shop/register/datasource/register_datasource.dart';
import 'package:new_shop/register/view/register_page.dart';
import 'package:new_shop/shared/datasource/token_datasource.dart';

void main() {
  Bloc.observer = const AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(
            RegisterDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            LoginDatasource(),
            TokenDatasource(),
          )..add(SystemCheckTokenEvent()), // Ensure token is checked at startup
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            TokenDatasource(),
            ProfileDatasource(), // Pass the ProfileDatasource here
          ),
        ),
        BlocProvider(
          create: (context) => ProductlistBloc(
            ProductDatasource(), // Ensure the datasource is correct
          ),
        ),
        BlocProvider(
          create: (context) => CreateProductBloc(AddproductDatasource()),
          // child: CreateProductPage(),
        ),
        BlocProvider(
          create: (context) => ProductImageUploadBloc(
              UploadImageDatasource()), // Add the ProductimageuploadBloc provider here
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const CustomLoginScreen(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
          '/addproduct': (context) => CreateProductPage(),
        },
      ),
    );
  }
}
