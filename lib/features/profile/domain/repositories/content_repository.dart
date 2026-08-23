import '../entities/faq_item.dart';

abstract class ContentRepository {
  Future<String> getPrivacyPolicy();
  Future<List<FaqItem>> getFaqList();
  Future<String> getTermsOfUse();
  Future<String> getRegulations();
  Future<String> getComplaintHandling();
  Future<String> getAbout();
}
