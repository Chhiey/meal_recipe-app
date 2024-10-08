import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget{
  const MealDetailScreen({super.key,required this.meal,required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [IconButton(
          onPressed: (){onToggleFavorite(meal);}, 
          icon: AnimatedSwitcher(
            duration:const Duration(milliseconds: 300),
            transitionBuilder:(child,animation) {
              return RotationTransition(
                turns: 
                  animation,
                  child:child);},
            child:const Icon(Icons.star,key : ValueKey(Icon)),) 
              )],
      ),
      body: SingleChildScrollView(
        child: Column(children: [Hero(
          tag: meal.id,
          child: Image.network(
            meal.imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
              ),
        ),
          const SizedBox(height: 14,),
          Text(
            'Ingredient',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 14,),
            for(final ingredient in meal.ingredients)
              Text(
                ingredient, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,),
              ),
            const SizedBox(height: 14,),
            Text(
            'Step',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
                ),
              ),
              for(final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal:12),
                child: Text(
                  textAlign: TextAlign.center,
                  step, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,),
                ),
              ),
          ],
        ),
      )
    );
  }
}