import 'package:farmx/Constants/Constants.dart';
import 'package:flutter/material.dart';

final List<Map<dynamic, dynamic>> listOfConditions = [
  {
    "Name": "Chinsurah Rice (IET 19140)",
    "Number": "irrigated conditions",
  },
  {
    "Name": "CNI 383-5-11",
    "Number": "both irrigated and rainfed conditions",
  },
  {
    "Name": "IGKVR-1 (IET 19569)",
    "Number":
        "irrigated late sown conditions as well as shallow rainfed lowland",
  },
  {
    "Name": "CR Dhan 401 (REETA)",
    "Number": "Boro Area",
  },
  {
    "Name": "CR Dhan 601 (IET 18558)",
    "Number": "Semi deep water condition",
  },
  {
    "Name": "CR Dhan 501 (IET 19189)",
    "Number": "Terraced area under irrigated and rainfed condition"
  },
  {
    "Name": "RC Maniphou 11 (IET 20193)",
    "Number": "timely sown irrigated condition",
  },
  {
    "Name": "MPO(JW)  1215 (MPO 1215)",
    "Number": "under timely sown irrigated condition",
  },
  {
    "Name": "MACS 6222",
    "Number": "under timely sown irrigated conditions",
  },
  {
    "Name": "PDW 314",
    "Number": "under timely sown irrigated condition",
  },
  {
    "Name": "DBW39",
    "Number": "under timely sown irrigated conditions",
  },
  {
    "Name": "VL Gehun 907 (VL 907)",
    "Number": "under timely sown rainfed condition in lower and mid hills",
  },
  {
    "Name": "Pusa Suketi  HS 507",
    "Number": "in late sown condition",
  },
  {
    "Name": "Pusa Prachi (HI 1563)",
    "Number": "except Kota and Udaipur divisions , Jhansi Divisions",
  },
  {
    "Name": "WHD 943",
    "Number": "under rainfed condition and restricted irrigated condition",
  },
  {
    "Name": "Netravati  (NIAW 1415)",
    "Number": "under timely sown irrigated conditions",
  },
  {
    "Name": "BH-902",
    "Number": "under irrigated late sown condition",
  },
  {
    "Name": "DWRB 73",
    "Number": "under timely sown rainfed conditions",
  },
  {
    "Name": "Pusa Losar  (BH- 380)",
    "Number": "under Kharif season",
  },
  {
    "Name": "HSC1",
    "Number": "under Kharif Season",
  },
  {
    "Name": "HQPM-4",
    "Number": "under irrigated and rainfed conditions",
  },
  {"Name": "MCH 36 (Hybrid) (DKC 9099)", "Number": "in Kharif season"},
  {"Name": "DHM 119 (BH 4062)", "Number": "under irrigated condition"},
  {
    "Name": "PMH 4 (JH 31153)",
    "Number": "in Kharif season under both irrigated and rainfed condition"
  },
  {"Name": "PMH 5 (JH 3110)", "Number": "in Kharif season"},
  {"Name": "Nandi-65 (MH-1549)", "Number": "in Kharif season"},
  {"Name": "Nandi-61 (MH-1548)", "Number": "in summer season"},
  {"Name": "86M64 (MSH 203) (Hybrid)", "Number": "under normal Kharif season"},
  {"Name": "MH 1540 (86M64) (Hybrid)", "Number": "under normal Kharif season"},
  {
    "Name": "MH 1541 (86M53) (Hybrid)",
    "Number": "under rainfed low fertility condition"
  },
  {"Name": "RHB 177 (MH 1486)", "Number": "no special condition"},
  {"Name": "HHB 226  (MH 1479)", "Number": "in Kharif  season"},
  {"Name": "GPU 67", "Number": "under timely sown irrigated condition"},
  {"Name": "DRMR 601 (NRCDR 601)", "Number": "in multiple cropping systems"},
  {
    "Name": "Pusa Mustard 26 (NPJ-113)",
    "Number": "in multiple cropping systems"
  },
  {
    "Name": "Pusa Mustard 27 (EJ-17)",
    "Number": "under timely sown irrigated condition"
  },
  {"Name": "CORAL 432 (PAC 432)(Hybrid)", "Number": "no special condition"},
  {"Name": "Pitambari (RYSK-05-02)", "Number": "under rainfed condition"},
  {
    "Name": "JLS-67 (Shival)",
    "Number": "under timely sown irrigated condition"
  },
  {
    "Name": "Ruchi (LCK 5021)",
    "Number": "in Rabi season under irrigated condition"
  },
  {"Name": "JLS-73 (SLS-73)", "Number": "under Kharif rainfed condition"},
  {
    "Name": "Girnar - 3 (PBS 12160)",
    "Number": "under timely sown irrigated condition in Rabi and Summer season"
  },
  {"Name": "Kadiri Harithandhra (K 1319)", "Number": "in Kharif Season"},
  {"Name": "GPBD 5", "Number": "under irrigated conditions during Rabi Season"},
  {
    "Name": "Rajasthan Till 351 (RT 351)",
    "Number": "under irrigated conditions"
  },
  {
    "Name": "Ujjawal (IPCK2004-29)",
    "Number": "in normal sown rainfed as well as irrigated condition"
  },
  {"Name": "PKV KABULI-4", "Number": "in Rabi season"},
  {"Name": "MNK-1", "Number": "under in Rabi season"},
  {"Name": "Pant Lentil-8(Pant L-063)", "Number": "during Rabi season"},
  {
    "Name": "Pant Lentil-7(Pant L-024)",
    "Number": "under normal sown Rabi season as pure crop"
  },
  {"Name": "Aman  (IPF 5-19)", "Number": "in Rabi season"},
  {"Name": "GOMATI (TRCP-8)", "Number": "no special condition"},
  {"Name": "Dantiwada Fieldpea 1 (SKNP 04-09)", "Number": "in Kharif season"},
  {"Name": "Gujarat Rajmash-1 (DPR 88-1-2)", "Number": "in Kharif season"},
  {"Name": "PKV AKM-4 (AKM-9904)", "Number": "in summer season"},
  {
    "Name": "Mash 479 (KUG 479)",
    "Number": "under timely sowing, normal fertility and rainfed conditions"
  },
  {
    "Name": "Mash 391 (LU 391)",
    "Number":
        """timely sowing, normal fertility and rainfed conditions for North India and
    South India under rainfed conditions"""
  },
  {"Name": "HG 884", "Number": "no special condition"},
  {"Name": "HG 2-20", "Number": "no special condition"},
  {"Name": "CRIDALATHA (CRHG-4)", "Number": "no special condition"},
  {"Name": "Karan 6 (Co 0239)", "Number": "under irrigated conditions"},
  {
    "Name": "Karan 5 (Co 0124)",
    "Number":
        "single cut system under both normal and salt affected soil in Rabi Season"
  },
  {
    "Name": "Co-0218",
    "Number":
        "under timely sown irrigated condition suitable for single cut system"
  },
  {"Name": "Phule Jaywant (RBN-13)", "Number": "no special condition"},
  {
    "Name": "Narendra Jayee -1 (NDO - 1)",
    "Number":
        "temperate and sub-temperate grasslands and pastures of hill zone of the country comprising states"
  },
  {"Name": "OS 346", "Number": "in irrigated summer and rainfed Kharif"},
  {"Name": "JO 03-91 (SC)", "Number": "no special condition"},
  {"Name": "EC 178182", "Number": "no special condition"},
  {"Name": "UPC 628", "Number": "n irrigated summer and rainfed Kharif"},
  {"Name": "SUDHANGSU (JBO-1)", "Number": "no special condition"},
  {"Name": "ARPITA  (JBC-5)", "Number": "under rainfed agro system"},
  {"Name": "SNEHA  (JRM-3)", "Number": "under rainfed conditions"},
  {"Name": "SHRESTHA (JRM-5)", "Number": "under rainfed conditions"},
  {"Name": "CNH012", "Number": "no special condition"},
  {"Name": "CICR-3 (CISA 614)", "Number": "under wilt free area"},
  {"Name": "VBCH 2231", "Number": "under rainfed conditions"},
  {"Name": "FDK 124", "Number": "under irrigated condition"},
];

class TableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text('Check Your Condition'),
          backgroundColor: kBlack,
        ),
        body: SingleChildScrollView(
          child: DataTable(
            dataRowHeight: 60,
            columns: [
              DataColumn(
                  label: Text(
                'Variety',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                'Condition',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
            ],
            rows: listOfConditions
                .map(
                  ((element) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(element["Name"])),
                          DataCell(Text(element["Number"])),
                        ],
                      )),
                )
                .toList(),
          ),
        ));
  }
}
