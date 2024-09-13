import 'package:flutter/material.dart';

  enum Filter{
    glutenFree,
    lactoseFree,
    vegetarian,
    vegan,
  }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key,required this.currentFilters});

  final Map<Filter,bool> currentFilters ;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {

  var _gluttenFreeFiltersSet = false;
  var _lactoseFreeFiltersSet = false;
  var _vegetarianFiltersSet = false;
  var _veganFiltersSet = false;

  @override
  void initState() {
    super.initState();
    _gluttenFreeFiltersSet= widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFiltersSet= widget.currentFilters[Filter.lactoseFree]!;
    _veganFiltersSet= widget.currentFilters[Filter.vegan]!;
    _vegetarianFiltersSet= widget.currentFilters[Filter.vegetarian]!;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Filters Meals'),
        ),
      //drawer: MainDrawer(onSelectScreen: (identifier){
       // Navigator.of(context).pop();
        //if(identifier=='meals'){
         // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const TapScreen()));
       // }
      //}),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop){
          if(didPop) return ;
          Navigator.of(context).pop({
            Filter.glutenFree: _gluttenFreeFiltersSet,
            Filter.lactoseFree: _lactoseFreeFiltersSet,
            Filter.vegetarian: _vegetarianFiltersSet,
            Filter.vegan: _veganFiltersSet,
            }
          );
        },
        child: Column(children: [
          SwitchListTile(
            value: _gluttenFreeFiltersSet,
            onChanged: (isCheck){
              setState(() {
                _gluttenFreeFiltersSet = isCheck;
              });
            },
            title: Text('Glutten Free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary),
              ),
            subtitle: Text('only glutten free meals!',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34,right: 22),
                ),
          SwitchListTile(
            value: _lactoseFreeFiltersSet,
            onChanged: (isCheck){
              setState(() {
                _lactoseFreeFiltersSet = isCheck;
              });
            },
            title: Text('Lactose Free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary),
              ),
            subtitle: Text('only Lactose free meals!',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34,right: 22),
                ),
          SwitchListTile(
            value: _vegetarianFiltersSet,
            onChanged: (isCheck){
              setState(() {
                _vegetarianFiltersSet = isCheck;
              });
            },
            title: Text('Vegetarian',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary),
              ),
            subtitle: Text('only vegetarian meals!',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34,right: 22),
                ),
          SwitchListTile(
            value: _veganFiltersSet,
            onChanged: (isCheck){
              setState(() {
                _veganFiltersSet = isCheck;
              });
            },
            title: Text('Vegan',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary),
              ),
            subtitle: Text('only vegan meals!',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34,right: 22),
                ),
          ],),
      ),
      );
  }
}