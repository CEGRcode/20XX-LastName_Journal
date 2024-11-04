#!/bin/bash

# Organize data from X_Bulk_Processing into Z_Figures

### CHANGE ME
WRK=/path/to/20XX-LastName_Journal/Z_Figures
###

LIBRARY=$WRK/../X_Bulk_Processing/Library

# ===============================================================================================================================

[ -d F1 ] || mkdir F1

[ -d F1/a ] || mkdir F1/a
# cp $LIBRARY/MyReferencePointOfInterest_2000bp/SVG/Sample1_MyReferencePointOfInterest_2000bp_5read1_merge_treeview_label.svg F1/a/

[ -d F1/b ] || mkdir F1/b
# cp $LIBRARY/MyReferencePointOfInterest_2000bp/Composite/Sample1_MyReferencePointOfInterest_2000bp_5read1.out F1/b/

#...

# ===============================================================================================================================

[ -d F2 ] || mkdir F2

[ -d F2/a ] || mkdir F2/a

[ -d F2/b ] || mkdir F2/b

#...