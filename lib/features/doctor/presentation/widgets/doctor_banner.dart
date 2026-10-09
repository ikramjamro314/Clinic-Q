import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/utils/time_utils.dart';

import '../../domain/entities/doctor_entity.dart';

class DoctorBanner extends StatelessWidget {
  final DoctorEntity? doctor;
  final DateTime? appointmentDate;
  final VoidCallback? onTap;

  const DoctorBanner({
    super.key,
    this.doctor,
    this.appointmentDate,
    this.onTap,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return 'Today';
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final wDay = weekdays[date.weekday - 1];
    final mName = months[date.month - 1];
    return '$wDay, ${date.day} $mName ${date.year}';
  }

  String _formatTime(DoctorEntity? doc) {
    return TimeUtils.formatTimeRange(
      doc?.startTime ?? '09:00',
      doc?.endTime ?? '14:00',
    );
  }

  @override
  Widget build(BuildContext context) {
    final docName = doctor?.name.isNotEmpty == true ? doctor!.name : 'Next Available Doctor';
    final docSpecialty = doctor?.specialty.isNotEmpty == true ? doctor!.specialty : 'General Physician';
    final formattedDate = _formatDate(appointmentDate);
    final formattedTime = _formatTime(doctor);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: ClinicQColors.gradientBanner,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F766E).withOpacity(0.25),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background wave from home banner
              Positioned.fill(
                child: CustomPaint(painter: _BannerWavePainter()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Upcoming Schedule',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Date & Time Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            icon: Icons.calendar_today_outlined,
                            title: formattedDate,
                            subtitle: 'Available Date',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoCard(
                            icon: Icons.access_time_rounded,
                            title: formattedTime,
                            subtitle: 'Available Time',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Doctor Info Card
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ClinicQColors.secondaryBackground,
                            ),
                            child: ClipOval(
                              child: (doctor?.photoUrl != null &&
                                      doctor!.photoUrl!.isNotEmpty &&
                                      !doctor!.photoUrl!.contains('example.com'))
                                  ? Image.network(
                                      doctor!.photoUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.person,
                                        color: ClinicQColors.primaryTeal,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.person,
                                      color: ClinicQColors.primaryTeal,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  docName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: ClinicQColors.textPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  docSpecialty,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: ClinicQColors.textSecondary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ClinicQColors.dividerMedium,
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: ClinicQColors.primaryTeal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24.0;

    final path1 = Path();
    path1.moveTo(size.width * 0.4, 0);
    path1.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.5,
      size.width * 1.1,
      size.height * 0.8,
    );
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(size.width * 0.55, 0);
    path2.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.6,
      size.width * 1.2,
      size.height * 1.0,
    );
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
