import 'riv_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;
  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  
  NavItemModel(
    title: "Timer",
    rive: RiveModel(
      src: "assets/icons/animated_icon.riv", 
      artboard: "TIMER", 
      stateMachine:
          "TIMER_Interactivity", 
    ),
  ),
  NavItemModel(
    title: "Search",
    rive: RiveModel(
      src: "assets/icons/animated_icon.riv",
      artboard: "SEARCH",
      stateMachine: "SEARCH_Interactivity",
    ),
  ),
  
  NavItemModel(
    title: "Settings",
    rive: RiveModel(
      src: "assets/icons/animated_icon.riv",
      artboard: "SETTINGS",
      stateMachine: "SETTINGS_Interactivity",
    ),
  ),
  NavItemModel(
    title: "Profile",
    rive: RiveModel(
      src: "assets/icons/animated_icon.riv",
      artboard: "USER",
      stateMachine: "USER_Interactivity",
    ),
  ),
  
];
