import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn(scopes: scopes);

const gID =
    "207114108828-448fdu668k2sp54cdv482cg3clkrtlru.apps.googleusercontent.com";

const scopes = [
  SheetsApi.spreadsheetsScope,
  SheetsApi.driveScope,
  SheetsApi.driveFileScope
];

const double defaultPadding = 10.0;

ThemeData themeData() => ThemeData(
    primaryColor: Colors.blue,
    primarySwatch: Colors.purple,
    backgroundColor: Colors.blue.shade100,
    textTheme: GoogleFonts.robotoTextTheme());

const fields = [
  {
    'title': '月份',
    'field': 'month',
    'type': String,
    'visible': true,
  },
  // {
  //   'title': 'customer',
  //   'field': 'customer',
  //   'type': String,
  //   'visible': true,
  // },
  // {
  //   'title': 'hyManager',
  //   'field': 'hyManager',
  //   'type': String,
  //   'visible': true,
  // },
  // {
  //   'title': '經理',
  //   'field': 'nxManager',
  //   'type': String,
  //   'visible': true,
  // },
  // {
  //   'title': 'nxSupervisor',
  //   'field': 'nxSupervisor',
  //   'type': String,
  //'visible': true,
  // },
  {
    'title': '大廈編號',
    'field': 'bldgCode',
    'type': String,
    'visible': true,
  },
  {
    'title': '大廈名稱',
    'field': 'bldgName',
    'type': String,
    'visible': true,
  },
  {
    'title': '人頭',
    'field': 'headcount',
    'type': double,
    'visible': true,
  },
  {
    'title': '滅蟲',
    'field': 'pestcontrol',
    'type': double,
    'visible': true,
  },
  {
    'title': '大廈收入',
    'field': 'bldgIncome',
    'type': double,
    'visible': true,
  },
  {
    'title': '室內收入',
    'field': 'indoorIncome',
    'type': double,
    'visible': true,
  },
  {
    'title': '大廈額外',
    'field': 'bldgNonContractIncome',
    'type': double,
    'visible': true
  },
  {
    'title': '室內額外',
    'field': 'indoorNonContractIncome',
    'type': double,
    'visible': true
  },
  // {
  //   'title': 'packageCleaningIncome',
  //   'field': 'packageCleaningIncome',
  //   'type': double,
  //   'visible':true
  // },
  // {
  //   'title': 'debrisDisposalIncome',
  //   'field': 'debrisDisposalIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'carpetCleaningIncome',
  //   'field': 'carpetCleaningIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'casualIncome',
  //   'field': 'casualIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'liftpitIncome',
  //   'field': 'liftpitIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'wasteDisposalIncome',
  //   'field': 'wasteDisposalIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'externalWallIncome',
  //   'field': 'externalWallIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'carCleaningIncome',
  //   'field': 'carCleaningIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'materialSalesIncome',
  //   'field': 'materialSalesIncome',
  //   'type': double,
  // 'visible':true
  // },
  {
    'title': '合計收入',
    'field': 'totalIncome',
    'type': double,
    'visible': true,
  },
  {
    'title': '大廈支出',
    'field': 'bldgCost',
    'type': double,
    'visible': true,
  },
  {
    'title': '室內支出',
    'field': 'indoorCost',
    'type': double,
    'visible': true,
  },
  {
    'title': '大廈額外支出',
    'field': 'bldgNonContractCost',
    'type': double,
    'visible': true
  },
  {
    'title': '室內額外支出',
    'field': 'indoorNonContractCost',
    'type': double,
    'visible': true
  },
  // {
  //   'title': 'packageCleaningCost',
  //   'field': 'packageCleaningCost',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'debrisDisposalCost',
  //   'field': 'debrisDisposalCost',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'carpetCleaningCost',
  //   'field': 'carpetCleaningCost',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'liftpitCost',
  //   'field': 'liftpitCost',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'wasteDisposalCost',
  //   'field': 'wasteDisposalCost',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'externalwallCost',
  //   'field': 'externalwallCost',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'carCleaningCost',
  //   'field': 'carCleaningCost',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'materialsalesCost',
  //   'field': 'materialsalesCost',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': '用膳',
  //   'field': 'meal',
  //   'type': double,
  // 'visible':true
  // },

  // {
  //   'title': '租金',
  //   'field': 'rental',
  //   'type': double,
  //'visible':true
  // },
  // {
  //   'title': '水電',
  //   'field': 'waterElectric',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': '維修費',
  //   'field': 'R&M',
  //   'type': double,
  // 'visible':true
  // // },
  // {
  //   'title': '其它保險',
  //   'field': 'otherInsurance',
  //   'type': double,
  // 'visible':true
  // },

  {
    'title': '物料',
    'field': 'material',
    'type': double,
    'visible': true,
  },
  {
    'title': '機械維修',
    'field': 'machinedepreciation',
    'type': double,
    'visible': true,
  },

  {
    'title': '薪金',
    'field': 'salary',
    'type': double,
    'visible': true,
  },
  {
    'title': '散工費',
    'field': 'casualCost',
    'type': double,
    'visible': true,
  },
  {
    'title': '強積金',
    'field': 'calcMPF',
    'type': double,
    'visible': true,
  },
  {
    'title': '勞工保險',
    'field': 'laborInsurance',
    'type': double,
    'visible': false,
  },
  {
    'title': '第三保',
    'field': 'thirdpartyInsurance',
    'type': double,
    'visible': false
  },
  {
    'title': '員工福利',
    'field': 'staffBenefit',
    'type': double,
    'visible': true,
  },
  {
    'title': '醫療',
    'field': 'medical',
    'type': double,
    'visible': true,
  },
  {
    'title': '制服費',
    'field': 'uniform',
    'type': double,
    'visible': true,
  },
  {
    'title': '廣告費',
    'field': 'employmentAd',
    'type': double,
    'visible': true,
  },

  {
    'title': '應酬費',
    'field': 'entertainment',
    'type': double,
    'visible': true,
  },
  {
    'title': '什項費用',
    'field': 'calcMISC',
    'type': double,
    'visible': false,
  },
  {
    'title': '交通費',
    'field': 'trafficFees',
    'type': double,
    'visible': false,
  },
  {
    'title': '影印費',
    'field': 'photocopyingFees',
    'type': double,
    'visible': false
  },
  {
    'title': '牌照費',
    'field': 'licenseFees',
    'type': double,
    'visible': false,
  },
  {
    'title': '什項',
    'field': 'miscellaneous',
    'type': double,
    'visible': false,
  },
  {
    'title': '手提電話費',
    'field': 'mobilePhone',
    'type': double,
    'visible': false,
  },
  {
    'title': '文具',
    'field': 'printing&Stationery',
    'type': double,
    'visible': false
  },
  {
    'title': '郵費',
    'field': 'postage',
    'type': double,
    'visible': false,
  },
  // {
  //   'title': '電話費',
  //   'field': 'phone',
  //   'type': double,
  //   'visible':true
  // },
  // {
  //   'title': '公積金',
  //   'field': 'orso',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': '公積金回',
  //   'field': 'orsoReward',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': '強積金',
  //   'field': 'mpf',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': '強積金回',
  //   'field': 'mpfReward',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': '電腦維修',
  //   'field': 'computerRm',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': '培訓',
  //   'field': 'training',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': '專線費',
  //   'field': 'leasedline',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': '運輸費',
  //   'field': 'transportationFees',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': 'carfuel',
  //   'field': 'carfuel',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': 'carRm',
  //   'field': 'carRm',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': 'carParking',
  //   'field': 'carParking',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': 'carInsurance',
  //   'field': 'carInsurance',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': 'carmisc',
  //   'field': 'carmisc',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': 'margin',
  //   'field': 'margin',
  //   'type': double,
  //   'visible': true,
  // },
  // {
  //   'title': '車維修',
  //   'field': 'cardepreciation',
  //   'type': double,
  //   'visible': true,
  // },
  {
    'title': '巡區行政費',
    'field': 'calcAdminCost',
    'type': double,
    'visible': true,
  },

  {
    'title': '直接行政費',
    'field': 'officeDirectCost',
    'type': double,
    'visible': false,
  },
  {
    'title': '行政費',
    'field': 'adminCost',
    'type': double,
    'visible': false,
  },
  {
    'title': '稅',
    'field': 'tax',
    'type': double,
    'visible': false,
  },
  {
    'title': '總支出',
    'field': 'totalCost',
    'type': double,
    'visible': true,
  },
  {
    'title': '毛利',
    'field': 'profit',
    'type': double,
    'visible': true,
  },
];

