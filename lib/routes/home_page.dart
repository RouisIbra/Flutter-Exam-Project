import 'package:examen_flutter/models/pet.dart';
import 'package:examen_flutter/provider/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation<Offset> _animation1 =
      Tween<Offset>(begin: const Offset(0.0, -1.5), end: Offset.zero).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ),
  );
  late final Animation<Offset> _animation2 =
      Tween<Offset>(begin: const Offset(0.0, 1.5), end: Offset.zero).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final descTitleTextStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  final descTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  Widget _pageHeader(BuildContext context) {
    return SlideTransition(
      position: _animation1,
      child: Container(
        padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.3),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Choose your pet",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              "We have the largest selection of pets",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _petCard(Pet pet, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/pet/${pet.id}");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // pet info container
            Positioned(
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 130),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          right: 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pet.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Icon(
                              pet.gender == "male" ? Icons.male : Icons.female,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Breed:",
                            style: descTitleTextStyle,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            pet.breed,
                            style: descTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        pet.age,
                        style: descTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Distance:",
                            style: descTitleTextStyle,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            pet.distance,
                            style: descTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // pet image container
            Positioned(
              left: 0,
              child: Container(
                width: 120,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Hero(
                  tag: pet.id.toString(),
                  child: Image(
                    image: AssetImage(pet.image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return Consumer<PetsProvider>(
      builder: (context, petsProvider, child) {
        if (petsProvider.pets != null) {
          return Expanded(
            child: SlideTransition(
              position: _animation2,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                itemCount: petsProvider.pets!.length,
                itemBuilder: (context, index) => _petCard(
                  petsProvider.pets![index],
                  context,
                ),
              ),
            ),
          );
        } else {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push("/favorites");
        },
        backgroundColor: Colors.yellow[300],
        child: const Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_pageHeader(context), _listView(context)],
      ),
    );
  }
}
