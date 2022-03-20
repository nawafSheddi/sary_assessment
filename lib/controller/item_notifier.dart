// ignore_for_file: prefer_final_fields

import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ItemNotifier extends ChangeNotifier {
  List _itemsList = [];
  List _transactionsList = [];

  final Box box = Hive.box('ItemData');

  UnmodifiableListView get itemsList => UnmodifiableListView(box.get("itemList") ?? []);
  UnmodifiableListView get transactionsList => UnmodifiableListView(box.get("transactionsList") ?? []);

  List<String> names = ["Barbican Beer Drink", "Afia Corn Oil", "Pringles Barbeque Potato Chips", "Ava water"];
  addItem({
    required String name,
    required String price,
    required String sku,
    required String description,
  }) {
    incrementItemId();

    try {
      _itemsList = box.get("itemList");

      _itemsList.add(
        {
          "id": box.get("itemIds"),
          "name": name,
          "price": price,
          "sku": sku,
          "description": description,
          "image": "assets/Items_images/${names.contains(name) ? name : names[Random().nextInt(3)]}.png",
        },
      );

      box.put("itemList", _itemsList);
    } catch (e) {
      // if it's the first itme
      box.put("itemList", []);

      _itemsList.add(
        {
          "id": box.get("itemIds"),
          "name": name,
          "price": price,
          "sku": sku,
          "description": description,
          "image": "assets/Items_images/$name.png",
        },
      );
      box.put("itemList", _itemsList);
    }

    notifyListeners();
  }

  addTransactions({
    required bool isInbound,
    required int itemId,
    required int quantity,
    required String inbound_at,
    required String outbound_at,
  }) {
    incrementtransactionsIds();
    try {
      _transactionsList = box.get("transactionsList");
      _transactionsList.add({
        "id": box.get("transactionsIds"),
        "type": isInbound ? "inbound" : "outbound",
        "itemId": itemId,
        "quantity": quantity,
        "inbound_at": inbound_at,
        "outbound_at": outbound_at,
      });
      box.put("transactionsList", _transactionsList);
    } catch (e) {
      // if it's the first itme
      box.put("transactionsList", []);
      _transactionsList.add({
        "id": box.get("transactionsIds"),
        "type": isInbound ? "inbound" : "outbound",
        "itemId": itemId,
        "quantity": quantity,
        "inbound_at": inbound_at,
        "outbound_at": outbound_at,
      });
      box.put("transactionsList", _transactionsList);
    }
    notifyListeners();
  }

  deleteItem(id) {
    _itemsList = box.get("itemList");

    _itemsList.removeWhere((_item) => _item["id"] == id);

    box.put("itemList", _itemsList);
    notifyListeners();
  }

  incrementItemId() {
    try {
      // add to the counter 1
      box.put("itemIds", box.get("itemIds") + 1);
    } catch (e) {
      // if this is the 1 item so make it 1
      box.put("itemIds", 1);
    }
    notifyListeners();
  }

  incrementtransactionsIds() {
    try {
      // add to the counter 1
      box.put("transactionsIds", box.get("transactionsIds") + 1);
    } catch (e) {
      // if this is the 1 item so make it 1
      box.put("transactionsIds", 1);
    }
    notifyListeners();
  }

  getItemData(int itemId) {
    _itemsList = box.get("itemList");

    var index = _itemsList.indexWhere((item) => item["id"] == itemId);
    return _itemsList[index];
  }

  getTransactionsData(int transactionsId) {
    _transactionsList = box.get("transactionsList");

    var index = _transactionsList.indexWhere((transactions) => transactions["id"] == transactionsId);
    return _transactionsList[index];
  }

  searchFunction(String transactionsData) {
    _transactionsList = box.get("transactionsList") ?? [];

    if (_transactionsList.isNotEmpty) {
      // if they search for date
      if (transactionsData.contains("-") || transactionsData.contains("/")) {
        var searchResult = _transactionsList.where((transactions) {
          print("here1");
          if (transactions["type"] == "inbound") {
            print("i'm here");
            print(RegExp("[${transactions['inbound_at']}]").hasMatch(transactionsData));
            return RegExp("[${transactions['inbound_at']}]").hasMatch(transactionsData) ? transactions["inbound_at"] : {};
          } else {
            print("sorry");
            return transactions["outbound_at"].contains(transactions);
          }
        });
        // if they  search  for quantity
      } else if (!RegExp(r'[!@#<>?":_-`~;[\]\\|=+)(*&^%]').hasMatch(transactionsData) && RegExp("[0-9]").hasMatch(transactionsData) && !RegExp('[a-zA-Z]').hasMatch(transactionsData)) {
        var theQuantity = double.parse(transactionsData).toInt();

        var searchResult = _transactionsList.where((transactions) => transactions["quantity"] == theQuantity);

        return searchResult.toList();
      } else if (RegExp(r'[in]').hasMatch(transactionsData)) {
        var searchResult = _transactionsList.where((transactions) => transactions["type"] == "inbound");
        return searchResult.toList();
      } else if (RegExp(r'[out]').hasMatch(transactionsData)) {
        var searchResult = _transactionsList.where((transactions) => transactions["type"] == "outbound");
        return searchResult.toList();
      } else if (transactionsData == "") {
        return [];
      } else {
        return "no result";
      }
    } else {
      return [];
    }
  }

  sortByQuantity() {
    _transactionsList = box.get("transactionsList") ?? [];
    if (_transactionsList.isNotEmpty) {
      bool sorted = false;
      var temp;
      while (!sorted) {
        sorted = true;
        for (int i = 0; i < _transactionsList.length - 1; i++) {
          if (_transactionsList[i]["quantity"] < _transactionsList[i + 1]["quantity"]) {
            temp = _transactionsList[i];
            _transactionsList[i] = _transactionsList[i + 1];
            _transactionsList[i + 1] = temp;
            sorted = false;
          }
        }
      }
      notifyListeners();
    }
  }

  sortByType(String type) {
    _transactionsList = box.get("transactionsList") ?? [];
    if (_transactionsList.isNotEmpty) {
      bool sorted = false;
      var temp;
      while (!sorted) {
        sorted = true;
        for (int i = 0; i < _transactionsList.length; i++) {
          if (_transactionsList[i]["type"] == type) {
            for (int j = 0; j < _transactionsList.length - (_transactionsList.length - i); j++) {
              if (_transactionsList[j]["type"] != type) {
                temp = _transactionsList[j];
                _transactionsList[j] = _transactionsList[i];
                _transactionsList[i] = temp;
                sorted = false;
              }
            }
          }
        }
      }

      notifyListeners();
    }
  }

  sortByDate() {
    _transactionsList = box.get("transactionsList") ?? [];
    if (_transactionsList.isNotEmpty) {
      bool sorted = false;
      var temp;
      while (!sorted) {
        sorted = true;
        for (int i = 0; i < _transactionsList.length - 1; i++) {
          if (DateTime.parse(_transactionsList[i]["outbound_at"]).isAfter(DateTime.parse(_transactionsList[i + 1]["outbound_at"]))) {
            temp = _transactionsList[i];
            _transactionsList[i] = _transactionsList[i + 1];
            _transactionsList[i + 1] = temp;
            sorted = false;
          }
        }
      }
      notifyListeners();
    }
  }
}