const incomeFields = [
  {
    'title': '月份',
    'field': 'month',
    'type': String,
    'visible': true,
  },
  // {
  //   'title': 'customer',
  //   'field': 'customer',
  //   'type': String,
  //   'visible': true,
  // },
  // {
  //   'title': 'hyManager',
  //   'field': 'hyManager',
  //   'type': String,
  //   'visible': true,
  // },
  // {
  //   'title': '經理',
  //   'field': 'nxManager',
  //   'type': String,
  //   'visible': true,
  // },
  // {
  //   'title': 'nxSupervisor',
  //   'field': 'nxSupervisor',
  //   'type': String,
  //'visible': true,
  // },
  {
    'title': '大廈編號',
    'field': 'bldgCode',
    'type': String,
    'visible': true,
  },
  {
    'title': '大廈名稱',
    'field': 'bldgName',
    'type': String,
    'visible': true,
  },
  {
    'title': '人頭',
    'field': 'headcount',
    'type': double,
    'visible': true,
  },
  {
    'title': '滅蟲',
    'field': 'pestcontrol',
    'type': double,
    'visible': true,
  },
  {
    'title': '大廈收入',
    'field': 'bldgIncome',
    'type': double,
    'visible': true,
  },
  {
    'title': '室內收入',
    'field': 'indoorIncome',
    'type': double,
    'visible': true,
  },
  {
    'title': '大廈額外',
    'field': 'bldgNonContractIncome',
    'type': double,
    'visible': true
  },
  {
    'title': '室內額外',
    'field': 'indoorNonContractIncome',
    'type': double,
    'visible': true
  },
  // {
  //   'title': 'packageCleaningIncome',
  //   'field': 'packageCleaningIncome',
  //   'type': double,
  //   'visible':true
  // },
  // {
  //   'title': 'debrisDisposalIncome',
  //   'field': 'debrisDisposalIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'carpetCleaningIncome',
  //   'field': 'carpetCleaningIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'casualIncome',
  //   'field': 'casualIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'liftpitIncome',
  //   'field': 'liftpitIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'wasteDisposalIncome',
  //   'field': 'wasteDisposalIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'externalWallIncome',
  //   'field': 'externalWallIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'carCleaningIncome',
  //   'field': 'carCleaningIncome',
  //   'type': double,
  // 'visible':true
  // },
  // {
  //   'title': 'materialSalesIncome',
  //   'field': 'materialSalesIncome',
  //   'type': double,
  // 'visible':true
  // },
  {
    'title': '合計收入',
    'field': 'totalIncome',
    'type': double,
    'visible': true,
  }
];
