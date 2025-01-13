import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ----------------- THEME NOIR OU BLANC -----------------
class ThemeNotifier extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

final ThemeNotifier themeNotifier = ThemeNotifier();

// ----------------- APPLI -----------------
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeNotifier,
      builder: (context, _) {
        return MaterialApp(
          title: 'System on Sheep',
          theme: ThemeData(
            colorScheme: themeNotifier.isDarkMode
                ? ColorScheme.dark()
                : ColorScheme.light(),
            useMaterial3: true,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}

// ----------------- HOME PAGE -----------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CollarsInfoScreen(),
    const PairCollarScreen(),
    const RemoveCollarScreen(),
    const AccountScreen(),
    const SettingsScreen(),
  ];

  final List<String> _pageTitles = [
    "Carte",
    "Infos colliers",
    "Appairer collier",
    "Retirer collier",
    "Compte",
    "Paramètres"
  ];

  bool _isSheepPanelOpen = false;

  void _onSelectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Ferme le Drawer après sélection
  }

  void _toggleSheepPanel() {
    setState(() {
      _isSheepPanelOpen = !_isSheepPanelOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            // Bandeau Bleu avec Icône Centrée
            Container(
              height: 40,
              color: Colors.blue,
              child: Center(
                child: Image.asset(
                  'assets/icon/icon1.png',
                  height: 35,
                ),
              ),
            ),
            AppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              title: Text(_pageTitles[_selectedIndex]),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const NotificationPanel(),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: _toggleSheepPanel,
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: Text(_pageTitles[0]),
              onTap: () => _onSelectPage(0),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(_pageTitles[1]),
              onTap: () => _onSelectPage(1),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: Text(_pageTitles[2]),
              onTap: () => _onSelectPage(2),
            ),
            ListTile(
              leading: const Icon(Icons.remove),
              title: Text(_pageTitles[3]),
              onTap: () => _onSelectPage(3),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(_pageTitles[4]),
              onTap: () => _onSelectPage(4),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(_pageTitles[5]),
              onTap: () => _onSelectPage(5),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // Contenu principal
          Expanded(
            child: _pages[_selectedIndex],
          ),
          // Liste des brebis avec collier actif (exemple pas encore implemente l'api et recuperation de nos colliers gps) 
          if (_isSheepPanelOpen)
            Container(
              width: 250,
              color: Colors.lightBlue[200],
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Brebis Actives',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.pets),
                          title: Text('Bubulle'),
                        ),
                        ListTile(
                          leading: Icon(Icons.pets),
                          title: Text('Bebert'),
                        ),
                        ListTile(
                          leading: Icon(Icons.pets),
                          title: Text('Meschoui'),
                        ),
                        ListTile(
                          leading: Icon(Icons.pets),
                          title: Text('Kebab'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ----------------- ÉCRANS -----------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Carte interactive avec les positions des brebis.'),
    );
  }
}

class CollarsInfoScreen extends StatelessWidget {
  const CollarsInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Informations des colliers.'));
  }
}

class PairCollarScreen extends StatelessWidget {
  const PairCollarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Appairer un collier.'));
  }
}

class RemoveCollarScreen extends StatelessWidget {
  const RemoveCollarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Retirer un collier.'));
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Compte utilisateur.'));
  }
}

// ----------------- PARAMÈTRES -----------------
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String notificationFrequency = 'Toutes les heures';
  String mapType = 'Standard';
  String mode = 'Éco';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Mode sombre'),
            value: themeNotifier.isDarkMode,
            onChanged: (value) {
              setState(() {
                themeNotifier.toggleTheme();
              });
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Fréquence des notifications'),
            trailing: DropdownButton<String>(
              value: notificationFrequency,
              items: [
                DropdownMenuItem(value: 'Toutes les heures', child: Text('Toutes les heures')),
                DropdownMenuItem(value: 'Toutes les 15 minutes', child: Text('Toutes les 15 minutes')),
                DropdownMenuItem(value: 'Désactivées', child: Text('Désactivées')),
              ],
              onChanged: (value) {
                setState(() {
                  notificationFrequency = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Type de carte'),
            trailing: DropdownButton<String>(
              value: mapType,
              items: [
                DropdownMenuItem(value: 'Standard', child: Text('Standard')),
                DropdownMenuItem(value: 'Satellite', child: Text('Satellite')),
                DropdownMenuItem(value: 'Hybride', child: Text('Hybride')),
              ],
              onChanged: (value) {
                setState(() {
                  mapType = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Mode de fonctionnement'),
            trailing: DropdownButton<String>(
              value: mode,
              items: [
                DropdownMenuItem(value: 'Éco', child: Text('Mode Éco')),
                DropdownMenuItem(value: 'Actif', child: Text('Mode Actif')),
              ],
              onChanged: (value) {
                setState(() {
                  mode = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------- NOTIFICATIONS ----------------- (exemple pour l'instant aussi)
class NotificationPanel extends StatelessWidget {
  const NotificationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.notification_important),
            title: Text('12/06 - Bubulle en fuite'),
          ),
          ListTile(
            leading: Icon(Icons.battery_alert),
            title: Text('11/06 - Batterie faible'),
          ),
        ],
      ),
    );
  }
}
