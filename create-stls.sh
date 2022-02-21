# based on similar changes from alexoterof in okke-formsma/dactyl-manuform-tight

# MAC
OPEN_SCAD='/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD'

# WINDOWS
# OPEN_SCAD='openscad.com'

INPUTFILE='MX_DES_Standard.scad'
# INPUTFILE='DES_Plus.scad'
OUTPUTDIR='STL'

echo 'Rendering '$OUTPUTDIR'/*.stl files from '$INPUTFILE' using ...'
$OPEN_SCAD -v

#$OPEN_SCAD $INPUTFILE -D keyIndex=0 -o $OUTPUTDIR/MX_DES_MT4.5_R3.stl >/dev/null 2>&1 && echo 'Rendered R3.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=1 -o $OUTPUTDIR/MX_DES_MT4.5_R1.stl >/dev/null 2>&1 && echo 'Rendered R1.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=2 -o $OUTPUTDIR/MX_DES_MT4.5_R2.stl >/dev/null 2>&1 && echo 'Rendered R2.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=3 -o $OUTPUTDIR/MX_DES_MT4.5_R3DD.stl >/dev/null 2>&1 && echo 'Rendered R3DD.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=4 -o $OUTPUTDIR/MX_DES_MT4.5_R4.stl >/dev/null 2>&1 && echo 'Rendered R4.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=5 -o $OUTPUTDIR/MX_DES_MT4.5_R5.stl >/dev/null 2>&1 && echo 'Rendered R5.stl' &

$OPEN_SCAD $INPUTFILE -D keyIndex=6  -o $OUTPUTDIR/MX_DES_MT4.5_R1L.stl >/dev/null 2>&1 && echo 'Rendered R1L.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=7  -o $OUTPUTDIR/MX_DES_MT4.5_R2L.stl >/dev/null 2>&1 && echo 'Rendered R2L.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=8  -o $OUTPUTDIR/MX_DES_MT4.5_R3L.stl >/dev/null 2>&1 && echo 'Rendered R3L.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=9  -o $OUTPUTDIR/MX_DES_MT4.5_R4L.stl >/dev/null 2>&1 && echo 'Rendered R4L.stl' &
# $OPEN_SCAD $INPUTFILE -D keyIndex=10 -o $OUTPUTDIR/MX_DES_MT4.5_R5L.stl >/dev/null 2>&1 && echo 'Rendered R5L.stl' &

$OPEN_SCAD $INPUTFILE -D keyIndex=11 -o $OUTPUTDIR/MX_DES_MT4.5_R1R.stl >/dev/null 2>&1 && echo 'Rendered R1R.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=12 -o $OUTPUTDIR/MX_DES_MT4.5_R2R.stl >/dev/null 2>&1 && echo 'Rendered R2R.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=13 -o $OUTPUTDIR/MX_DES_MT4.5_R3R.stl >/dev/null 2>&1 && echo 'Rendered R3R.stl' &
$OPEN_SCAD $INPUTFILE -D keyIndex=14 -o $OUTPUTDIR/MX_DES_MT4.5_R4R.stl >/dev/null 2>&1 && echo 'Rendered R4R.stl' &
#$OPEN_SCAD $INPUTFILE -D keyIndex=15 -o $OUTPUTDIR/MX_DES_MT4.5_R5R.stl >/dev/null 2>&1 && echo 'Rendered R5R.stl' &

#$OPEN_SCAD $INPUTFILE -D keyIndex=16 -o $OUTPUTDIR/R1DESP.stl >/dev/null 2>&1 && echo 'Rendered R1DESP.stl' &

echo 'Please wait for STL files to appear in '$OUTPUTDIR'/ directory!'
