#Copyright 2017 Rolando Muñoz

form Join multiple tiers
  comment Input:
  sentence Recipient_TextGrid_folder 
  sentence Donor_TextGrid_folder 
  comment Output:
  sentence Save_in 
  boolean Remove_donor_tier 1
endform

recipient_fileList = Create Strings as file list: "fileList", recipient_TextGrid_folder$ + "/*.TextGrid"
recipient_nFiles = Get number of strings
donor_fileList = Create Strings as file list: "fileList", donor_TextGrid_folder$ + "/*.TextGrid"
donor_nFiles = Get number of strings

for iFile to recipient_nFiles
  id_max = 1
  recipient_tg_name$ = object$[recipient_fileList, iFile]
  recipient_tg_path$ = recipient_TextGrid_folder$ + "/" + recipient_tg_name$
  tg[id_max] = Read from file: recipient_tg_path$

  for jFile to donor_nFiles
    donor_tg_name$ = object$[donor_fileList, jFile]
    donor_tg_path$ = donor_TextGrid_folder$ + "/" + donor_tg_name$
    if recipient_tg_name$ == donor_tg_name$
      id_max +=1
      tg[id_max] = Read from file: donor_tg_path$
    endif
  endfor
  
  for id to id_max
    if id = 1
      selectObject: tg[id]
    else
      plusObject: tg[id]
    endif
  endfor
  runScript: "join_multiple_tiers.praat", remove_donor_tier
  tg = selected("TextGrid")
  for id to id_max
    removeObject: tg[id]
  endfor
  
  selectObject: tg
  Save as text file: save_in$ + "/" + recipient_tg_name$
  removeObject: tg
endfor
