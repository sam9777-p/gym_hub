import 'package:flutter/material.dart';
import '../data/colors.dart';
import '../data/sample_data.dart';
import '../widgets/custom_widgets.dart';

class MembersModal extends StatefulWidget {
  final VoidCallback onClose;

  const MembersModal({super.key, required this.onClose});

  @override
  State<MembersModal> createState() => _MembersModalState();
}

class _MembersModalState extends State<MembersModal> {
  String memberFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final filteredMembers = SampleData.membersData.where((member) {
      if (memberFilter == 'all') return true;
      return member.status == memberFilter;
    }).toList();

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxHeight: 600),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.people, color: AppColors.royalFuchsia),
                        SizedBox(width: 8),
                        Text(
                          '👥 Member Management',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: widget.onClose,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              // Filters
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Wrap(
                  spacing: 8,
                  children: [
                    _buildFilterChip('all', 'All', SampleData.membersData.length),
                    _buildFilterChip('active', 'Active', SampleData.membersData.where((m) => m.status == 'active').length),
                    _buildFilterChip('expiring', 'Expiring', SampleData.membersData.where((m) => m.status == 'expiring').length),
                    _buildFilterChip('expired', 'Expired', SampleData.membersData.where((m) => m.status == 'expired').length),
                    _buildFilterChip('retained', 'Retained', SampleData.membersData.where((m) => m.status == 'retained').length),
                  ],
                ),
              ),
              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: filteredMembers.map((member) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.neutral,
                          borderRadius: BorderRadius.circular(12),
                          border: Border(
                            left: BorderSide(color: _getStatusColor(member.status), width: 4),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.mediumVioletRed,
                                  radius: 16,
                                  child: Text(
                                    member.name.split(' ').map((n) => n[0]).join(''),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        member.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${member.plan} Plan',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(_getStatusIcon(member.status)),
                                    const SizedBox(width: 4),
                                    StatusBadge(
                                      text: member.status.toUpperCase(),
                                      backgroundColor: _getStatusColor(member.status),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Monthly Fee:',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        '₹${member.monthlyFee}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.deepViolet,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Visits:',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        '${member.totalVisits}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.deepViolet,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Last Visit:',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        member.lastVisit,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String key, String label, int count) {
    final isSelected = memberFilter == key;
    return GestureDetector(
      onTap: () => setState(() => memberFilter = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.deepViolet : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.deepViolet),
        ),
        child: Text(
          '$label ($count)',
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : AppColors.deepViolet,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return AppColors.positive;
      case 'expiring':
        return AppColors.warning;
      case 'expired':
        return AppColors.alert;
      case 'retained':
        return AppColors.mediumVioletRed;
      default:
        return AppColors.deepViolet;
    }
  }

  String _getStatusIcon(String status) {
    switch (status) {
      case 'active':
        return '✅';
      case 'expiring':
        return '⚠️';
      case 'expired':
        return '❌';
      case 'retained':
        return '🔄';
      default:
        return '👤';
    }
  }
}