// module/core/utils/launcher_utils.dart

import 'package:url_launcher/url_launcher.dart';

/// A utility function to make a phone call.
/// E.g., `05xxxxxxxxxx`
/// If [phoneNumber] is null or empty, no action will be taken.
Future<void> launchPhoneCall(String? phoneNumber) async {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    // Optionally, you can log a message here if you want to know when it happens.
    // print('Phone number is null or empty. No call initiated.');
    return;
  }
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  if (!await launchUrl(launchUri)) {
    throw Exception('Failed to launch phone call: $phoneNumber');
  }
}

/// A utility function to send an email.
/// Subject and body are optional.
/// E.g., `support@example.com`, `Help Request`, `I have a problem...`
/// If [emailAddress] is null or empty, no action will be taken.
Future<void> launchEmail(String? emailAddress, {String subject = '', String body = ''}) async {
  if (emailAddress == null || emailAddress.isEmpty) {
    // Optionally, you can log a message here.
    // print('Email address is null or empty. No email initiated.');
    return;
  }
  final Uri launchUri = Uri(scheme: 'mailto', path: emailAddress, queryParameters: {'subject': subject, 'body': body});
  if (!await launchUrl(launchUri)) {
    throw Exception('Failed to launch email: $emailAddress');
  }
}

/// A utility function to open the map application using latitude and longitude.
/// E.g., `38.4237`, `27.1428`
/// If [latitude] or [longitude] is null, no action will be taken.
Future<void> launchMapWithLatLng(double? latitude, double? longitude) async {
  if (latitude == null || longitude == null) {
    // Optionally, you can log a message here.
    // print('Latitude or longitude is null. No map opened.');
    return;
  }
  final Uri launchUri = Uri.parse('geo:$latitude,$longitude');
  if (!await launchUrl(launchUri)) {
    throw Exception('Failed to open map: Latitude=$latitude, Longitude=$longitude');
  }
}

/// A utility function to open the map application using an address string.
/// Uses Google Maps query URL.
/// E.g., `Izmir Konak Square`
/// If [address] is null or empty, no action will be taken.
Future<void> launchMapWithAddress(String? address) async {
  if (address == null || address.isEmpty) {
    // Optionally, you can log a message here.
    // print('Address is null or empty. No map opened.');
    return;
  }
  final String encodedAddress = Uri.encodeComponent(address);
  final Uri launchUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedAddress');
  if (!await launchUrl(launchUri)) {
    throw Exception('Failed to open map: Address=$address');
  }
}

/// A general utility function to launch any web URL in the default browser.
/// If [url] is null or empty, no action will be taken.
Future<void> launchWebUrl(String? url) async {
  if (url == null || url.isEmpty) {
    // Optionally, you can log a message here.
    // print('URL is null or empty. No web page opened.');
    return;
  }
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    // Opens in the default browser
    throw Exception('Failed to launch URL: $url');
  }
}
