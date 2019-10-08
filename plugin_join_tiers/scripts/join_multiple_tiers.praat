#Copyright 2017 Rolando Muñoz

form Join multiple tiers
  boolean Remove_donor_tiers 1
endform 

Merge

# After merged
n_tiers = Get number of tiers
for recipient_tier to n_tiers
  recipient_tier$ = Get tier name: recipient_tier
  recipient_is_interval_tier = Is interval tier: recipient_tier
  if not startsWith(recipient_tier$, ".")
    for donor_tier from recipient_tier+1 to n_tiers
      donor_tier$ = Get tier name: donor_tier
      donor_is_interval_tier = Is interval tier: donor_tier
      if donor_is_interval_tier = recipient_is_interval_tier
        if donor_tier$ = recipient_tier$
          if donor_is_interval_tier
            runScript: "join_interval_tiers.praat", donor_tier, recipient_tier
          else
            runScript: "join_point_tiers.praat", donor_tier, recipient_tier
          endif
          Set tier name: donor_tier, "." + donor_tier$
        endif
      endif
    endfor
  endif
endfor

# Remove donor tiers
if remove_donor_tiers
  n_tiers = Get number of tiers
  for tier to n_tiers
    tier$ = Get tier name: tier
    if startsWith(tier$, ".")
      Remove tier: tier
      n_tiers -=1
      tier-=1
    endif
  endfor
endif
