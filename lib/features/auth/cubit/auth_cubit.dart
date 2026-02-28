import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_state.dart';
import '../../../core/local_storage/cache_helper.dart';
import '../models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? currentUser; // المتغير اللي هنحفظ فيه بيانات اليوزر بعد ما نجيبها

  // دالة إنشاء حساب جديد
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      UserModel userModel = UserModel(
        uId: uid,
        name: name,
        email: email,
        phone: phone,
      );

      await _firestore.collection('users').doc(uid).set(userModel.toMap());

      await CacheHelper.saveData(key: 'uid', value: uid);

      // بنحفظ الداتا مباشرة في المتغير عشان منعملش ريكويست للفايرستور بدون داعي بعد التسجيل
      currentUser = userModel;

      emit(AuthSuccess(uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthError('The account already exists for that email.'));
      } else {
        emit(AuthError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // دالة تسجيل الدخول
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      await CacheHelper.saveData(key: 'uid', value: uid);

      emit(AuthSuccess(uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthError('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthError('Wrong password provided for that user.'));
      } else {
        emit(AuthError(e.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // دالة جلب بيانات المستخدم من الفايرستور
  Future<void> getUserData() async {
    emit(GetUserLoading());

    String? uid = CacheHelper.getData(key: 'uid');

    if (uid != null) {
      try {
        DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();

        if (doc.exists) {
          currentUser = UserModel.fromJson(doc.data() as Map<String, dynamic>);
          emit(GetUserSuccess());
        } else {
          emit(GetUserError('لم يتم العثور على بيانات المستخدم'));
        }
      } catch (e) {
        emit(GetUserError(e.toString()));
      }
    }
  }

  // الدالة الجديدة: دالة تحديث بيانات المستخدم
  Future<void> updateUserData({required String name, required String phone}) async {
    emit(UpdateUserLoading()); // بنقول للشاشة تظهر تحميل
    try {
      String? uid = currentUser?.uId ?? CacheHelper.getData(key: 'uid');

      if (uid != null) {
        // 1. تحديث البيانات في قاعدة البيانات (Firestore)
        await _firestore.collection('users').doc(uid).update({
          'name': name,
          'phone': phone,
        });

        // 2. تحديث المتغير المحلي (الميموري) عشان الشاشات تحس بالتغيير فوراً بدون ما نعمل ريكويست جديد للنت
        if (currentUser != null) {
          currentUser = UserModel(
            uId: currentUser!.uId,
            name: name,
            email: currentUser!.email,
            phone: phone,
          );
        }

        emit(UpdateUserSuccess()); // بنقول للشاشة التحديث تم بنجاح
      }
    } catch (e) {
      emit(UpdateUserError(e.toString()));
    }
  }

  // دالة تسجيل الخروج
  Future<void> logout() async {
    await _auth.signOut();
    await CacheHelper.removeData(key: 'uid');
    currentUser = null; // تفريغ البيانات من الميموري
    emit(AuthInitial());
  }
}