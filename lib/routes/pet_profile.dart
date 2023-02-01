import 'package:examen_flutter/components/fovorite_button.dart';
import 'package:examen_flutter/models/pet.dart';
import 'package:examen_flutter/provider/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:go_router/go_router.dart";

class PetProfile extends StatefulWidget {
  const PetProfile({super.key, required this.petId});

  final int petId;

  @override
  State<PetProfile> createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile>
    with SingleTickerProviderStateMixin {
  final descTitleTextStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 18,
  );
  final descTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 18,
  );

  late Pet pet;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 1.5),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    ),
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

  @override
  initState() {
    super.initState();
    pet = Provider.of<PetsProvider>(context, listen: false)
        .getPetByid(widget.petId)!;

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildPropBox(String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(
        minWidth: 90,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.yellow),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: descTitleTextStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            desc,
            style: descTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _summarySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Summary",
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            pet.summary,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
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
          // pet image
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Hero(
                  tag: pet.id.toString(),
                  child: Image(
                    image: AssetImage(pet.image),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          // pet info box
          Expanded(
            child: SlideTransition(
              position: _offsetAnimation,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 5,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pet.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text("Origin: ", style: descTitleTextStyle),
                                  Text(
                                    pet.origin,
                                    style: descTextStyle,
                                  ),
                                ],
                              )
                            ],
                          ),
                          FavoriteIconButton(petId: widget.petId),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPropBox("Age", pet.age),
                        _buildPropBox("Sex", pet.gender),
                        _buildPropBox("Breed", pet.breed),
                      ],
                    ),
                    _summarySection(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
