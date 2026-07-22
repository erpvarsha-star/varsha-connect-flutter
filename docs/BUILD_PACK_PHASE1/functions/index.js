const admin = require("firebase-admin");
const { onSchedule } = require("firebase-functions/v2/scheduler");
const { onDocumentWritten } = require("firebase-functions/v2/firestore");

admin.initializeApp();

const db = admin.firestore();

exports.scheduledTaskAndFormNotifications = onSchedule(
  {
    schedule: "every 15 minutes",
    timeZone: "Asia/Kolkata",
  },
  async () => {
    const now = admin.firestore.Timestamp.now();
    const today = new Date().toISOString().slice(0, 10);

    await notifyDueTasks(now, today);
    await notifyDueForms(now, today);
  }
);

exports.calculateDailyDashboardSummary = onSchedule(
  {
    schedule: "every 60 minutes",
    timeZone: "Asia/Kolkata",
  },
  async () => {
    const today = new Date().toISOString().slice(0, 10);
    await buildDashboardSummary(today);
  }
);

exports.syncAttendanceToSheets = onDocumentWritten(
  "attendance_logs/{attendanceId}",
  async (event) => {
    await queueSheetSync("Attendance_Log", event.params.attendanceId, event.data);
  }
);

exports.syncFormsToSheets = onDocumentWritten(
  "form_responses/{responseId}",
  async (event) => {
    await queueSheetSync("Form_Submissions", event.params.responseId, event.data);
  }
);

exports.syncTasksToSheets = onDocumentWritten(
  "tasks/{taskId}",
  async (event) => {
    await queueSheetSync("Task_Status", event.params.taskId, event.data);
  }
);

exports.syncPerformanceToSheets = onDocumentWritten(
  "performance_scores/{scoreId}",
  async (event) => {
    await queueSheetSync("Performance_Log", event.params.scoreId, event.data);
  }
);

async function notifyDueTasks(now, today) {
  const snapshot = await db
    .collection("tasks")
    .where("status", "in", ["assigned", "acknowledged", "in_progress"])
    .where("due_date", "<=", today)
    .get();

  const writes = [];
  for (const doc of snapshot.docs) {
    const task = doc.data();
    if (!task.assigned_to) continue;

    writes.push(createNotification({
      recipient_emp_code: task.assigned_to,
      type: "task_due",
      title: "Task due",
      body: task.title || "A task is due",
      related_module: "tasks",
      related_id: doc.id,
      sound: true,
      created_at: now,
    }));
  }

  await Promise.all(writes);
}

async function notifyDueForms(now, today) {
  const templates = await db
    .collection("form_templates")
    .where("active", "==", true)
    .where("priority", "==", 1)
    .get();

  const writes = [];
  for (const doc of templates.docs) {
    const form = doc.data();
    writes.push(createNotification({
      recipient_emp_code: "FORM_OWNER_TO_BE_RESOLVED",
      type: "form_due",
      title: "Form due",
      body: form.title || "A daily form is due",
      related_module: "forms",
      related_id: doc.id,
      sound: true,
      created_at: now,
    }));
  }

  await Promise.all(writes);
}

async function createNotification(payload) {
  const ref = await db.collection("notifications").add({
    ...payload,
    read: false,
    pushed: false,
  });

  // FCM send is wired during implementation after user FCM tokens exist.
  await ref.update({ notification_id: ref.id });
}

async function buildDashboardSummary(date) {
  const attendance = await db
    .collection("attendance_logs")
    .where("date", "==", date)
    .get();

  const byDepartment = new Map();
  for (const doc of attendance.docs) {
    const row = doc.data();
    const department = row.department || "Unknown";
    const current = byDepartment.get(department) || {
      date,
      department,
      total_staff: 0,
      present: 0,
      late: 0,
      absent: 0,
      updated_at: admin.firestore.FieldValue.serverTimestamp(),
    };

    current.total_staff += 1;
    if (row.status === "late") current.late += 1;
    if (row.status === "absent") current.absent += 1;
    if (["present", "late", "overtime"].includes(row.status)) current.present += 1;
    byDepartment.set(department, current);
  }

  const batch = db.batch();
  for (const [department, summary] of byDepartment.entries()) {
    batch.set(db.collection("dashboard_summaries").doc(`${date}_${department}`), summary, { merge: true });
  }
  await batch.commit();
}

async function queueSheetSync(sheetName, recordId, changeData) {
  const after = changeData && changeData.after && changeData.after.exists
    ? changeData.after.data()
    : null;

  await db.collection("sheet_sync_queue").add({
    sheet_name: sheetName,
    record_id: recordId,
    data: after,
    status: "pending",
    created_at: admin.firestore.FieldValue.serverTimestamp(),
  });
}
