import 'package:flutter/material.dart';

class CameraManagementScreen extends StatefulWidget {
  const CameraManagementScreen({super.key});

  @override
  State<CameraManagementScreen> createState() => _CameraManagementScreenState();
}

class _CameraManagementScreenState extends State<CameraManagementScreen> {
  late CameraDataSource _dataSource;
  int _rowsPerPage = 10;
  final List<int> _rowsPerPageOptions = [10, 20, 50, 100, 200];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataSource = CameraDataSource(context);
  }

  int get motionDetectedCount {
    return _dataSource._data
        .where((row) => row[3].toLowerCase() == 'motion detected')
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FA),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Camera Management',
              style: TextStyle(
                fontSize: 26,
                color: Colors.teal.shade900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Events Detected: $motionDetectedCount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 200.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search, size: 16),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 52),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _dataSource.filter(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Add Device',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.teal[600],
                      onPressed: () {
                        // Add camera logic here
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: PaginatedDataTable(
                            header: null,
                            rowsPerPage: _rowsPerPage,
                            availableRowsPerPage: _rowsPerPageOptions,
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                _rowsPerPage = value!;
                              });
                            },
                            headingRowColor: MaterialStateProperty.all(
                              Colors.teal[600],
                            ),
                            columns: const [
                              DataColumn(label: Text('Device ID', style: TextStyle(color: Colors.white, fontSize: 18))),
                              DataColumn(label: Text('Device Type', style: TextStyle(color: Colors.white, fontSize: 18))),
                              DataColumn(label: Text('Location', style: TextStyle(color: Colors.white, fontSize: 18))),
                              DataColumn(label: Text('Events', style: TextStyle(color: Colors.white, fontSize: 18))),
                              DataColumn(label: Text('Actions', style: TextStyle(color: Colors.white, fontSize: 18))),
                            ],
                            source: _dataSource,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CameraDataSource extends DataTableSource {
  final List<List<String>> _allData = List.generate(
    200,
        (index) => [
      'CAM_${index + 1}',
      'CCTV',
      'Platform ${index % 5 + 1} Entrance',
      'Motion Detected'
    ],
  );

  List<List<String>> _filteredData = [];
  final BuildContext context;

  CameraDataSource(this.context) {
    _filteredData = List.from(_allData);
  }

  void filter(String query) {
    if (query.isEmpty) {
      _filteredData = List.from(_allData);
    } else {
      _filteredData = _allData
          .where((row) => row.any((cell) => cell.toLowerCase().contains(query.toLowerCase())))
          .toList();
    }
    notifyListeners();
  }

  List<List<String>> get _data => _filteredData;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final row = _data[index];

    return DataRow(
      cells: [
        ...row.map((cell) => DataCell(Text(cell))),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  // Handle edit logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit functionality not implemented')),
                  );
                },
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content: const Text('Are you sure you want to delete this camera?'),
                        actions: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.of(dialogContext).pop(),
                          ),
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              _filteredData.removeAt(index);
                              notifyListeners();
                              Navigator.of(dialogContext).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
