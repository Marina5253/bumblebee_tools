import 'package:flutter/material.dart';

class RootDrawer extends StatefulWidget {
  final int selectedIndex;
  const RootDrawer({super.key, required this.selectedIndex});

  @override
  State<RootDrawer> createState() => _RootDrawerState();
}

class _RootDrawerState extends State<RootDrawer> {

  void onItemTapped(int index, String name) {
    setState(() {
      Navigator.of(context).pushNamed(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: const Row(children: [
              SizedBox(
                  width: 90,
                  child: Image(image: AssetImage('assets/bee.webp'))),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Center(
                  child: Text('BumbleBee Tools',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ]),
          ),
          ListTile(
            title: const Text('TO DOs'),
            selected: widget.selectedIndex == 0,
            selectedColor: Theme.of(context).colorScheme.tertiary,
            textColor: Theme.of(context).colorScheme.onSecondary,
            onTap: () {
              onItemTapped(0,'/');
            },
          ),
          ListTile(
            title: const Text('Weather'),
            selected: widget.selectedIndex == 1,
            selectedColor: Theme.of(context).colorScheme.tertiary,
            textColor: Theme.of(context).colorScheme.onSecondary,
            onTap: () {
              onItemTapped(1,'/weather');
            },
          ),
        ],
      ),
    );
  }
}
