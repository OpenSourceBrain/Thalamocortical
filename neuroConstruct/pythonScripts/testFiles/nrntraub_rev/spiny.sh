#! /bin/bash

# run myonecell to chec
echo 'export_text(1)' | nrngui myonecell.hoc

# diff to see if there are differences
# diff .profile .profile~ --side-by-side --suppress-common-lines

if diff ss_mview_original.txt ss_mview_1.txt >/dev/null ; then
  echo Cell Mview Same
else
  echo Cell Mview Changed
	cp ss_mview_1.txt ss_mview_$(date +%Y%m%d_%H%M).txt
	compare ss_mview_original.txt ss_mview_1.txt
fi

