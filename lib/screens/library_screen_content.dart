import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/historical_figure.dart'; // if Debate is defined there

class LibraryScreenContent extends StatefulWidget {
  const LibraryScreenContent({super.key});

  @override
  State<LibraryScreenContent> createState() => _LibraryScreenContentState();
}

class _LibraryScreenContentState extends State<LibraryScreenContent> {
  int _selectedTab = 0; // 0 = Saved, 1 = Past

  final List<Debate> _savedDebates = [
    Debate(
      id: '1',
      title: 'The Future of AI',
      description:
          'Watch a debate between two AI figures on the future of artificial intelligence.',
      type: 'AI VS AI',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Debate(
      id: '2',
      title: 'Ethics of Genetic Engineering',
      description:
          'Replay your debate with an AI figure on the ethical implications of genetic engineering.',
      type: 'USER VS AI',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  final List<Debate> _pastDebates = [
    Debate(
      id: '3',
      title: 'Government in Healthcare',
      description:
          'Watch a debate between two AI figures on the role of government in healthcare.',
      type: 'AI VS AI',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final debates = _selectedTab == 0 ? _savedDebates : _pastDebates;

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Library',
                    style: TextStyle(
                      color: AppTheme.whiteText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: AppTheme.whiteText),
                    onPressed: () {
                      // optional: open a dedicated search screen later
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                'Replay your debates and watch AI vs AI showdowns.',
                style: TextStyle(color: AppTheme.lightGray, fontSize: 14),
              ),
            ),

            // Tabs
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTab == 0
                                ? AppTheme.brightRed
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Saved',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedTab == 0
                              ? AppTheme.brightRed
                              : AppTheme.mediumGray,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTab == 1
                                ? AppTheme.brightRed
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Past',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedTab == 1
                              ? AppTheme.brightRed
                              : AppTheme.mediumGray,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.darkCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppTheme.mediumGray),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: AppTheme.whiteText),
                        decoration: const InputDecoration(
                          hintText: 'Search by topic or figure...',
                          hintStyle: TextStyle(color: AppTheme.mediumGray),
                          border: InputBorder.none,
                        ),
                        // TODO: hook this up to filter debates if you want
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Debate Cards
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: debates.length,
                itemBuilder: (context, index) {
                  return _buildDebateCard(debates[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebateCard(Debate debate) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  debate.type,
                  style: const TextStyle(
                    color: AppTheme.mediumGray,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  debate.title,
                  style: const TextStyle(
                    color: AppTheme.darkNavy,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  debate.description,
                  style: const TextStyle(
                    color: AppTheme.darkNavy,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // TODO: hook to replay/watch logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.brightRed,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        debate.type == 'USER VS AI'
                            ? Icons.replay
                            : Icons.play_arrow,
                        color: AppTheme.whiteText,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        debate.type == 'USER VS AI' ? 'Replay' : 'Watch',
                        style: const TextStyle(
                          color: AppTheme.whiteText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Thumbnail placeholder
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.darkCard,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.image,
              color: AppTheme.mediumGray,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
