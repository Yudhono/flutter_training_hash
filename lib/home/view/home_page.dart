import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop/home/bloc/home_bloc.dart';
import 'package:new_shop/productlist/bloc/productlist_bloc.dart';
import 'package:new_shop/productlist/view/productlist_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Trigger profile and product list loading when the page is first loaded
    context.read<HomeBloc>().add(LoadProfile());
    context.read<ProductlistBloc>().add(FetchProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            // redirect to add product page
            Navigator.of(context).pushNamed('/addproduct');
          },
          icon: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeLogoutSuccess) {
                  // Navigate to login and remove all previous routes
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  );
                }
              },
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeProfileLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Welcome, ${state.profile.name}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                          onPressed: () {
                            // Trigger logout event
                            context.read<HomeBloc>().add(UserTapLogoutButton());
                          },
                          icon: Icon(Icons.logout))
                      // Text('Email: ${state.profile.email}'),
                      // const SizedBox(height: 20),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      // onPressed: () {
                      //   // Trigger logout event
                      //   context.read<HomeBloc>().add(UserTapLogoutButton());
                      // },
                      //     child: const Text('Logout'),
                      //   ),
                      // ),
                    ],
                  );
                } else if (state is HomeError) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                }
                return const SizedBox
                    .shrink(); // Adjusted to return an empty widget instead of a plain text
              },
            ),
            const SizedBox(height: 20),
            // const Expanded(
            //   child: ProductListView(), // Use the new ProductListView widget
            // ),
          ],
        ),
      ),
    );
  }
}
