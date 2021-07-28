class CostingRow {
  final String month;
  final String customer;
  final String hyManager;
  final String nxManager;
  final String nxSupervisor;
  final String bldgCode;
  final String bldgName;
  final double headcount;
  final double bldgIncome;
  final double pestcontrol;
  final double indoorIncome;
  final double bldgNonContractIncome;
  final double indoorNonContractIncome;
  final double packageCleaningIncome;
  final double debrisDisposalIncome;
  final double carpetCleaningIncome;
  final double casualIncome;
  final double liftpitIncome;
  final double wasteDisposalIncome;
  final double externalWallIncome;
  final double carCleaningIncome;
  final double materialSalesIncome;
  final double totalIncome;
  final double bldgCost;
  final double indoorCost;
  final double bldgNonContractCost;
  final double indoorNonContractCost;
  final double packageCleaningCost;
  final double debrisDisposalCost;
  final double carpetCleaningCost;
  final double liftpitCost;
  final double wasteDisposalCost;
  final double externalwallCost;
  final double carCleaningCost;
  final double materialsalesCost;
  final double meal;
  final double staffBenefit;
  final double medical;
  final double uniform;
  final double employmentAd;
  final double rental;
  final double waterElectric;
  final double rM;
  final double otherInsurance;
  final double laborInsurance;
  final double thirdpartyInsurance;
  final double prdoubleingAndStationery;
  final double postage;
  final double phone;
  final double entertainment;
  final double trafficFees;
  final double photocopyingFees;
  final double computerRm;
  final double licenseFees;
  final double miscellaneous;
  final double mobilePhone;
  final double training;
  final double leasedline;
  final double transportationFees;
  final double carfuel;
  final double carRm;
  final double carParking;
  final double carInsurance;
  final double carmisc;
  final double margin;
  final double cardepreciation;
  final double machinedepreciation;
  final double material;
  final double salary;
  final double casualCost;
  final double orso;
  final double orsoReward;
  final double mpf;
  final double mpfReward;
  final double officeDirectCost;
  final double adminCost;
  final double tax;
  final double totalCost;
  final double profit;

  CostingRow(
      this.month,
      this.customer,
      this.hyManager,
      this.nxManager,
      this.nxSupervisor,
      this.bldgCode,
      this.bldgName,
      this.headcount,
      this.bldgIncome,
      this.pestcontrol,
      this.indoorIncome,
      this.bldgNonContractIncome,
      this.indoorNonContractIncome,
      this.packageCleaningIncome,
      this.debrisDisposalIncome,
      this.carpetCleaningIncome,
      this.casualIncome,
      this.liftpitIncome,
      this.wasteDisposalIncome,
      this.externalWallIncome,
      this.carCleaningIncome,
      this.materialSalesIncome,
      this.totalIncome,
      this.bldgCost,
      this.indoorCost,
      this.bldgNonContractCost,
      this.indoorNonContractCost,
      this.packageCleaningCost,
      this.debrisDisposalCost,
      this.carpetCleaningCost,
      this.liftpitCost,
      this.wasteDisposalCost,
      this.externalwallCost,
      this.carCleaningCost,
      this.materialsalesCost,
      this.meal,
      this.staffBenefit,
      this.medical,
      this.uniform,
      this.employmentAd,
      this.rental,
      this.waterElectric,
      this.rM,
      this.otherInsurance,
      this.laborInsurance,
      this.thirdpartyInsurance,
      this.prdoubleingAndStationery,
      this.postage,
      this.phone,
      this.entertainment,
      this.trafficFees,
      this.photocopyingFees,
      this.computerRm,
      this.licenseFees,
      this.miscellaneous,
      this.mobilePhone,
      this.training,
      this.leasedline,
      this.transportationFees,
      this.carfuel,
      this.carRm,
      this.carParking,
      this.carInsurance,
      this.carmisc,
      this.margin,
      this.cardepreciation,
      this.machinedepreciation,
      this.material,
      this.salary,
      this.casualCost,
      this.orso,
      this.orsoReward,
      this.mpf,
      this.mpfReward,
      this.officeDirectCost,
      this.adminCost,
      this.tax,
      this.totalCost,
      this.profit);

  CostingRow.fromArray(List d)
      : this(
          d[0] as String,
          d[1] == null ? "" : d[1] as String,
          d[2] == null ? "" : d[2] as String,
          d[3] == null ? "" : d[3] as String,
          d[4] == null ? "" : d[4] as String,
          d[5] == null ? "" : d[5] as String,
          d[6] == null ? "" : d[6] as String,
          double.parse(d[7] ?? "0.0"),
          double.parse(d[8] ?? "0.0"),
          double.parse(d[9] ?? "0.0"),
          double.parse(d[10] ?? "0.0"),
          double.parse(d[11] ?? "0.0"),
          double.parse(d[12] ?? "0.0"),
          double.parse(d[13] ?? "0.0"),
          double.parse(d[14] ?? "0.0"),
          double.parse(d[15] ?? "0.0"),
          double.parse(d[16] ?? "0.0"),
          double.parse(d[17] ?? "0.0"),
          double.parse(d[18] ?? "0.0"),
          double.parse(d[19] ?? "0.0"),
          double.parse(d[20] ?? "0.0"),
          double.parse(d[21] ?? "0.0"),
          double.parse(d[22] ?? "0.0"),
          double.parse(d[23] ?? "0.0"),
          double.parse(d[24] ?? "0.0"),
          double.parse(d[25] ?? "0.0"),
          double.parse(d[26] ?? "0.0"),
          double.parse(d[27] ?? "0.0"),
          double.parse(d[28] ?? "0.0"),
          double.parse(d[29] ?? "0.0"),
          double.parse(d[30] ?? "0.0"),
          double.parse(d[31] ?? "0.0"),
          double.parse(d[32] ?? "0.0"),
          double.parse(d[33] ?? "0.0"),
          double.parse(d[34] ?? "0.0"),
          double.parse(d[35] ?? "0.0"),
          double.parse(d[36] ?? "0.0"),
          double.parse(d[37] ?? "0.0"),
          double.parse(d[38] ?? "0.0"),
          double.parse(d[39] ?? "0.0"),
          double.parse(d[40] ?? "0.0"),
          double.parse(d[41] ?? "0.0"),
          double.parse(d[42] ?? "0.0"),
          double.parse(d[43] ?? "0.0"),
          double.parse(d[44] ?? "0.0"),
          double.parse(d[45] ?? "0.0"),
          double.parse(d[46] ?? "0.0"),
          double.parse(d[47] ?? "0.0"),
          double.parse(d[48] ?? "0.0"),
          double.parse(d[49] ?? "0.0"),
          double.parse(d[50] ?? "0.0"),
          double.parse(d[51] ?? "0.0"),
          double.parse(d[52] ?? "0.0"),
          double.parse(d[53] ?? "0.0"),
          double.parse(d[54] ?? "0.0"),
          double.parse(d[55] ?? "0.0"),
          double.parse(d[56] ?? "0.0"),
          double.parse(d[57] ?? "0.0"),
          double.parse(d[58] ?? "0.0"),
          double.parse(d[59] ?? "0.0"),
          double.parse(d[60] ?? "0.0"),
          double.parse(d[61] ?? "0.0"),
          double.parse(d[62] ?? "0.0"),
          double.parse(d[63] ?? "0.0"),
          double.parse(d[64] ?? "0.0"),
          double.parse(d[65] ?? "0.0"),
          double.parse(d[66] ?? "0.0"),
          double.parse(d[67] ?? "0.0"),
          double.parse(d[68] ?? "0.0"),
          double.parse(d[69] ?? "0.0"),
          double.parse(d[70] ?? "0.0"),
          double.parse(d[71] ?? "0.0"),
          double.parse(d[72] ?? "0.0"),
          double.parse(d[73] ?? "0.0"),
          double.parse(d[74] ?? "0.0"),
          double.parse(d[75] ?? "0.0"),
          double.parse(d[76] ?? "0.0"),
          double.parse(d[77] ?? "0.0"),
          double.parse(d[78] ?? "0.0"),
        );
}
