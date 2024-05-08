import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medihub/features/auth/screens/LoginScreen.dart';
import 'package:medihub/features/auth/screens/SignupScreen.dart';
import 'package:medihub/features/doctor/BookDoc/BookDoc.dart';
import 'package:medihub/features/doctor/DocDetail/DocDetailScreen.dart';
import 'package:medihub/features/doctor/catDoctor/screens/doctor_details.dart';
import 'package:medihub/features/doctor/catDoctor/screens/doctor_vertical.dart';
import 'package:medihub/features/doctor/doctor.dart';
import 'package:medihub/features/emergency/screens/emergency_screen.dart';
import 'package:medihub/features/emergency/screens/hospital_map.dart';
import 'package:medihub/features/emergency/services/emergency_services.dart';
import 'package:medihub/features/exercises/screens/exercises_list.dart';
import 'package:medihub/features/exercises/screens/exercises_types.dart';
import 'package:medihub/features/news/pages/home.dart';
import 'package:medihub/features/news/pages/vertHome.dart';
import 'package:medihub/features/cart/screens/cart_screen.dart';
import 'package:medihub/features/pharmacy/screens/productSelected.dart';
import 'package:medihub/features/pharmacy/screens/verticalList.dart';
import 'package:medihub/features/home/screens/home.dart';
import 'package:medihub/features/syptom_checker/screens/symptom_analyze.dart';
import 'package:medihub/features/syptom_checker/screens/syptomchecker.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case SignupScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SignupScreen(),
        );

      case HomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case DoctorScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const DoctorScreen(),
        );

      case VerticalList.routeName:
        return CupertinoPageRoute(
          builder: (context) => const VerticalList(),
        );

      case PharmacyCart.routeName:
        return CupertinoPageRoute(
          builder: (context) => const PharmacyCart(),
        );

      case ProductSelected.routeName:
        final medName = settings.arguments as String;
        return CupertinoPageRoute(
          builder: (context) => ProductSelected(medName: medName),
        );

      case DoctorVertical.routeName:
        final doctCategory = settings.arguments as String;
        return CupertinoPageRoute(
          builder: (context) => DoctorVertical(
            doctCategory: doctCategory,
          ),
        );

      case DoctorDetail.routeName:
        final doctId = settings.arguments as String;
        return CupertinoPageRoute(
          builder: (context) => DoctorDetail(
            doctId: doctId,
          ),
        );

      // case SymptomChecker.routeName:
      //   return CupertinoPageRoute(builder: (context) => SymptomChecker());

      case ExerciseTypes.routeName:
        return CupertinoPageRoute(
          builder: (context) => const ExerciseTypes(),
        );

      
      case SymptomsPage.routeName:
        return CupertinoPageRoute(
          builder: (context) => SymptomsPage(),
        );

      case ExerciseList.routeName:
        final keyword = settings.arguments as String;
        return CupertinoPageRoute(
          builder: (context) => ExerciseList(
            keyword: keyword,
          ),
        );


        case AnalyzeSymptom.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(
          builder: (context) => AnalyzeSymptom(
            name: args['name'],
            value: args['value'],
          ),
        );

      case EmergencyScreen.routeName:
        return CupertinoPageRoute(builder: (context) => EmergencyScreen());  


      case Home.routeName:
        return CupertinoPageRoute(builder: (context) => const Home());    
      
      
      case VertHome.routeName:
        return CupertinoPageRoute(builder: (context) => const VertHome());   

      // case BookingPage.routeName:
      //   return CupertinoPageRoute(builder: (context) => const BookingPage()); 

      case HospitalMap.routeName:
        final hospitals = settings.arguments as List<Hospital>;
        return CupertinoPageRoute(
          builder: (context) => HospitalMap(hospitals: hospitals)
        );

      // case SplashScreen.routeName: return CupertinoPageRoute(
      //   builder: (context) => const SplashScreen()
      // );

      default:
        return null;
    }
  }
}
