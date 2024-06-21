// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello {exp1}!`
  String Hello(Object exp1) {
    return Intl.message(
      'Hello $exp1!',
      name: 'Hello',
      desc: '',
      args: [exp1],
    );
  }

  /// `Welcome to Healtha`
  String get Welcome_to_Healtha {
    return Intl.message(
      'Welcome to Healtha',
      name: 'Welcome_to_Healtha',
      desc: '',
      args: [],
    );
  }

  /// `Popular Laboratory Tests`
  String get Popular_Laboratory_Tests {
    return Intl.message(
      'Popular Laboratory Tests',
      name: 'Popular_Laboratory_Tests',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get See_All {
    return Intl.message(
      'See All',
      name: 'See_All',
      desc: '',
      args: [],
    );
  }

  /// `Explore healtha encyclopedias`
  String get Explore_healtha_encyclopedias {
    return Intl.message(
      'Explore healtha encyclopedias',
      name: 'Explore_healtha_encyclopedias',
      desc: '',
      args: [],
    );
  }

  /// `Lab analysis encyclopedia and diseases encyclopedia`
  String get Lab_analysis_encyclopedia_and_diseases_encyclopedia {
    return Intl.message(
      'Lab analysis encyclopedia and diseases encyclopedia',
      name: 'Lab_analysis_encyclopedia_and_diseases_encyclopedia',
      desc: '',
      args: [],
    );
  }

  /// `Generate Laboratory Test Report `
  String get Generate_Laboratory_Test_Report {
    return Intl.message(
      'Generate Laboratory Test Report ',
      name: 'Generate_Laboratory_Test_Report',
      desc: '',
      args: [],
    );
  }

  /// `Discover how could you get your lab report via Healtha!`
  String get Discover_how_could_you_get_your_lab_report_via_Healtha {
    return Intl.message(
      'Discover how could you get your lab report via Healtha!',
      name: 'Discover_how_could_you_get_your_lab_report_via_Healtha',
      desc: '',
      args: [],
    );
  }

  /// `Track your symptoms`
  String get Track_your_symptoms {
    return Intl.message(
      'Track your symptoms',
      name: 'Track_your_symptoms',
      desc: '',
      args: [],
    );
  }

  /// `Make use of the diseases prediction feature and show your symptomes`
  String
      get Make_use_of_the_diseases_prediction_feature_and_show_your_symptomes {
    return Intl.message(
      'Make use of the diseases prediction feature and show your symptomes',
      name:
          'Make_use_of_the_diseases_prediction_feature_and_show_your_symptomes',
      desc: '',
      args: [],
    );
  }

  /// `Dive into medical wisdom!`
  String get Dive_into_medical_wisdom {
    return Intl.message(
      'Dive into medical wisdom!',
      name: 'Dive_into_medical_wisdom',
      desc: '',
      args: [],
    );
  }

  /// `your pocket health encyclopedia`
  String get your_pocket_health_encyclopedia {
    return Intl.message(
      'your pocket health encyclopedia',
      name: 'your_pocket_health_encyclopedia',
      desc: '',
      args: [],
    );
  }

  /// `Join app`
  String get Join_app {
    return Intl.message(
      'Join app',
      name: 'Join_app',
      desc: '',
      args: [],
    );
  }

  /// `Lab Test Details:`
  String get Lab_Test_Details {
    return Intl.message(
      'Lab Test Details:',
      name: 'Lab_Test_Details',
      desc: '',
      args: [],
    );
  }

  /// `Name: {exp1}`
  String Name(Object exp1) {
    return Intl.message(
      'Name: $exp1',
      name: 'Name',
      desc: '',
      args: [exp1],
    );
  }

  /// `{exp1} Encyclopedia`
  String Encyclopedia(Object exp1) {
    return Intl.message(
      '$exp1 Encyclopedia',
      name: 'Encyclopedia',
      desc: '',
      args: [exp1],
    );
  }

  /// `Failed to load data`
  String get Failed_to_load_data {
    return Intl.message(
      'Failed to load data',
      name: 'Failed_to_load_data',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get Search {
    return Intl.message(
      'Search...',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get Get_Started {
    return Intl.message(
      'Get Started',
      name: 'Get_Started',
      desc: '',
      args: [],
    );
  }

  /// `welcome to`
  String get welcome_to {
    return Intl.message(
      'welcome to',
      name: 'welcome_to',
      desc: '',
      args: [],
    );
  }

  /// `Healtha`
  String get Healtha {
    return Intl.message(
      'Healtha',
      name: 'Healtha',
      desc: '',
      args: [],
    );
  }

  /// `Medical knowledge in your pocket. Explore medical encyclopedias`
  String get Medical_knowledge_in_your_pocket_Explore_medical_encyclopedias {
    return Intl.message(
      'Medical knowledge in your pocket. Explore medical encyclopedias',
      name: 'Medical_knowledge_in_your_pocket_Explore_medical_encyclopedias',
      desc: '',
      args: [],
    );
  }

  /// `Laboratory tests analysis made easy`
  String get Laboratory_tests_analysis_made_easy {
    return Intl.message(
      'Laboratory tests analysis made easy',
      name: 'Laboratory_tests_analysis_made_easy',
      desc: '',
      args: [],
    );
  }

  /// `Diseases prediction made easy. Consultation with specialists`
  String get Diseases_prediction_made_easy_Consultation_with_specialists {
    return Intl.message(
      'Diseases prediction made easy. Consultation with specialists',
      name: 'Diseases_prediction_made_easy_Consultation_with_specialists',
      desc: '',
      args: [],
    );
  }

  /// `Proactive health starts here. Insights with smart reports`
  String get Proactive_health_starts_here_Insights_with_smart_reports {
    return Intl.message(
      'Proactive health starts here. Insights with smart reports',
      name: 'Proactive_health_starts_here_Insights_with_smart_reports',
      desc: '',
      args: [],
    );
  }

  /// `Step into a world of holistic\nhealth with`
  String get Step_into_a_world_of_holistic_nhealth_with {
    return Intl.message(
      'Step into a world of holistic\nhealth with',
      name: 'Step_into_a_world_of_holistic_nhealth_with',
      desc: '',
      args: [],
    );
  }

  /// ` \nHealtha`
  String get nHealtha {
    return Intl.message(
      ' \nHealtha',
      name: 'nHealtha',
      desc: '',
      args: [],
    );
  }

  /// `Show encyclopedia`
  String get Show_encyclopedia {
    return Intl.message(
      'Show encyclopedia',
      name: 'Show_encyclopedia',
      desc: '',
      args: [],
    );
  }

  /// `Start using app`
  String get Start_using_app {
    return Intl.message(
      'Start using app',
      name: 'Start_using_app',
      desc: '',
      args: [],
    );
  }

  /// `Hey! \nI am here to read the page for you`
  String get Hey_nI_am_here_to_read_the_page_for_you {
    return Intl.message(
      'Hey! \nI am here to read the page for you',
      name: 'Hey_nI_am_here_to_read_the_page_for_you',
      desc: '',
      args: [],
    );
  }

  /// `Roboto`
  String get Roboto {
    return Intl.message(
      'Roboto',
      name: 'Roboto',
      desc: '',
      args: [],
    );
  }

  /// `Your Saved Reports`
  String get Your_Saved_Reports {
    return Intl.message(
      'Your Saved Reports',
      name: 'Your_Saved_Reports',
      desc: '',
      args: [],
    );
  }

  /// `Um Mohamed Elshazly`
  String get Um_Mohamed_Elshazly {
    return Intl.message(
      'Um Mohamed Elshazly',
      name: 'Um_Mohamed_Elshazly',
      desc: '',
      args: [],
    );
  }

  /// `CBC`
  String get CBC {
    return Intl.message(
      'CBC',
      name: 'CBC',
      desc: '',
      args: [],
    );
  }

  /// `Your reports`
  String get Your_reports {
    return Intl.message(
      'Your reports',
      name: 'Your_reports',
      desc: '',
      args: [],
    );
  }

  /// `Generated Reports`
  String get Generated_Reports {
    return Intl.message(
      'Generated Reports',
      name: 'Generated_Reports',
      desc: '',
      args: [],
    );
  }

  /// `Saved Reports`
  String get Saved_Reports {
    return Intl.message(
      'Saved Reports',
      name: 'Saved_Reports',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get History {
    return Intl.message(
      'History',
      name: 'History',
      desc: '',
      args: [],
    );
  }

  /// `Proactive health starts here!`
  String get Proactive_health_starts_here {
    return Intl.message(
      'Proactive health starts here!',
      name: 'Proactive_health_starts_here',
      desc: '',
      args: [],
    );
  }

  /// `Unlocking insights with smart reports`
  String get Unlocking_insights_with_smart_reports {
    return Intl.message(
      'Unlocking insights with smart reports',
      name: 'Unlocking_insights_with_smart_reports',
      desc: '',
      args: [],
    );
  }

  /// `Upload your lab analysis results`
  String get Upload_your_lab_analysis_results {
    return Intl.message(
      'Upload your lab analysis results',
      name: 'Upload_your_lab_analysis_results',
      desc: '',
      args: [],
    );
  }

  /// `Generate another report`
  String get Generate_another_report {
    return Intl.message(
      'Generate another report',
      name: 'Generate_another_report',
      desc: '',
      args: [],
    );
  }

  /// ` or `
  String get or {
    return Intl.message(
      ' or ',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `return home`
  String get return_home {
    return Intl.message(
      'return home',
      name: 'return_home',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get Generate {
    return Intl.message(
      'Generate',
      name: 'Generate',
      desc: '',
      args: [],
    );
  }

  /// `Healtha Report`
  String get Healtha_Report {
    return Intl.message(
      'Healtha Report',
      name: 'Healtha_Report',
      desc: '',
      args: [],
    );
  }

  /// `Translate this report `
  String get Translate_this_report {
    return Intl.message(
      'Translate this report ',
      name: 'Translate_this_report',
      desc: '',
      args: [],
    );
  }

  /// `Browse File`
  String get Browse_File {
    return Intl.message(
      'Browse File',
      name: 'Browse_File',
      desc: '',
      args: [],
    );
  }

  /// `Error : {exp1}`
  String Error(Object exp1) {
    return Intl.message(
      'Error : $exp1',
      name: 'Error',
      desc: '',
      args: [exp1],
    );
  }

  /// `Flutter AI Integration`
  String get Flutter_AI_Integration {
    return Intl.message(
      'Flutter AI Integration',
      name: 'Flutter_AI_Integration',
      desc: '',
      args: [],
    );
  }

  /// `Fetch AI Result`
  String get Fetch_AI_Result {
    return Intl.message(
      'Fetch AI Result',
      name: 'Fetch_AI_Result',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password`
  String get Invalid_email_or_password {
    return Intl.message(
      'Invalid email or password',
      name: 'Invalid_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get OK {
    return Intl.message(
      'OK',
      name: 'OK',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get Log_In {
    return Intl.message(
      'Log In',
      name: 'Log_In',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get Sign_Up {
    return Intl.message(
      'Sign Up',
      name: 'Sign_Up',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Don''t have an account?`
  String get Don_t_have_an_account {
    return Intl.message(
      'Don\'\'t have an account?',
      name: 'Don_t_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Join as :`
  String get Join_as {
    return Intl.message(
      'Join as :',
      name: 'Join_as',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get Doctor {
    return Intl.message(
      'Doctor',
      name: 'Doctor',
      desc: '',
      args: [],
    );
  }

  /// `Patient`
  String get Patient {
    return Intl.message(
      'Patient',
      name: 'Patient',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Themes`
  String get Themes {
    return Intl.message(
      'Themes',
      name: 'Themes',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch user data`
  String get Failed_to_fetch_user_data {
    return Intl.message(
      'Failed to fetch user data',
      name: 'Failed_to_fetch_user_data',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get Menu {
    return Intl.message(
      'Menu',
      name: 'Menu',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get Favorites {
    return Intl.message(
      'Favorites',
      name: 'Favorites',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get Saved {
    return Intl.message(
      'Saved',
      name: 'Saved',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get Help_Support {
    return Intl.message(
      'Help & Support',
      name: 'Help_Support',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get Privacy {
    return Intl.message(
      'Privacy',
      name: 'Privacy',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get Log_Out {
    return Intl.message(
      'Log Out',
      name: 'Log_Out',
      desc: '',
      args: [],
    );
  }

  /// `patient`
  String get patient {
    return Intl.message(
      'patient',
      name: 'patient',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get Phone_Number {
    return Intl.message(
      'Phone Number',
      name: 'Phone_Number',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get Date_of_Birth {
    return Intl.message(
      'Date of Birth',
      name: 'Date_of_Birth',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully, \nWELCOME {exp1} TO HEALTHA !`
  String Account_created_successfully_nWELCOME_TO_HEALTHA(Object exp1) {
    return Intl.message(
      'Account created successfully, \nWELCOME $exp1 TO HEALTHA !',
      name: 'Account_created_successfully_nWELCOME_TO_HEALTHA',
      desc: '',
      args: [exp1],
    );
  }

  /// `Sign-up failed. Please try again ..`
  String get Sign_up_failed_Please_try_again {
    return Intl.message(
      'Sign-up failed. Please try again ..',
      name: 'Sign_up_failed_Please_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get Gender {
    return Intl.message(
      'Gender',
      name: 'Gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get Male {
    return Intl.message(
      'Male',
      name: 'Male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get Female {
    return Intl.message(
      'Female',
      name: 'Female',
      desc: '',
      args: [],
    );
  }

  /// `Have an account?`
  String get Have_an_account {
    return Intl.message(
      'Have an account?',
      name: 'Have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get Log_in {
    return Intl.message(
      'Log in',
      name: 'Log_in',
      desc: '',
      args: [],
    );
  }

  /// `Contact Info`
  String get Contact_Info {
    return Intl.message(
      'Contact Info',
      name: 'Contact_Info',
      desc: '',
      args: [],
    );
  }

  /// `Your health, our priority!`
  String get Your_health_our_priority {
    return Intl.message(
      'Your health, our priority!',
      name: 'Your_health_our_priority',
      desc: '',
      args: [],
    );
  }

  /// `Disease prediction made easy`
  String get Disease_prediction_made_easy {
    return Intl.message(
      'Disease prediction made easy',
      name: 'Disease_prediction_made_easy',
      desc: '',
      args: [],
    );
  }

  /// `What are you feeling?`
  String get What_are_you_feeling {
    return Intl.message(
      'What are you feeling?',
      name: 'What_are_you_feeling',
      desc: '',
      args: [],
    );
  }

  /// `Predict Disease`
  String get Predict_Disease {
    return Intl.message(
      'Predict Disease',
      name: 'Predict_Disease',
      desc: '',
      args: [],
    );
  }

  /// `Predicted Disease: {exp1}`
  String Predicted_Disease(Object exp1) {
    return Intl.message(
      'Predicted Disease: $exp1',
      name: 'Predicted_Disease',
      desc: '',
      args: [exp1],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Name`
  String get Enter_your_Name {
    return Intl.message(
      'Enter your Name',
      name: 'Enter_your_Name',
      desc: '',
      args: [],
    );
  }

  /// `Patient / Doctor`
  String get Patient_Doctor {
    return Intl.message(
      'Patient / Doctor',
      name: 'Patient_Doctor',
      desc: '',
      args: [],
    );
  }


  /// `Enter your email`
  String get Enter_your_email {
    return Intl.message(
      'Enter your email',
      name: 'Enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Phone Number`
  String get Enter_your_Phone_Number {
    return Intl.message(
      'Enter your Phone Number',
      name: 'Enter_your_Phone_Number',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Address`
  String get Enter_your_Address {
    return Intl.message(
      'Enter your Address',
      name: 'Enter_your_Address',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Chatting`
  String get Chatting {
    return Intl.message(
      'Chatting',
      name: 'Chatting',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notifications {
    return Intl.message(
      'Notifications',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `Notification Center`
  String get Notification_Center {
    return Intl.message(
      'Notification Center',
      name: 'Notification_Center',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get Today {
    return Intl.message(
      'Today',
      name: 'Today',
      desc: '',
      args: [],
    );
  }

  /// `This Week`
  String get This_Week {
    return Intl.message(
      'This Week',
      name: 'This_Week',
      desc: '',
      args: [],
    );
  }

  /// `Later Reports`
  String get Later_Reports {
    return Intl.message(
      'Later Reports',
      name: 'Later_Reports',
      desc: '',
      args: [],
    );
  }

  /// `Your CBC Test Report is ready`
  String get Your_CBC_Test_Report_is_ready {
    return Intl.message(
      'Your CBC Test Report is ready',
      name: 'Your_CBC_Test_Report_is_ready',
      desc: '',
      args: [],
    );
  }

  /// `view`
  String get view {
    return Intl.message(
      'view',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded on {exp1}`
  String Uploaded_on(Object exp1) {
    return Intl.message(
      'Uploaded on $exp1',
      name: 'Uploaded_on',
      desc: '',
      args: [exp1],
    );
  }

  /// `No lab test found`
  String get No_lab_test_found {
    return Intl.message(
      'No lab test found',
      name: 'No_lab_test_found',
      desc: '',
      args: [],
    );
  }

  /// `Sections:`
  String get Sections {
    return Intl.message(
      'Sections:',
      name: 'Sections',
      desc: '',
      args: [],
    );
  }

  /// `Dear lab doctor ,`
  String get Dear_lab_doctor {
    return Intl.message(
      'Dear lab doctor ,',
      name: 'Dear_lab_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Please take the time to revise the reports thoroughly.`
  String get Please_take_the_time_to_revise_the_reports_thoroughly {
    return Intl.message(
      'Please take the time to revise the reports thoroughly.',
      name: 'Please_take_the_time_to_revise_the_reports_thoroughly',
      desc: '',
      args: [],
    );
  }

  /// `View report`
  String get View_report {
    return Intl.message(
      'View report',
      name: 'View_report',
      desc: '',
      args: [],
    );
  }

  /// `Top Doctors`
  String get Top_Doctors {
    return Intl.message(
      'Top Doctors',
      name: 'Top_Doctors',
      desc: '',
      args: [],
    );
  }

  /// `Requested Reports`
  String get Requested_Reports {
    return Intl.message(
      'Requested Reports',
      name: 'Requested_Reports',
      desc: '',
      args: [],
    );
  }

  /// `Report ID: {exp1}`
  String Report_ID(Object exp1) {
    return Intl.message(
      'Report ID: $exp1',
      name: 'Report_ID',
      desc: '',
      args: [exp1],
    );
  }

  /// `CBC Test`
  String get CBC_Test {
    return Intl.message(
      'CBC Test',
      name: 'CBC_Test',
      desc: '',
      args: [],
    );
  }

  /// `Report updated successfully`
  String get Report_updated_successfully {
    return Intl.message(
      'Report updated successfully',
      name: 'Report_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Report confirmed and notification sent`
  String get Report_confirmed_and_notification_sent {
    return Intl.message(
      'Report confirmed and notification sent',
      name: 'Report_confirmed_and_notification_sent',
      desc: '',
      args: [],
    );
  }

  /// `Failed to confirm report`
  String get Failed_to_confirm_report {
    return Intl.message(
      'Failed to confirm report',
      name: 'Failed_to_confirm_report',
      desc: '',
      args: [],
    );
  }

  /// `Report confirmed successfully`
  String get Report_confirmed_successfully {
    return Intl.message(
      'Report confirmed successfully',
      name: 'Report_confirmed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get Confirm {
    return Intl.message(
      'Confirm',
      name: 'Confirm',
      desc: '',
      args: [],
    );
  }

  /// `Enter report text`
  String get Enter_report_text {
    return Intl.message(
      'Enter report text',
      name: 'Enter_report_text',
      desc: '',
      args: [],
    );
  }

  /// `Error updating report: {exp1}`
  String Error_updating_report(Object exp1) {
    return Intl.message(
      'Error updating report: $exp1',
      name: 'Error_updating_report',
      desc: '',
      args: [exp1],
    );
  }

  /// `Type something`
  String get Type_something {
    return Intl.message(
      'Type something',
      name: 'Type_something',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get You {
    return Intl.message(
      'You',
      name: 'You',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get Username {
    return Intl.message(
      'Username',
      name: 'Username',
      desc: '',
      args: [],
    );
  }

  /// `Contact Information`
  String get Contact_Information {
    return Intl.message(
      'Contact Information',
      name: 'Contact_Information',
      desc: '',
      args: [],
    );
  }

  /// `Specialization`
  String get Specialization {
    return Intl.message(
      'Specialization',
      name: 'Specialization',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get Incorrect_password {
    return Intl.message(
      'Incorrect password',
      name: 'Incorrect_password',
      desc: '',
      args: [],
    );
  }

  /// `user`
  String get user {
    return Intl.message(
      'user',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Patients`
  String get Patients {
    return Intl.message(
      'Patients',
      name: 'Patients',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get Experience {
    return Intl.message(
      'Experience',
      name: 'Experience',
      desc: '',
      args: [],
    );
  }

  /// `Dr. `
  String get Dr {
    return Intl.message(
      'Dr. ',
      name: 'Dr',
      desc: '',
      args: [],
    );
  }

  /// `Complete Your Info`
  String get Complete_Your_Info {
    return Intl.message(
      'Complete Your Info',
      name: 'Complete_Your_Info',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Complete your info`
  String get Complete_your_info {
    return Intl.message(
      'Complete your info',
      name: 'Complete_your_info',
      desc: '',
      args: [],
    );
  }

  /// `Enter your skills`
  String get Enter_your_skills {
    return Intl.message(
      'Enter your skills',
      name: 'Enter_your_skills',
      desc: '',
      args: [],
    );
  }

  /// `Enter your qualifications`
  String get Enter_your_qualifications {
    return Intl.message(
      'Enter your qualifications',
      name: 'Enter_your_qualifications',
      desc: '',
      args: [],
    );
  }

  /// `Skills`
  String get Skills {
    return Intl.message(
      'Skills',
      name: 'Skills',
      desc: '',
      args: [],
    );
  }

  /// `Qualifications`
  String get Qualifications {
    return Intl.message(
      'Qualifications',
      name: 'Qualifications',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Discover All Doctors`
  String get Discover_All_Doctors {
    return Intl.message(
      'Discover All Doctors',
      name: 'Discover_All_Doctors',
      desc: '',
      args: [],
    );
  }

  /// `Search by name, location or specialty`
  String get Search_by_name_location_or_specialty {
    return Intl.message(
      'Search by name, location or specialty',
      name: 'Search_by_name_location_or_specialty',
      desc: '',
      args: [],
    );
  }

  /// `Healtha`
  String get app_name {
    return Intl.message(
      'Healtha',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Medical knowledge in your pocket. Explore medical encyclopedias`
  String get description_1 {
    return Intl.message(
      'Medical knowledge in your pocket. Explore medical encyclopedias',
      name: 'description_1',
      desc: '',
      args: [],
    );
  }

  /// `Laboratory tests analysis made easy`
  String get description_2 {
    return Intl.message(
      'Laboratory tests analysis made easy',
      name: 'description_2',
      desc: '',
      args: [],
    );
  }

  /// `Diseases prediction made easy. Consultation with specialists`
  String get description_3 {
    return Intl.message(
      'Diseases prediction made easy. Consultation with specialists',
      name: 'description_3',
      desc: '',
      args: [],
    );
  }

  /// `Proactive health starts here. Insights with smart reports`
  String get description_4 {
    return Intl.message(
      'Proactive health starts here. Insights with smart reports',
      name: 'description_4',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get Text_Get_Started {
    return Intl.message(
      'Get Started',
      name: 'Text_Get_Started',
      desc: '',
      args: [],
    );
  }

  /// `welcome to`
  String get List_welcome_message {
    return Intl.message(
      'welcome to',
      name: 'List_welcome_message',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
