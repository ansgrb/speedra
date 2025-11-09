import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedra/features/settings/presentation/providers/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    final iconPath = isDarkMode
        ? 'assets/speedRaIconTransDark.png'
        : 'assets/speedRaIconTrans.png';
    return Scaffold(
      appBar: AppBar(title: const Text('About speedRa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    iconPath,
                    height: 90.0,
                    width: 90.0,
                  ),
                  Text('speedRa', style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text('Version 1.0.0', style: theme.textTheme.bodySmall),
                  const SizedBox(height: 24),
                  Text(
                    '"As the sun god Ra brings light to the world, speedRa illuminates your internet connection."',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            _buildSectionTitle(context, 'Author'),
            const SizedBox(height: 16),
            _buildInfoTile(
              context,
              icon: Icons.person,
              title: 'ansgrb',
              subtitle: 'The creator of speedRa',
              url: 'https://github.com/ansgrb',
            ),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Contributing'),
            const SizedBox(height: 16),
            _buildInfoTile(
              context,
              icon: Icons.code,
              title: 'Contribute on GitHub',
              subtitle: 'Report issues or submit pull requests',
              url: 'https://github.com/ansgrb/speedra/pulls',
            ),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'License'),
            const SizedBox(height: 16),
            _buildInfoTile(
              context,
              icon: Icons.article,
              title: 'MIT License',
              subtitle: 'This project is licensed under the MIT License.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    String? url,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: url != null ? () => _launchURL(url) : null,
    );
  }

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
