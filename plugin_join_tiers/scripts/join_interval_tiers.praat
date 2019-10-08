#Copyright 2017 Rolando Munoz
## Add information from the donor tier to the recipient tiers
include ../procedures/is_interval_empty.proc

form Join interval tiers
  natural Donor_tier
  natural Recipient_tier
endform

donor_n_intervals = Get number of intervals: donor_tier
for donor_interval to donor_n_intervals
  donor_interval_tmin = Get start time of interval: donor_tier, donor_interval
  donor_interval_tmax = Get end time of interval: donor_tier, donor_interval
  donor_interval_text$ = Get label of interval: donor_tier, donor_interval
  donor_interval_tmid = (donor_interval_tmin + donor_interval_tmax)*0.5

  if donor_interval_text$ <> ""
    @isIntervalEmpty: recipient_tier, donor_interval_tmin, donor_interval_tmax
    if isIntervalEmpty.return
      # Modify interval tier
      nocheck Insert boundary: recipient_tier, donor_interval_tmin
      nocheck Insert boundary: recipient_tier, donor_interval_tmax
      recipient_interval = Get interval at time: recipient_tier, donor_interval_tmid
      Set interval text: recipient_tier, recipient_interval, donor_interval_text$
    endif
  endif
endfor
