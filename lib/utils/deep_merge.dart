Map<String, dynamic> deepMerge(
  Map<String, dynamic> jsonBase,
  Map<String, dynamic> jsonOverrides,
) {
  Map<String, dynamic> mergedJson = {...jsonBase, ...jsonOverrides};

  for (var key in jsonBase.keys) {
    final val = jsonBase[key];
    if (val is Map<String, dynamic>) {
      Map<String, dynamic> jsonOverridesValueOfKey = jsonOverrides[key] ?? {};
      mergedJson[key] = deepMerge(val, jsonOverridesValueOfKey);
    }
  }

  return mergedJson;
}

String randomId() {
  return "";
}
