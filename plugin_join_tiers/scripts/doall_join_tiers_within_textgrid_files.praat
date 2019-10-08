#Copyright 2018 Rolando Muñoz
include ../procedures/list_recursive_path.proc

form Merge tiers within TextGrid files
  comment Input:
  sentence Folder_with_annotation_files
  boolean Recursive_search
  natural Donor_tier_positon
  natural Recipient_tier_position
endform

@createStringAsFileList: "fileList",  folder_with_annotation_files$ + "/*TextGrid", recursive_search
fileList = createStringAsFileList.return
nFiles = Get number of strings

for iFile to nFiles
  tgPath$ = folder_with_annotation_files$ + "/" + object$[fileList, iFile]
  tg= Read from file: tgPath$
  runScript: "join_interval_tiers.praat", donor_tier_positon, recipient_tier_position
  
  selectObject: tg
  Save as text file: tgPath$
  removeObject: tg
endfor
