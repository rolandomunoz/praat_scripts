#Copyright 2017 Rolando Muñoz
## Add information from the donor tier to the recipient tiers
include ../procedures/is_point_empty.proc

form Join point tiers
  natural Recipient_tier 
  natural Donor_tier 
endform

donor_n_points = Get number of points: donor_tier
for donor_point to donor_n_points
  donor_point_time = Get time of point: donor_tier, donor_point
  donor_point_label$ = Get label of point: donor_tier, donor_point
  @isPointEmpty: recipient_tier, donor_point_time
  if isPointEmpty.return
    Insert point: recipient_tier, donor_point_time, donor_point_label$
  endif
endfor