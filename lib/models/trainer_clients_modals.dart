import 'package:flutter/material.dart';
import '../data/colors.dart';
import '../data/sample_data.dart';
import '../widgets/custom_widgets.dart';

class TrainerClientsModal extends StatefulWidget {
  final VoidCallback onClose;

  const TrainerClientsModal({super.key, required this.onClose});

  @override
  State<TrainerClientsModal> createState() => _TrainerClientsModalState();
}

class _TrainerClientsModalState extends State<TrainerClientsModal> {
  String clientFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final filteredClients = SampleData.trainerClients.where((client) {
      if (clientFilter == 'all') return true;
      return client.status == clientFilter;
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
                          '👥 My Clients',
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
                    _buildFilterChip('all', 'All', SampleData.trainerClients.length),
                    _buildFilterChip('active', 'Active', SampleData.trainerClients.where((c) => c.status == 'active').length),
                    _buildFilterChip('expiring', 'Expiring', SampleData.trainerClients.where((c) => c.status == 'expiring').length),
                    _buildFilterChip('expired', 'Expired', SampleData.trainerClients.where((c) => c.status == 'expired').length),
                    _buildFilterChip('retained', 'Retained', SampleData.trainerClients.where((c) => c.status == 'retained').length),
                  ],
                ),
              ),
              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: filteredClients.map((client) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.neutral,
                          borderRadius: BorderRadius.circular(12),
                          border: Border(
                            left: BorderSide(color: _getStatusColor(client.status), width: 4),
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
                                    client.name.split(' ').map((n) => n[0]).join(''),
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
                                        client.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        client.plan,
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
                                    Text(_getStatusIcon(client.status)),
                                    const SizedBox(width: 4),
                                    StatusBadge(
                                      text: client.status.toUpperCase(),
                                      backgroundColor: _getStatusColor(client.status),
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
                                        '₹${client.monthlyFee}',
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
                                        'Total Sessions:',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        '${client.totalSessions}',
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
                                        'Last Session:',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        client.lastSession,
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
    final isSelected = clientFilter == key;
    return GestureDetector(
      onTap: () => setState(() => clientFilter = key),
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