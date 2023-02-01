def calculate_gross_wpm(all_typed_entries, time)
  gross_wpm = (all_typed_entries/5)/time
  return gross_wpm


def calculate_net_wpm(all_typed_entries, time, uncorrected_errors)
  net_wpm = calculate_gross_wpm(all_typed_entries, time) - (uncorrected_errors/time)
  return net_wpm


def calculate_accuracy(errors, all_typed_entries)
  accuracy = (errors/all_typed_entries)*100
  return accuracy
