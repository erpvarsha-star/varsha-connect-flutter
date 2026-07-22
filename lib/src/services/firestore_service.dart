import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_paths.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore firestore;

  Stream<DocumentSnapshot<Map<String, dynamic>>> userProfile(String empCode) {
    return firestore.collection(FirestorePaths.users).doc(empCode).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> dueForms({
    required String department,
    required String role,
  }) {
    return firestore
        .collection(FirestorePaths.formTemplates)
        .where('active', isEqualTo: true)
        .where('priority', isEqualTo: 1)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> myTasks(String empCode) {
    return firestore
        .collection(FirestorePaths.tasks)
        .where('assigned_to', isEqualTo: empCode)
        .orderBy('due_date')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> myNotifications(String empCode) {
    return firestore
        .collection(FirestorePaths.notifications)
        .where('recipient_emp_code', isEqualTo: empCode)
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  Future<void> saveAttendance(Map<String, dynamic> data) {
    final id = '${data['emp_code']}_${data['date']}';
    return firestore.collection(FirestorePaths.attendanceLogs).doc(id).set(data, SetOptions(merge: true));
  }

  Future<void> saveAttendanceCheckpoint(Map<String, dynamic> data) {
    final id = '${data['emp_code']}_${data['shift_date']}';
    return firestore.collection(FirestorePaths.attendanceCheckpoints).doc(id).set(data, SetOptions(merge: true));
  }

  Future<void> submitFormResponse(Map<String, dynamic> data) {
    return firestore.collection(FirestorePaths.formResponses).add(data);
  }

  Future<void> saveCasualWorkerCount(Map<String, dynamic> data) {
    final id = '${data['supervisor_emp_code']}_${data['shift_date']}_${data['shift_type']}';
    return firestore.collection(FirestorePaths.casualWorkerCounts).doc(id).set(data, SetOptions(merge: true));
  }

  Future<void> updateTaskStatus({
    required String taskId,
    required String status,
    String? completionNote,
  }) {
    return firestore.collection(FirestorePaths.tasks).doc(taskId).update({
      'status': status,
      if (completionNote != null) 'completion_note': completionNote,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> savePerformanceScore(Map<String, dynamic> data) {
    final id = '${data['emp_code']}_${data['period_start']}_${data['period_end']}';
    return firestore.collection(FirestorePaths.performanceScores).doc(id).set(data, SetOptions(merge: true));
  }

  Future<void> submitLeaveRequest(Map<String, dynamic> data) {
    return firestore.collection(FirestorePaths.leaveRequests).add({
      ...data,
      'status': 'Pending',
      'applied_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> submitAdvanceRequest(Map<String, dynamic> data) {
    return firestore.collection(FirestorePaths.advanceRequests).add({
      ...data,
      'status': 'Pending',
      'applied_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> reviewRequest({
    required String collection,
    required String requestId,
    required String status,
    required String reviewedBy,
  }) {
    return firestore.collection(collection).doc(requestId).update({
      'status': status,
      'reviewed_by': reviewedBy,
      'reviewed_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> saveShiftPlan(Map<String, dynamic> data) {
    final id = '${data['week_start']}_${data['department']}';
    return firestore.collection(FirestorePaths.shifts).doc(id).set(data, SetOptions(merge: true));
  }

  Future<void> saveMrmReview(Map<String, dynamic> data) {
    final id = '${data['month']}_${data['department']}';
    return firestore.collection(FirestorePaths.mrmReviews).doc(id).set(data, SetOptions(merge: true));
  }
}
