import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/faq_item.dart';
import '../../domain/repositories/content_repository.dart';

class ContentRepositoryImpl implements ContentRepository {
  @override
  Future<String> getPrivacyPolicy() async {
    // TODO: replace with supabase.from('app_content').select().eq('type', 'privacy_policy').single() once content table exists
    return '''
ClinicQ Privacy Policy
Last updated: August 2026

1. Introduction
Welcome to ClinicQ. We are committed to protecting your personal data and your privacy. This Privacy Policy explains how ClinicQ ("we", "us", or "our") collects, uses, discloses, and safeguards your information when you use our mobile application and related healthcare appointment booking and clinic-queue-tracking services.

2. Information We Collect
We collect information that you provide directly to us:
• Personal Identity: Name, email address, phone number, date of birth, and gender.
• Health & Appointment Data: Appointment history, preferred clinics, booked doctor details, and check-in times.
• Device & Location: IP address, device operating system version, and location data (specifically to help you find nearby clinics).

3. How We Use Your Information
We use your information to:
• Facilitate appointment bookings and real-time clinic queue tracking.
• Send essential reminders, notifications, and updates regarding your appointments.
• Improve our services, UI design, and application performance.
• Maintain security, prevent fraud, and comply with legal requirements.

4. Data Sharing and Disclosure
We share your information only under the following conditions:
• Healthcare Providers: With the clinics and doctors you schedule appointments with, so they can deliver care.
• Under No Circumstances do we sell, trade, or rent your personal information to third parties for marketing purposes.
• Legal Compliance: If required by law, court order, or government regulation.

5. Data Security
Your personal details are stored using secure Supabase database instances. We apply:
• Transport Layer Security (TLS/HTTPS) for all data in transit.
• Industry-standard encryption algorithms for data at rest.
• Row-Level Security (RLS) policies within Supabase to ensure that only authorized users can read or edit their own profile data.

6. Your Rights
You have the right to access, update, correct, or request the deletion of your personal data at any time via the Edit Profile screen or by contacting our support team.

7. Children's Privacy
ClinicQ is not intended for use by individuals under the age of 13. If we become aware that we have collected personal data from a child under 13 without verification of parental consent, we will delete that data immediately.

8. Contact Us
For any questions about this Privacy Policy, please contact our privacy compliance officer at support@clinicq.com.
''';
  }

  @override
  Future<List<FaqItem>> getFaqList() async {
    // TODO: replace with supabase.from('faqs').select() once content table exists
    return const [
      FaqItem(
        id: '1',
        question: 'How do I book an appointment?',
        answer: 'You can book an appointment by selecting a clinic or doctor from the home screen, choosing a preferred time slot or token from their schedule, entering patient details, and confirming the booking.',
      ),
      FaqItem(
        id: '2',
        question: 'How do I find a doctor near me?',
        answer: 'Use the search filter on the Doctors tab to sort by proximity, or grant location permissions to display clinics sorted by distance from your current location on the Clinics screen.',
      ),
      FaqItem(
        id: '3',
        question: 'How does live queue tracking work?',
        answer: 'Once you book an appointment and check in, you can monitor the live queue progress on the Tracking tab. It displays the current active token number, approximate waiting time, and sends push notifications when your turn approaches.',
      ),
      FaqItem(
        id: '4',
        question: 'Can I cancel or reschedule an appointment?',
        answer: 'Yes. Navigate to your appointments page, select the appointment you wish to modify, and tap Cancel or Reschedule. Please note that rescheduling depends on doctor availability for that day.',
      ),
      FaqItem(
        id: '5',
        question: 'How do I add a doctor or clinic to my Interest List?',
        answer: 'Open the profile screen of any doctor or clinic and tap the bookmark/save icon in the top right app bar. It will turn solid and immediately be added to your Interest List, which you can access anytime from your profile.',
      ),
      FaqItem(
        id: '6',
        question: 'Is my personal data secure?',
        answer: 'Absolutely. We use Supabase-backed storage with Row-Level Security (RLS) to ensure that only you can access your profile information. All communication between the app and the servers is encrypted using TLS.',
      ),
      FaqItem(
        id: '7',
        question: 'What do I do if I can\'t sign in?',
        answer: 'Ensure that you are connected to the internet and using the registered email address. You can trigger an OTP verification code code to verify your identity and restore access to your account.',
      ),
    ];
  }

  @override
  Future<String> getTermsOfUse() async {
    return '''
ClinicQ Terms of Use
Last updated: August 2026

Please read these Terms of Use carefully before using the ClinicQ mobile application. By accessing or using our services, you agree to be bound by these terms.

1. Services Provided
ClinicQ provides an appointment reservation system and live queue management assistance for outpatient clinics. We do not provide medical advice or emergency medical services. In case of a medical emergency, call your local emergency services immediately.

2. User Accounts
You must provide accurate, complete, and current information when creating your account. You are responsible for safeguarding your password and account credentials.

3. Acceptable Use
You agree not to disrupt the platform, spam bookings, or use automated scrapers to pull doctor availability. We reserve the right to suspend accounts that abuse the booking tokens or violate these guidelines.
''';
  }

  @override
  Future<String> getRegulations() async {
    return '''
Regulations on Booking Activities

To ensure a fair experience for all patients, please note the following rules:
1. No-Show Policy: Missing three booked appointments consecutively without canceling ahead of time will result in a temporary suspension of booking privileges.
2. Timing: Patients must arrive at least 10 minutes prior to their estimated appointment time or risk losing their queue slot.
3. Cancellations: Appointments can be canceled or rescheduled up to 1 hour before the scheduled consultation starts.
''';
  }

  @override
  Future<String> getComplaintHandling() async {
    return '''
Complaint Handling Process

At ClinicQ, we strive to provide the best possible experience. If you have a grievance:
1. Submit a complaint: Email support@clinicq.com with details of your experience, clinic name, and reservation token.
2. Review period: Our support representatives will investigate the incident and reply within 24 to 48 hours.
3. Resolution: We work directly with clinic managers to rectify queue tracking errors or booking discrepancies.
''';
  }

  @override
  Future<String> getAbout() async {
    return '''
About ClinicQ

ClinicQ is a modern healthcare app designed to eliminate long clinic waiting room times. By providing real-time queue status updates, patients can check-in remotely and track their position in the queue live.

Version: 1.0.0
Developer: Advanced Agentic Coding
Powered by Supabase and Drift SQLite Cache.
''';
  }
}

final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  return ContentRepositoryImpl();
});
