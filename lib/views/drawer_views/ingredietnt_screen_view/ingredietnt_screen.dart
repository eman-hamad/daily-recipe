import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/view_model/provider/ingredient.provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({super.key});

  @override
  State<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  @override
  void initState() {
    Provider.of<IngredientsProvider>(context, listen: false).getIngredients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
            // _key.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageIcon(
              AssetImage(
                ImagePath.menuIcon,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageIcon(
              AssetImage(
                ImagePath.notificationIcon,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What Ingredients do you have ?",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
              ),
              Consumer<IngredientsProvider>(
                  builder: (ctx, ingredientProvider, _) => ingredientProvider
                              .ingredientsList ==
                          null
                      ? const CircularProgressIndicator()
                      : (ingredientProvider.ingredientsList?.isEmpty ?? false)
                          ? const Center(child: const Text('No Data Found'))
                          : SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  itemCount: ingredientProvider
                                      .ingredientsList!.length,
                                  itemBuilder: (ctx, index) => ListTile(
                                        leading: Checkbox(
                                            activeColor: orange,
                                            value: ingredientProvider
                                                .ingredientsList![index]
                                                .users_ids
                                                ?.contains(FirebaseAuth
                                                    .instance.currentUser?.uid),
                                            onChanged: (value) {
                                              ingredientProvider
                                                  .addIngredientToUser(
                                                      ingredientProvider
                                                          .ingredientsList![
                                                              index]
                                                          .docId!,
                                                      value ?? false);
                                            }),
                                        title: Text(ingredientProvider
                                                .ingredientsList![index].name ??
                                            'No Name'),
                                      )),
                            )),
            ],
          ),
        ),
      ),
    );
  }
}
