import 'dart:math';

class OfflineStatisticsCalc {
  static double mean(List<double> data) => data.reduce((a, b) => a + b) / data.length;
  
  static double variance(List<double> data) {
    double m = mean(data);
    double sumSq = data.map((x) => pow(x - m, 2)).reduce((a, b) => a + b).toDouble();
    return sumSq / data.length;
  }
  
  static double standardDeviation(List<double> data) => sqrt(variance(data));
}