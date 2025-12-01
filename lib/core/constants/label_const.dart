// lib/core/constants/label_const.dart

class LabelConst {
  // App
  static const appName = "Smart Todo App";
  static const themeLight = "Light Theme";
  static const themeDark = "Dark Theme";
  static const themeMode = "Theme Mode";

  // Home
  static const homeTitle = "Tasks";
  static const addTask = "Add Task";
  static const noTaskAdded = "No tasks yet. Tap + to add.";
  static const highPriorityTaskWarningMessage = 'Some high-priority tasks were excluded due to the time limit.';
  static const suggestionForToday = 'Suggested for Today';
  static const noSuggestionsForToday = 'No suggestions for today.';

  // Task Form
  static const taskName = "Task Name";
  static const description = "Description";
  static const estimatedTime = "Estimated Time (minutes)";
  static const priority = "Priority";
  static const saveTask = "Save Task";

  // Priorities
  static const high = "High";
  static const medium = "Medium";
  static const low = "Low";

  // Add Task Dialog
  static const addTaskTitle = "Add Task";
  static const taskTitleLabel = "Title";
  static const priorityLabel = "Priority";
  static const categoryLabel = "Category";
  static const estimatedTimeLabel = "Estimated time (minutes)";
  static const cancel = "Cancel";
  static const add = "Add";

  // Validation
  static const validation = "Validation";
  static const titleRequired = "Title is required";

  // Categories
  static const categoryWork = "Work";
  static const categoryPersonal = "Personal";
  static const categoryHealth = "Health";

  // Settings Page
  static const settingsTitle = "Rule Engine Settings";
  static const ruleMaxTotalTime = "Max total estimated time ≤ 240 minutes";
  static const ruleSortByPriority = "Sort by priority";
  static const rulePreferShorterWithinPriority = "Within same priority prefer shorter tasks";
  static const ruleIncludeTwoCategories = "Include at least two categories if possible";
  static const ruleWarnIfHighExcluded = "Warn if high priority excluded due to time limit";
}
