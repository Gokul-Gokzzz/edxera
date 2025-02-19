import 'dart:developer';
import 'package:edxera/category/category_controller.dart';
import 'package:edxera/repositories/api/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class CategoryGridView extends StatefulWidget {
  const CategoryGridView({Key? key}) : super(key: key);

  @override
  _CategoryGridViewState createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  final CategoryController categoryController = Get.put(CategoryController());
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch categories when the widget is first created
    categoryController.fetchCategories();
  }

  Debouncer _searchDebouncer = Debouncer(delay: Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56), // Set a fixed height for the AppBar
        child: AppBar(
          backgroundColor: Colors.white,
          title: isSearching
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    onChanged: (value) {
                      _searchDebouncer.call(
                        () {
                          if (value.isEmpty) {
                            // categoryController.loadCategory();
                          } else {
                            // categoryController.loadCategory(search: value);
                          }
                        },
                      );
                    },
                    controller: searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyle(
                        color: Colors.black), // Set text color to black
                  ),
                )
              : Row(
                  children: [
                    Image.asset(
                      'assets/app_logo.jpeg', // Your logo image
                      height: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Edxera",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade900),
                    ),
                  ],
                ),
          actions: [
            isSearching
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        searchController.clear();
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                  ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (categoryController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (categoryController.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                categoryController.errorMessage.value,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (categoryController.categories.isEmpty) {
            return const Center(
              child: Text(
                'No categories found.',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: categoryController.categories.length,
                    itemBuilder: (context, index) {
                      final category = categoryController.categories[index];
                      log("Image URL ui: ${category.image?.originalImage}");
                      return GestureDetector(
                        onTap: () {
                          categoryController
                              .toggleCategorySelection(category.id!);
                          final selectedIds =
                              categoryController.getSelectedCategoryIds();
                          log('Selected Categories: $selectedIds');
                        },
                        child: Card(
                          elevation: 4,
                          color: category.isCategorySelected == 1
                              ? Colors.blue[50]
                              : Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // category.image?.originalImage != null
                              //     ? Image.network(
                              //         "${ApiConstants.publicBaseUrl}/${category.image!.originalImage ?? ""}",
                              //         height: 80,
                              //         width: 80,
                              //         fit: BoxFit.cover,
                              //         errorBuilder: (context, error, stackTrace) {
                              //           return const Icon(
                              //             Icons.broken_image,
                              //             size: 40,
                              //             color: Colors.grey,
                              //           );
                              //         },
                              //       )
                              //     : const Icon(
                              //         Icons.image_not_supported,
                              //         size: 40,
                              //         color: Colors.grey,
                              //       ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  category.title ?? "No Title",
                                  style: const TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Submit Button
                ElevatedButton(
                  onPressed: categoryController.isSubmitting.value
                      ? null // Disable button when submitting
                      : () {
                          categoryController.submitCategories();
                        },
                  child: categoryController.isSubmitting.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 45),
                    backgroundColor: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            );
          }
        }),
      ),
    );
  }
}
