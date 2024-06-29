class ClassificationResult {
  // For an entry in this map, the key is the class name, and the value is how many times this class
  // appears in the top K nearest neighbors. The value is in range [0, K] and could be a float after
  // EMA smoothing. We use this number to represent the confidence of a pose being in this class.
  final Map<String, double> classConfidences;

  ClassificationResult() : classConfidences = {};

  Set<String> getAllClasses() {
    return classConfidences.keys.toSet();
  }

  double getClassConfidence(String className) {
    return classConfidences[className] ?? 0.0;
  }

  String getMaxConfidenceClass() {
    return classConfidences.entries
        .reduce((entry1, entry2) => entry1.value > entry2.value ? entry1 : entry2)
        .key;
  }

  void incrementClassConfidence(String className) {
    classConfidences[className] = classConfidences.containsKey(className)
        ? classConfidences[className]! + 1
        : 1;
  }

  void putClassConfidence(String className, double confidence) {
    classConfidences[className] = confidence;
  }
}
