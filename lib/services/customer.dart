import 'package:cloud_firestore/cloud_firestore.dart';

class CustomersServices {
  final DocumentReference _divReference;
  static List<CustomerInfo> _customers = [];

  CustomersServices(this._divReference) {
    init();
  }

  Future<void> init() async {
    if (_customers.isEmpty) {
      await loadData();
    }
  }

  List<CustomerInfo>? get remarks => _customers;

  CustomerInfo getCustomer(String customerName, String chineseName) {
    var result =
        _customers.where((element) => element.customerName == customerName);
    if (result.isNotEmpty) {
      return result.first;
    } else {
      CustomerInfo customerInfo = CustomerInfo(customerName, chineseName);
      createCustomer(customerInfo);
      return customerInfo;
    }
  }

  Future<void> createCustomer(CustomerInfo customerInfo) async {
    _customers.add(customerInfo);
  }

  void setCustomer(String customerName, String rename) {
    var result =
        _customers.where((element) => element.customerName == customerName);
    if (result.isNotEmpty) {
      result.first.rename = rename;
    } else {
      if (rename.isNotEmpty) {
        createCustomer(CustomerInfo(customerName, rename));
      }
    }
  }

  Future<void> save() async => await customersInfoRef.set(_customers);

  Future<void> loadData() async {
    print('load customers from db');

    var value = await customersInfoRef.get();

    if (value.exists) {
      _customers = value.data() as List<CustomerInfo>;
    } else {
      _customers = [];
    }
  }

  DocumentReference get customersInfoRef => _divReference
      .collection('Aging')
      .doc('data')
      .withConverter<List<CustomerInfo>>(
          fromFirestore: (snapshot, _) =>
              (snapshot.data()!['customers'] as List)
                  .map((e) => CustomerInfo.fromJson(e))
                  .toList(),
          toFirestore: (obj, _) =>
              {'customers': obj.map((e) => e.toJson()).toList()});
}

class CustomerInfo {
  String customerName;
  String rename;

  CustomerInfo(this.customerName, this.rename);

  CustomerInfo.fromJson(Map<String, Object?> json)
      : this(
          json['customerName'] as String,
          json['rename'] as String,
        );

  Map<String, Object?> toJson() {
    return {'customerName': customerName, 'rename': rename};
  }
}
