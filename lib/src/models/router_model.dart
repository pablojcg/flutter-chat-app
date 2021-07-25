
import 'package:flutter/material.dart';

final pageRoutes = <_Route>[
  _Route(Icons.person_outline_rounded, 'Contacts', 'contacts'),
  _Route(Icons.settings_outlined, 'Settings', 'settings'),
];

class _Route {
  
  final IconData icon; 
  final String title;
  final String route;

  _Route(this.icon, this.title, this.route);

}