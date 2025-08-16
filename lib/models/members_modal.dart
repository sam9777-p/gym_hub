import 'package:flutter/material.dart';
import '../colors.dart';
import '../utils/csv_parser.dart';

class MembersModal extends StatefulWidget {
  final VoidCallback onClose;

  const MembersModal({super.key, required this.onClose});

  @override
  State<MembersModal> createState() => _MembersModalState();
}

class _MembersModalState extends State<MembersModal> {
  String searchQuery = '';
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredMembers = CsvParser.getMembers().where((member) {
      final matchesSearch = member.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFilter = selectedFilter == 'All' || member.plan == selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '👥 Member Management',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onClose,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => setState(() => searchQuery = value),
                      decoration: const InputDecoration(
                        hintText: 'Search members...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: selectedFilter,
                    onChanged: (value) => setState(() => selectedFilter = value!),
                    items: ['All', 'Premium', 'Basic', 'VIP']
                        .map((filter) => DropdownMenuItem(
                      value: filter,
                      child: Text(filter),
                    ))
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: filteredMembers.length,
                  itemBuilder: (context, index) {
                    final member = filteredMembers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.royalFuchsia,
                          child: Text(
                            member.name[0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(member.name),
                        subtitle: Text('${member.plan} • Joined ${member.joinDate}'),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: member.status == 'Active' ? Colors.green : Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            member.status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
