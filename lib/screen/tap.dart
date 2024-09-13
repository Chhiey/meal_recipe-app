import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screen/categories.dart';
import 'package:meal_app/screen/filters.dart';
import 'package:meal_app/screen/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/meal_provider.dart';

const kInitalFilter ={
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false, 
};

class TapScreen extends ConsumerStatefulWidget {
  const TapScreen({super.key});

  @override
  ConsumerState<TapScreen> createState() {
    return _TapScreenState();
  }
}

class _TapScreenState extends ConsumerState<TapScreen> {
  int selectedPageIndex = 0;
  final List<Meal> _favoriteMeal = [];
  Map<Filter,bool> _selectedFilters = kInitalFilter;

  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)
      ), 
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);


    if (isExisting) {
      setState(() {
         _favoriteMeal.remove(meal);
       });
      _showInfoMessage('Meal no longer a favorite');
      }else {
      setState(() {
        _showInfoMessage('Added meal to favorites');
         _favoriteMeal.add(meal);
        });
      }
  }

  void _selectedPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier)async{
    Navigator.of(context).pop();
    if(identifier == 'filters'){
     final result = await Navigator.of(context).push<Map<Filter,bool>>(MaterialPageRoute(
      builder: (ctx)=> FiltersScreen(currentFilters: _selectedFilters,)));
     setState(() {
       _selectedFilters =result ?? kInitalFilter;
     });
      }
    }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider);
    final availableMeal = meals.where((meal){
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoryScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availabelMeal: availableMeal,);
    var activePageTitle = 'Categories';
    if (selectedPageIndex == 1){
      activePage = MealScreen(meals: _favoriteMeal,onToggleFavorite: _toggleMealFavoriteStatus,);
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar:AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: "Favorites"),
        ],
      ),
        );
  }
}