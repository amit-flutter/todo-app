# 🧪 Sample Task Data

Add the following tasks into your app:

| Title  | Priority | Category | Time (min) |
|--------|----------|----------|------------|
| Task A | High     | Work     | 120        |
| Task B | High     | Personal | 150        |
| Task C | Medium   | Health   | 60         |
| Task D | Medium   | Work     | 30         |
| Task E | Low      | Personal | 20         |
| Task F | Low      | Health   | 90         |

This dataset covers all edges required to test the rule engine.

---

# 🧩 Rule-by-Rule Testing

## ✅ **Rule 1: Total estimated time must NOT exceed 240 minutes**

### **How to Test**

1. Enable Rule #1 from Settings
2. Add all sample tasks
3. Go to Home → Suggested Tasks

### **Expected Output**

The system should pick tasks until the **total time ≤ 240**.

Possible selection:

* Task A (120)
* Task C (60)
* Task D (30)
* Task E (20)
  Total = 230 minutes ✔️

High-priority Task B (150 mins) **should be skipped** due to time limit.

---

## ✅ **Rule 2: Sort by priority**

### **How to Test**

1. Enable Rule #2
2. Disable Rule #1 for this test
3. Check the order of suggested tasks

### **Expected Output**

Order should be:

1. High Priority
2. Medium
3. Low

Example:

* Task A
* Task B
* Task C
* Task D
* Task F
* Task E

---

## ✅ **Rule 3: Prefer shorter tasks within the same priority**

### **How to Test**

1. Enable Rule #3
2. Ensure Rule #2 is ON
3. Look at ordering inside each priority group

### **Expected Output**

**High Priority**

* Task A → 120
* Task B → 150

**Medium Priority**

* Task D → 30
* Task C → 60

**Low Priority**

* Task E → 20
* Task F → 90

Sorting inside priority should always prefer smaller time.

---

## ✅ **Rule 4: Include at least two categories**

### **How to Test**

1. Enable Rule #4
2. Enable/Disable others as needed
3. Add only tasks from **one category**

   * For example, only Work tasks
4. Check Suggested Section

### **Expected Output**

* If category diversity is possible → Pick tasks from at least **two different** categories
* If NOT possible (all tasks are from same category) → No error
* App simply picks the best available tasks

With our sample data, minimum categories included:

* Work
* Health (or Personal)

---

## ✅ **Rule 5: If a high priority task is skipped due to time limit, show a warning**

### **How to Test**

1. Turn ON Rule #1 (max 240 minutes)
2. Add all sample tasks
3. Ensure Task B (150 mins) should NOT fit in remaining time

### **Expected Output**

⚠️ **Warning message** appears:

> *Some high-priority tasks couldn't be added due to the 240-minute limit.*

And Suggested List should still show:

* Task A
* Task C
* Task D
* Task E

Total = 230 mins