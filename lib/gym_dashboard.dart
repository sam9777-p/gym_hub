import 'package:flutter/material.dart';
import 'data/colors.dart';
import 'screens/member_dashboard.dart';
import 'screens/trainer_dashboard.dart';
import 'screens/owner_dashboard.dart';

enum UserRole { member, trainer, owner }

class GymDashboard extends StatefulWidget {
  const GymDashboard({super.key});

  @override
  State<GymDashboard> createState() => _GymDashboardState();
}

class _GymDashboardState extends State<GymDashboard> {
  UserRole currentRole = UserRole.member;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Role Switcher
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => currentRole = UserRole.member),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          gradient: currentRole == UserRole.member
                              ? AppColors.primaryGradient
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fitness_center,
                              size: 16,
                              color: currentRole == UserRole.member
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                            Text(
                              '💪 Member',
                              style: TextStyle(
                                fontSize: 10,
                                color: currentRole == UserRole.member
                                    ? Colors.white
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => currentRole = UserRole.trainer),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          gradient: currentRole == UserRole.trainer
                              ? AppColors.trainerGradient
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: currentRole == UserRole.trainer
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                            Text(
                              '👨‍🏫 Trainer',
                              style: TextStyle(
                                fontSize: 10,
                                color: currentRole == UserRole.trainer
                                    ? Colors.white
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => currentRole = UserRole.owner),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          gradient: currentRole == UserRole.owner
                              ? AppColors.ownerGradient
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.trending_up,
                              size: 16,
                              color: currentRole == UserRole.owner
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                            Text(
                              '🏢 Owner',
                              style: TextStyle(
                                fontSize: 10,
                                color: currentRole == UserRole.owner
                                    ? Colors.white
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Dashboard Content
          Expanded(
            child: _buildDashboard(),
          ),
          // Bottom Navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    switch (currentRole) {
      case UserRole.member:
        return const MemberDashboard();
      case UserRole.trainer:
        return const TrainerDashboard();
      case UserRole.owner:
        return const OwnerDashboard();
    }
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 64,
      color: Colors.white,
      child: Row(
        children: _getBottomNavItems(),
      ),
    );
  }

  List<Widget> _getBottomNavItems() {
    switch (currentRole) {
      case UserRole.member:
        return [
          _buildNavItem(Icons.home, '🏠 Dashboard', AppColors.royalFuchsia, true),
          _buildNavItem(Icons.calendar_today, '📅 Classes', Colors.grey, false),
          _buildNavItem(Icons.emoji_events, '🏆 Goals', Colors.grey, false),
        ];
      case UserRole.trainer:
        return [
          _buildNavItem(Icons.home, '🏠 Dashboard', AppColors.mediumVioletRed, true),
          _buildNavItem(Icons.calendar_today, '📅 Schedule', Colors.grey, false),
          _buildNavItem(Icons.people, '👥 Clients', Colors.grey, false),
        ];
      case UserRole.owner:
        return [
          _buildNavItem(Icons.home, '🏠 Dashboard', AppColors.deepViolet, true),
          _buildNavItem(Icons.people, '👥 Members', Colors.grey, false),
          _buildNavItem(Icons.bar_chart, '📊 Analytics', Colors.grey, false),
        ];
    }
  }

  Widget _buildNavItem(IconData icon, String label, Color color, bool isActive) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: color),
          ),
        ],
      ),
    );
  }
}
