import 'package:examen_flutter/components/fovorite_button.dart';
import 'package:examen_flutter/models/pet.dart';
import 'package:examen_flutter/provider/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  late List<Pet> favPets;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  late final Animation<Offset> _animation1 = Tween<Offset>(
    begin: const Offset(10.0, 0.0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    ),
  );

  late final Animation<Offset> _animation2 = Tween<Offset>(
    begin: const Offset(0.0, 1.5),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    ),
  );

  @override
  void initState() {
    super.initState();
    favPets = [
      ...Provider.of<PetsProvider>(context, listen: false).getFavoritePets()
    ];

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildListItem(Pet pet, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/pet/${pet.id}");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 4),
            ),
          ],
        ),
        width: double.infinity,
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // image
            SizedBox(
              width: 100,
              height: 150,
              child: Image(
                image: AssetImage(pet.image),
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pet.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        FavoriteIconButton(petId: pet.id)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      pet.summary.replaceRange(70, pet.summary.length, "..."),
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return SlideTransition(
      position: _animation2,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        itemCount: favPets.length,
        itemBuilder: (context, index) =>
            _buildListItem(favPets[index], context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
          ),
          SlideTransition(
            position: _animation1,
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.orange,
              ),
              child: const Icon(
                color: Colors.white,
                Icons.arrow_back,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: _buildListView(context),
          ),
        ],
      ),
    );
  }
}
