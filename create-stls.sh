# based on similar changes from alexoterof in okke-formsma/dactyl-manuform-tight

# MAC
OPEN_SCAD='/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD'

# WINDOWS
# OPEN_SCAD='openscad.com'

INPUTFILE='DES_Plus.scad'
OUTPUTDIR='STL'

echo 'Rendering '$OUTPUTDIR'/*.stl files from '$INPUTFILE' using ...'
$OPEN_SCAD -v

#$OPEN_SCAD $INPUTFILE -D keyIndex=0 -o $OUTPUTDIR/R3.stl >/dev/null 2>&1 & echo 'Rendered R3.stl' &&
cp $INPUTFILE 1$INPUTFILE && $OPEN_SCAD 1$INPUTFILE -D keyIndex=1 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R1.stl >/dev/null 2>&1 && rm 1$INPUTFILE && echo 'Rendered R1.stl' &
cp $INPUTFILE 2$INPUTFILE && $OPEN_SCAD 2$INPUTFILE -D keyIndex=2 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R2.stl >/dev/null 2>&1 && rm 2$INPUTFILE && echo 'Rendered R2.stl' &
cp $INPUTFILE 3$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=3 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R3DD.stl >/dev/null 2>&1  && rm 3$INPUTFILE && echo 'Rendered R3DD.stl' &
cp $INPUTFILE 4$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=4 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R4.stl >/dev/null 2>&1  && rm 4$INPUTFILE && echo 'Rendered R4.stl' &
cp $INPUTFILE 5$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=5 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R5.stl >/dev/null 2>&1  && rm 5$INPUTFILE && echo 'Rendered R5.stl' &

cp $INPUTFILE 6$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=6  -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R1L.stl >/dev/null 2>&1  && rm 6$INPUTFILE && echo 'Rendered R1L.stl' &
cp $INPUTFILE 7$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=7  -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R2L.stl >/dev/null 2>&1  && rm 7$INPUTFILE && echo 'Rendered R2L.stl' &
cp $INPUTFILE 8$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=8  -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R3L.stl >/dev/null 2>&1  && rm 8$INPUTFILE && echo 'Rendered R3L.stl' &
cp $INPUTFILE 9$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=9  -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R4L.stl >/dev/null 2>&1  && rm 9$INPUTFILE && echo 'Rendered R4L.stl' &
#cp $INPUTFILE 10$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=10 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R5L.stl >/dev/null 2>&1  && rm 10$INPUTFILE && echo 'Rendered R5L.stl' &

cp $INPUTFILE 11$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=11 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R1R.stl >/dev/null 2>&1  && rm 11$INPUTFILE && echo 'Rendered R1R.stl' &
cp $INPUTFILE 12$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=12 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R2R.stl >/dev/null 2>&1  && rm 12$INPUTFILE && echo 'Rendered R2R.stl' &
cp $INPUTFILE 13$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=13 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R3R.stl >/dev/null 2>&1  && rm 13$INPUTFILE && echo 'Rendered R3R.stl' &
cp $INPUTFILE 14$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=14 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R4R.stl >/dev/null 2>&1  && rm 14$INPUTFILE && echo 'Rendered R4R.stl' &
#cp $INPUTFILE 15$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=15 -o $OUTPUTDIR/MX_DES_Plus_MT4.4_R5R.stl >/dev/null 2>&1  && rm 15$INPUTFILE && echo 'Rendered R5R.stl' &

#cp $INPUTFILE 16$INPUTFILE && $OPEN_SCAD $INPUTFILE -D keyIndex=16 -o $OUTPUTDIR/R1DESP.stl >/dev/null 2>&1  && rm 16$INPUTFILE && echo 'Rendered R1DESP.stl' &

echo 'Please wait for STL files to appear in '$OUTPUTDIR'/ directory!'
