// lib/utils/loyalty_utils.dart

import 'package:flutter/material.dart';

/// Global check for tier status
bool isGoldTier(int activityCount, {int threshold = 3}) {
  return activityCount >= threshold;
}

/// Global utility to get tier label
String getTierLabel(int activityCount, {int threshold = 3}) {
  return isGoldTier(activityCount, threshold: threshold) ? "GOLD TIER VETERAN" : "ROOKIE";
}

/// Global utility to get tier color
Color getTierColor(int activityCount, {int threshold = 3}) {
  return isGoldTier(activityCount, threshold: threshold) ? Colors.amber : Colors.grey;
}

/// Global utility to get tier description
String getTierDescription(int activityCount, {int threshold = 3}) {
  return isGoldTier(activityCount, threshold: threshold) 
      ? "You have unlocked the Black & Gold UI Theme." 
      : "Stay active for $threshold months to unlock exclusive themes.";
}
