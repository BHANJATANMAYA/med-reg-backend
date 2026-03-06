import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/medical_response.dart';
import '../theme/app_theme.dart';
import '../widgets/section_card.dart';
// import '../widgets/risk_badge.dart';

class ResultsScreen extends StatefulWidget {
  final String query;
  final MedicalResponse response;

  const ResultsScreen({super.key, required this.query, required this.response});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.response;

    final answerLines = r.answer
        .split(RegExp(r'[\n•]'))
        .map((s) => s.trim().replaceFirst(RegExp(r'^[-–]\s*'), ''))
        .where((s) => s.isNotEmpty)
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text("MedRAG Analysis"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _animationController,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Card 1: Query & AI Summary ──
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          Theme.of(context).dividerTheme.color ??
                          Colors.grey.shade200,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withValues(alpha: 0.08),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.psychology,
                                color: AppTheme.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                widget.query,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.shield,
                                  color: AppTheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "AI Summary",
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text(
                              r.answer,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    height: 1.6,
                                    color: AppTheme.textPrimary.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // // ── Card 2: Risk Level & Confidence ──
                // SectionCard(
                //   title: "Risk Level",
                //   icon: Icons.shield,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           RiskBadge(riskLevel: r.riskLevel ?? 'Low'),
                //           Text(
                //             "${((r.confidence ?? 0.82) * 100).toInt()}%",
                //             style: Theme.of(context).textTheme.titleMedium
                //                 ?.copyWith(
                //                   fontWeight: FontWeight.w600,
                //                   color: AppTheme.textPrimary,
                //                 ),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: 16),
                //       Row(
                //         children: [
                //           Text(
                //             "Confidence",
                //             style: Theme.of(context).textTheme.bodyMedium
                //                 ?.copyWith(
                //                   fontWeight: FontWeight.w500,
                //                   color: AppTheme.textSecondary,
                //                 ),
                //           ),
                //           const SizedBox(width: 16),
                //           Expanded(
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(4),
                //               child: TweenAnimationBuilder<double>(
                //                 tween: Tween(
                //                   begin: 0,
                //                   end: r.confidence ?? 0.82,
                //                 ),
                //                 duration: const Duration(milliseconds: 900),
                //                 curve: Curves.easeOutCubic,
                //                 builder: (context, val, _) {
                //                   return LinearProgressIndicator(
                //                     value: val,
                //                     minHeight: 8,
                //                     backgroundColor: AppTheme.primary
                //                         .withValues(alpha: 0.1),
                //                     valueColor:
                //                         const AlwaysStoppedAnimation<Color>(
                //                           AppTheme.primaryLight,
                //                         ),
                //                   );
                //                 },
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                // ── Card 3: Recommended Treatments ──
                SectionCard(
                  title: "Recommended Treatments",
                  icon: Icons.medical_services_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: answerLines.map((line) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppTheme.primaryLight,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                line,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppTheme.textPrimary.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // ── Card 4: Medical Sources ──
                if (r.sources.isNotEmpty)
                  SectionCard(
                    title: "Medical Sources",
                    icon: Icons.link,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: r.sources.map((url) {
                        final domain = Uri.tryParse(url)?.host ?? url;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () => _openUrl(url),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.language,
                                  size: 18,
                                  color: AppTheme.textSecondary,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    domain,
                                    style: const TextStyle(
                                      color: AppTheme.primaryLight,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                // ── Card 5: Disclaimer ──
                SectionCard(
                  title: "Disclaimer",
                  icon: Icons.chat_bubble_outline,
                  child: Text(
                    "This tool does not replace professional medical advice.",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.5,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
