//translate([0,0*19,0])
//rotate([0,0,180])
//mirror([0,0,0])
scale([1,1,1.3])
import("STL/MT3-1u-space.stl");

showReference=false;
if (showReference) {
color( "blue", 0.7 )
    //translate([0,0,0])
    scale([1,1,1])
    rotate([0,0,90])
    import("STL/SA-R1.stl");
}