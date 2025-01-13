


double transformToRange(
  double input,
  double minInput,
  double maxInput,
  double minOutput,
  double maxOutput, {
  bool reverseOutput = false,
}) {
  // Verifica que los límites sean válidos
  if (minInput >= maxInput) {
    throw ArgumentError("minInput no puede ser mayor y tampoco igual a maxInput.");
  }

  if (reverseOutput) {
    // Invierte los valores de salida
    double temp = minOutput;
    minOutput = maxOutput;
    maxOutput = temp;
  }

  // Clampea el input al rango de entrada
  double clampedInput = input.clamp(minInput, maxInput);

  // Transforma el valor al rango de salida
  double transformedValue = minOutput + (clampedInput - minInput) *
   (maxOutput - minOutput) / 
   (maxInput - minInput);

  return transformedValue;
}
