import 'package:flutter/material.dart';
import '../../chat/presentation/chat_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum AppThemeMode {
  dark,
  light,
  device,
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  AppThemeMode currentTheme = AppThemeMode.dark;

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController goalController =
      TextEditingController();

  final List<String> screenTitles = [
    "Home",
    "Chat",
    "Calendar",
    "Profile",
  ];

  bool get isDarkMode {
    if (currentTheme == AppThemeMode.dark) {
      return true;
    }

    if (currentTheme == AppThemeMode.light) {
      return false;
    }

    return MediaQuery.of(context).platformBrightness ==
        Brightness.dark;
  }

  @override
  @override
Widget build(BuildContext context) {
  final bool dark = isDarkMode;

  final bottomInset =
      MediaQuery.of(context).viewPadding.bottom;

  final bool isThreeButtonNavigation =
      bottomInset > 20;

  return Scaffold(
    backgroundColor:
        dark ? const Color(0xFF0B0B0F) : const Color(0xFFF1F5F9),

    floatingActionButton: 
      selectedIndex == 0
        ? Padding(
            padding: EdgeInsets.only(
              bottom:
                  isThreeButtonNavigation ? 18 : 0,
            ),

            child: FloatingActionButton(
              backgroundColor:
                  const Color(0xFF6A5ACD),

              elevation: 0,

              onPressed: () {
                openCreateTaskModal(
                  dark,
                  isThreeButtonNavigation,
                );
              },

              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        : null,

    body: AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),

      child: selectedIndex == 0
        ?SafeArea(
          child: homeContent(dark),
        )

        : selectedIndex == 1
          ? ChatScreen(
              onBack: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
            )
          : SafeArea(
              child: comingSoonScreen(dark),
            )
    ),

    bottomNavigationBar:Container(
      margin: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        isThreeButtonNavigation ? 10 : 16,
      ),

      decoration: BoxDecoration(
        color: dark
            ? const Color(0xFF12121A)
            : const Color(0xFFFFFFFF),

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: dark
              ? const Color(0xFF1F1F2B)
              : const Color(0xFFDDE3EA),
        ),
      ),

      child: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        backgroundColor: Colors.transparent,
        elevation: 0,

        type: BottomNavigationBarType.fixed,

        selectedItemColor:
            const Color(0xFF6A5ACD),

        unselectedItemColor: dark
            ? const Color(0xFFA0A0B2)
            : const Color(0xFF64748B),

        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
            ),
            label: "Chat",
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_rounded,
            ),
            label: "Calendar",
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_rounded,
            ),
            label: "Profile",
          ),
        ],
      ),
    ),
  );
}

  void openCreateTaskModal(bool dark, bool isThreeButtonNavigation,) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,

      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom,
          ),

          child: Container(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              isThreeButtonNavigation ? 18 : 20,
            ),

            decoration: BoxDecoration(
              color: dark
                  ? const Color(0xFF12121A)
                  : const Color(0xFFFFFFFF),

              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),

            child: StatefulBuilder(
              builder: (context, setModalState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [
                          Text(
                            "Create Task",
                            style: TextStyle(
                              color: dark
                                  ? Colors.white
                                  : Colors.black,

                              fontSize: 24,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },

                            child: Container(
                              width: 42,
                              height: 42,

                              decoration: BoxDecoration(
                                color: dark
                                    ? const Color(
                                        0xFF1A1A24)
                                    : const Color(
                                        0xFFF1F5F9),

                                borderRadius:
                                    BorderRadius
                                        .circular(14),
                              ),

                              child: Icon(
                                Icons.close_rounded,
                                color: dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // TITLE
                      Text(
                        "Title",
                        style: TextStyle(
                          color: dark
                              ? Colors.white
                              : Colors.black,

                          fontSize: 16,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: titleController,

                        maxLength: 20,

                        onChanged: (_) {
                          setModalState(() {});
                        },

                        style: TextStyle(
                          color: dark
                              ? Colors.white
                              : Colors.black,
                        ),

                        decoration: InputDecoration(
                          counterText:
                              "${titleController.text.length}/20",

                          hintText:
                              "Task short title",

                          hintStyle: TextStyle(
                            color: dark
                                ? const Color(
                                    0xFFA0A0B2)
                                : const Color(
                                    0xFF64748B),
                          ),

                          filled: true,

                          fillColor: dark
                              ? const Color(
                                  0xFF1A1A24)
                              : const Color(
                                  0xFFF1F5F9),

                          contentPadding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 18,
                            vertical: 18,
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(18),

                            borderSide:
                                BorderSide.none,
                          ),

                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(18),

                            borderSide: BorderSide(
                              color: dark
                                  ? const Color(
                                      0xFF2A2A38)
                                  : const Color(
                                      0xFFDDE3EA),
                            ),
                          ),

                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(18),

                            borderSide:
                                const BorderSide(
                              color: Color(
                                  0xFF6A5ACD),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // GOAL
                      Text(
                        "Goal",
                        style: TextStyle(
                          color: dark
                              ? Colors.white
                              : Colors.black,

                          fontSize: 16,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: goalController,

                        maxLength: 500,
                        minLines: 5,
                        maxLines: 7,

                        onChanged: (_) {
                          setModalState(() {});
                        },

                        style: TextStyle(
                          color: dark
                              ? Colors.white
                              : Colors.black,
                        ),

                        decoration: InputDecoration(
                          alignLabelWithHint: true,

                          counterText:
                              "${goalController.text.length}/500",

                          hintText:
                              "What you want to achieve",

                          hintStyle: TextStyle(
                            color: dark
                                ? const Color(
                                    0xFFA0A0B2)
                                : const Color(
                                    0xFF64748B),
                          ),

                          filled: true,

                          fillColor: dark
                              ? const Color(
                                  0xFF1A1A24)
                              : const Color(
                                  0xFFF1F5F9),

                          contentPadding:
                              const EdgeInsets
                                  .all(18),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(18),

                            borderSide:
                                BorderSide.none,
                          ),

                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(18),

                            borderSide: BorderSide(
                              color: dark
                                  ? const Color(
                                      0xFF2A2A38)
                                  : const Color(
                                      0xFFDDE3EA),
                            ),
                          ),

                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(18),

                            borderSide:
                                const BorderSide(
                              color: Color(
                                  0xFF6A5ACD),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Align(
                        alignment:
                            Alignment.centerRight,

                        child: ElevatedButton(
                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                const Color(
                                    0xFF6A5ACD),

                            elevation: 0,

                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          16),
                            ),
                          ),

                          onPressed: () {
                            Navigator.pop(context);

                            setState(() {
                              selectedIndex = 1;
                            });
                          },

                          child: const Row(
                            mainAxisSize:
                                MainAxisSize.min,

                            children: [
                              Text(
                                "Continue",
                                style: TextStyle(
                                  color:
                                      Colors.white,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),

                              SizedBox(width: 8),

                              Icon(
                                Icons
                                    .arrow_forward_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget comingSoonScreen(bool dark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.construction_rounded,
            color: Color(0xFF6A5ACD),
            size: 70,
          ),
          const SizedBox(height: 20),
          Text(
            screenTitles[selectedIndex],
            style: TextStyle(
              color: dark ? Colors.white : Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Screen Coming Soon",
            style: TextStyle(
              color: dark
                  ? const Color(0xFFA0A0B2)
                  : const Color(0xFF64748B),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget homeContent(bool dark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: dark
                  ? const Color(0xFF12121A)
                  : Colors.white,

              borderRadius: BorderRadius.circular(18),

              border: Border.all(
                color: dark
                    ? const Color(0xFF1F1F2B)
                    : const Color(0xFFDDE3EA),
              ),
            ),

            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,

                    decoration: BoxDecoration(
                      color: dark
                          ? const Color(0xFF1A1A24)
                          : const Color(0xFFF1F5F9),

                      borderRadius:
                          BorderRadius.circular(14),
                    ),

                    child: Row(
                      children: [
                        const SizedBox(width: 14),

                        Icon(
                          Icons.search,
                          color: dark
                              ? const Color(0xFFA0A0B2)
                              : const Color(0xFF64748B),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "Search tasks...",
                          style: TextStyle(
                            color: dark
                                ? const Color(
                                    0xFFA0A0B2)
                                : const Color(
                                    0xFF64748B),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                headerIcon(
                  Icons.notifications_none,
                  dark,
                ),

                const SizedBox(width: 12),

                PopupMenuButton<AppThemeMode>(
                  onSelected: (value) {
                    setState(() {
                      currentTheme = value;
                    });
                  },

                  color: dark
                      ? const Color(0xFF1A1A24)
                      : Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),

                  icon: Container(
                    width: 50,
                    height: 50,

                    decoration: BoxDecoration(
                      color: dark
                          ? const Color(0xFF1A1A24)
                          : const Color(0xFFF1F5F9),

                      borderRadius:
                          BorderRadius.circular(14),
                    ),

                    child: Icon(
                      dark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,

                      color: dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),

                  itemBuilder: (context) => [
                    popupItem(
                      title: "Light",
                      icon: Icons.light_mode_rounded,
                      value: AppThemeMode.light,
                      dark: dark,
                    ),

                    popupItem(
                      title: "Dark",
                      icon: Icons.dark_mode_rounded,
                      value: AppThemeMode.dark,
                      dark: dark,
                    ),

                    popupItem(
                      title: "Device",
                      icon: Icons.phone_android_rounded,
                      value: AppThemeMode.device,
                      dark: dark,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          Text(
            "Good Evening,",
            style: TextStyle(
              color: dark
                  ? const Color(0xFFA0A0B2)
                  : const Color(0xFF64748B),
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Abhinandan 👋",
            style: TextStyle(
              color: dark ? Colors.white : Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 28),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),

              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6A5ACD),
                  Color(0xFF4A3FB5),
                ],
              ),
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "Today's Focus",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color:
                            Colors.white.withOpacity(0.15),

                        borderRadius:
                            BorderRadius.circular(30),
                      ),

                      child: const Text(
                        "In Progress",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                const Text(
                  "Build\nAI Assistant UI",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "Today's Schedule",
                style: TextStyle(
                  color:
                      dark ? Colors.white : Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Text(
                "See All",
                style: TextStyle(
                  color: Color(0xFF00BFFF),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          scheduleCard(
            dark: dark,
            time: "08:00 PM",
            title: "Design Home Screen",
            subtitle: "UI/UX Design",
            color: const Color(0xFF6A5ACD),
          ),

          const SizedBox(height: 14),

          scheduleCard(
            dark: dark,
            time: "09:30 PM",
            title: "Setup Navigation",
            subtitle: "Flutter Development",
            color: const Color(0xFF00BFFF),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  PopupMenuItem<AppThemeMode> popupItem({
    required String title,
    required IconData icon,
    required AppThemeMode value,
    required bool dark,
  }) {
    return PopupMenuItem(
      value: value,

      child: Row(
        children: [
          Icon(
            icon,
            color: dark ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: dark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget headerIcon(
    IconData icon,
    bool dark,
  ) {
    return Container(
      width: 50,
      height: 50,

      decoration: BoxDecoration(
        color: dark
            ? const Color(0xFF1A1A24)
            : const Color(0xFFF1F5F9),

        borderRadius: BorderRadius.circular(14),
      ),

      child: Icon(
        icon,
        color: dark ? Colors.white : Colors.black,
      ),
    );
  }

  Widget scheduleCard({
    required bool dark,
    required String time,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: dark
            ? const Color(0xFF12121A)
            : Colors.white,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: dark
              ? const Color(0xFF1F1F2B)
              : const Color(0xFFDDE3EA),
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,

            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    color:
                        dark ? Colors.white : Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: dark
                        ? const Color(0xFFA0A0B2)
                        : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF00BFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}