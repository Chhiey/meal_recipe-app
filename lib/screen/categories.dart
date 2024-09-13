import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/screen/meals.dart';
import 'package:meal_app/widgets/categories_grid_item.dart';
import 'package:meal_app/models/meal.dart';

class CategoryScreen extends StatefulWidget{
 const CategoryScreen({super.key,required this.onToggleFavorite,required this.availabelMeal});

 final void Function(Meal meal) onToggleFavorite ;
 final List<Meal> availabelMeal;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>with SingleTickerProviderStateMixin {
  late AnimationController _animationController ;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync:this, 
      duration:const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
      );

      _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  void _selectedCategory (BuildContext context,Category category){
    final filterdList = widget.availabelMeal
    .where((meal)=> meal.categories.contains(category.id))
    .toList();


    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) =>
        MealScreen(
          title: category.title, 
          meals: filterdList,
          onToggleFavorite: widget.onToggleFavorite,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animationController,
    child: GridView(
        padding:const EdgeInsets.all(16),

        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
        children: [
          for(final category in availableCategories)
            CategoriesItemGrid(category: category,
            onSelectedCategory: () {
              _selectedCategory(context,category);
                },
              ),
        ],
    ),
     builder: (context,child)=>SlideTransition(
      position: Tween(
        begin:const Offset(0, 0.3) ,
        end:const Offset(0, 0),
          ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
     child:  child,
      ),
     ); 
  }
}