//
// import 'package:flutter/foundation.dart';
// import 'package:provider_mvvm/data/models/movies_list_model.dart';
//
// class SelectedItemProvider extends ChangeNotifier {
//   Movies? _selectedItem;
//
//   Movies? get selectedItem => _selectedItem;
//
//   void selectItem(Movies item) {
//     _selectedItem = item;
//     notifyListeners();
//   }
// }
//
// class ItemListModel extends ChangeNotifier {
//   int _selectedIndex = -1;
//   // List<Movies> _items = [
//   //   Item('Item 1', 'Details of Item 1'),
//   //   Item('Item 2', 'Details of Item 2'),
//   //   Item('Item 3', 'Details of Item 3'),
//   // ];
//   // List<Movies> get items => _items;
//
//   // Movies? _selectedItem;
//   int get selectedIndex => _selectedIndex;
//
//   set selectedIndex(int index) {
//     _selectedIndex = index;
//     notifyListeners();
//   }
// }
