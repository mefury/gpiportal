import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About GPI'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                image: const DecorationImage(
                  image: AssetImage('assets/images/gpi_building.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black26,
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Greenland Polytechnic Institute',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Excellence in Technical Education',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Content Sections
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    context,
                    'About Us',
                    'Greenland Polytechnic Institute (GPI) is a leading technical education institution committed to providing quality education in engineering and technology. Established with a vision to create skilled professionals, GPI has been at the forefront of technical education.',
                  ),
                  
                  _buildSection(
                    context,
                    'Our Vision',
                    'To be a premier institution in technical education, producing skilled professionals who contribute to the technological advancement and industrial growth of Bangladesh.',
                  ),
                  
                  _buildSection(
                    context,
                    'Our Mission',
                    '• Provide quality technical education\n'
                    '• Foster innovation and research\n'
                    '• Develop industry-ready professionals\n'
                    '• Promote practical learning\n'
                    '• Encourage entrepreneurship',
                  ),
                  
                  _buildSection(
                    context,
                    'Departments',
                    '• Computer Technology\n'
                    '• Civil Technology\n'
                    '• Electrical Technology\n'
                    '• Electronics Technology\n'
                    '• Mechanical Technology',
                  ),
                  
                  _buildSection(
                    context,
                    'Facilities',
                    '• Modern Computer Labs\n'
                    '• Well-equipped Workshops\n'
                    '• Digital Library\n'
                    '• Smart Classrooms\n'
                    '• Sports Facilities',
                  ),

                  // Contact Card
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Us',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: 16),
                          _buildContactItem(
                            context,
                            Icons.location_on_outlined,
                            'Address',
                            'Amulia Model Town, Demra, Dhaka-1360',
                          ),
                          const SizedBox(height: 12),
                          _buildContactItem(
                            context,
                            Icons.phone_outlined,
                            'Phone',
                            ' +8801709990891 \n +8801709990907 \n +8801709990860 \n +8801709990861',
                          ),
                          const SizedBox(height: 12),
                          _buildContactItem(
                            context,
                            Icons.email_outlined,
                            'Email',
                            'principal@glandgroup.com',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String title,
    String content,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
} 