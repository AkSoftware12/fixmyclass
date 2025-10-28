import 'package:flutter/material.dart';

// ------------------- Quiz & Question Classes -------------------

class Question {
  final String question;
  final List<String> options;
  final int answerIndex;

  Question({
    required this.question,
    required this.options,
    required this.answerIndex,
  });
}

class Quiz {
  final List<Question> questions;

  Quiz({required this.questions});

  static Quiz sample() {
    return Quiz(questions: List.generate(20, (i) {
      return Question(
        question: 'Question ${i + 1}: What is Flutter used for?',
        options: [
          'Web Development',
          'Mobile App Development',
          'Game Development',
          'AI Training'
        ],
        answerIndex: 1,
      );
    }));
  }
}

// ------------------- Practice Screen -------------------

class QuizPracticeScreen extends StatefulWidget {
  const QuizPracticeScreen({Key? key}) : super(key: key);

  @override
  State<QuizPracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<QuizPracticeScreen>
    with SingleTickerProviderStateMixin {
  late final Quiz quiz;
  late final AnimationController _timerController;
  late final PageController _pageController;
  int _currentIndex = 0;
  int? _selectedOption;
  bool _isPlaying = true;
  bool _repeat = true;
  static const int secondsPerQuestion = 30;
  late List<String> shuffledOptions;
  late Map<int, int> optionMapping; // maps shuffled index to original

  @override
  void initState() {
    super.initState();
    quiz = Quiz.sample();
    _pageController = PageController(initialPage: 0);
    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: secondsPerQuestion),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _onTimeUp();
        }
      });
    _loadQuestion(0);
  }

  @override
  void dispose() {
    _timerController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _loadQuestion(int index) {
    final question = quiz.questions[index];
    shuffledOptions = List<String>.from(question.options);
    shuffledOptions.shuffle();
    // map shuffled index to original index
    optionMapping = {};
    for (int i = 0; i < shuffledOptions.length; i++) {
      optionMapping[i] = question.options.indexOf(shuffledOptions[i]);
    }
    setState(() {
      _currentIndex = index;
      _selectedOption = null;
    });
    _restartTimer();
  }

  void _onTimeUp() {
    if (_currentIndex < quiz.questions.length - 1) {
      _loadQuestion(_currentIndex + 1);
    } else if (_repeat) {
      _loadQuestion(0);
    }
  }

  void _goToQuestion(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _loadQuestion(index);
  }

  void _restartTimer() {
    _timerController.stop();
    _timerController.reset();
    if (_isPlaying) _timerController.forward();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _timerController.forward();
      } else {
        _timerController.stop();
      }
    });
  }

  void _openJumpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Jump to Question"),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: quiz.questions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    _goToQuestion(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.indigo
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = quiz.questions[_currentIndex];
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.indigo.shade700, Colors.deepPurple.shade400],
              ),
            ),
            child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.school, color: Colors.white),
                              const SizedBox(width: 8),
                              const Text('Practice',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: _openJumpDialog,
                                icon: const Icon(
                                    Icons.list_alt_rounded, color: Colors
                                    .white),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() => _repeat = !_repeat);
                                },
                                icon: Icon(
                                  _repeat ? Icons.repeat : Icons
                                      .repeat_on_outlined,
                                  color: _repeat ? Colors.white : Colors
                                      .white54,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${_currentIndex + 1}/${quiz.questions.length}',
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: AnimatedBuilder(
                          animation: _timerController,
                          builder: (context, child) {
                            final progress = _timerController.value;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 8,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 90,
                                              width: 90,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  CircularProgressIndicator(
                                                    value: 1 - progress,
                                                    strokeWidth: 8,
                                                  ),
                                                  Text(
                                                    '${(secondsPerQuestion *
                                                        (1 - progress))
                                                        .ceil()}s',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Text(
                                                question.question,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight
                                                        .w700),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        ...List.generate(
                                            shuffledOptions.length, (i) {
                                          final isSelected = _selectedOption ==
                                              i;
                                          final correctIndex = optionMapping
                                              .entries
                                              .firstWhere((e) => e.key == i)
                                              .value;
                                          Color color = Colors.grey.shade200;
                                          if (_selectedOption != null) {
                                            if (isSelected && correctIndex ==
                                                question.answerIndex) {
                                              color = Colors.green.shade300;
                                            } else if (isSelected &&
                                                correctIndex !=
                                                    question.answerIndex) {
                                              color = Colors.red.shade300;
                                            }
                                          }
                                          return GestureDetector(
                                            onTap: _selectedOption == null
                                                ? () {
                                              setState(() =>
                                              _selectedOption = i);
                                              Future.delayed(const Duration(
                                                  seconds: 1), () {
                                                if (_currentIndex <
                                                    quiz.questions.length - 1) {
                                                  _loadQuestion(
                                                      _currentIndex + 1);
                                                } else if (_repeat) {
                                                  _loadQuestion(0);
                                                }
                                              });
                                            }
                                                : null,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 8),
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: color,
                                                borderRadius: BorderRadius
                                                    .circular(12),
                                                border: Border.all(
                                                    color: Colors.black12),
                                              ),
                                              child: Text(
                                                '${String.fromCharCode(65 +
                                                    i)}. ${shuffledOptions[i]}',
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          _goToQuestion(
                                              (_currentIndex - 1) < 0
                                                  ? quiz.questions.length - 1
                                                  : _currentIndex - 1),
                                      icon: const Icon(
                                          Icons.skip_previous, size: 32),
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton.icon(
                                      onPressed: _togglePlay,
                                      icon: Icon(
                                          _isPlaying ? Icons.pause : Icons
                                              .play_arrow),
                                      label: Text(
                                          _isPlaying ? 'Pause' : 'Play'),
                                    ),
                                    const SizedBox(width: 12),
                                    IconButton(
                                      onPressed: () =>
                                          _goToQuestion((_currentIndex + 1) %
                                              quiz.questions.length),
                                      icon: const Icon(
                                          Icons.skip_next, size: 32),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
            )
        )
    );
  }
}