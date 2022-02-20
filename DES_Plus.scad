use <scad-utils/morphology.scad> //for cheaper minwoski 
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>
//use <z-butt.scad>
// Choc Chord version Chicago Stenographer with sculpte Thumb cluter
// change stemrot 
mx_al_tp_key = [
     "base_sx", 18.5,
     "base_sy", 18.5,
     "cavity_sx", 14.725,
//     "cavity_sx", 14.925,
     "cavity_sy", 14.725,
//     "cavity_sy", 14.925,
     "cavity_sz", 4.25,
//     "cavity_sz", 5.25,
//     "cavity_ch_xy", 2,
     "cavity_ch_xy", 1.9,
     "indent_inset", 3
     ];

CheckCross = false;
GlobalDish = true;
GlobalStem = true;
keyIndex = 3;

//translate([-39.5,-10.3,0])rotate([0,0,30])
keycap(
  keyID = keyIndex, //change profile refer to KeyParameters Struct
  Dish  = GlobalDish, //turn on dish cut
  Stem  = GlobalStem,
  crossSection  = false,
  visualizeDish = false, // turn on debug visual of Dish 
  Sym = true //turn on 2ndrary filled symetry 
); 
//    #key_cavity(key= mx_al_tp_key, xu=1, yu=1);

//-Parameters
wallthickness = 1.5; // 1.75 for mx size, 1.1
topthickness = 2.75; //2 for phat 3 for chicago
stepsize = 40;  //resolution of Trajectory
step = 40;      //resolution of ellipes 
slop = 0;
fn = 60;        //resolution of Rounded Rectangles: 60 for output
layers = 50;    //resolution of vertical Sweep: 50 for output

//---Stem param
Tol    = 0.01;
stemRot = 0;
stemWid = 5.5;
stemLen = 5.5;
stemCrossHeight = 3.5;
extra_vertical  = 0.6;
StemBrimDep     = 0.25; 
stemLayers      = 50; //resolution of stem to cap top transition
//#cube([18.16, 18.16, 10], center = true); // sanity check border

//injection param
draftAngle = 0; //degree  note:Stem Only
//TODO: Add wall thickness transition?
dishpow = 2; //power to dish depth transition
h = 1;
keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx
  [17.16, 17.16,  6.5,  7.5, 13.6,   0,   0,    4,      0,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //0 R3
  [17.16, 17.16,  6.5,  7.5, 16.6,   0,   0,   -4,      0,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //1 R1
  [17.16, 17.16,  6.5,  7.5, 14.4 ,  0,   0,   -3,      0,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //2 R2
  [17.16, 17.16,  6.5,  7.5, 13.6,   0,   0,    4,      0,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //3 R3DD
  [17.16, 17.16,  6.5, 7.75, 14.6,   0, .45,  -13,      0,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //4 R4
  [17.16, 17.16,  6.5, 7.75, 17.8 ,  0,-.25,   20,      0,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //5 R5

    //left outer column curved in
  [17.16, 17.16,  6.5,  7.5, 17.1,-.75,   0,   -4,     -8,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //6  R1L
  [17.16, 17.16,  6.5,  7.5, 14.8,-.75,   0,   -3,     -8,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //7  R2L
  [17.16, 17.16,  6.5,  7.5, 14.3,-.75,   0,    4,     -8,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //8  R3L
  [17.16, 17.16,  6.5, 7.75, 15.1,-.75, .45,  -13,     -8,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //9  R4L
  [17.16, 17.16,  6.5, 7.75, 17.8,-.75,-.25,   20,     -8,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //10 R5L

    //right outer column curved in
  [17.16, 17.16,  6.5,  7.5, 17.1, .75,   0,   -4,      8,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //11 R1R
  [17.16, 17.16,  6.5,  7.5, 14.8, .75,   0,   -3,      8,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //12 R2R
  [17.16, 17.16,  6.5,  7.5, 14.3, .75,   0,    4,      8,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //13 R3R
  [17.16, 17.16,  6.5, 7.75, 15.1, .75, .45,  -13,      8,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2], //14 R4R
  [17.16, 17.16,  6.5, 7.75, 17.8, .75,-.25,   20,      8,     0,   2,1.25,      1,      5,      1,    3.5,      2,      2]  //15 R5R

  //DES PLUS
  //[17.16, 17.16,  6.5,  6.5, 15.0,   0,   0,   10,      0,     0,   2,   2,      1,      5,      1,    3.5,      2,      2]  //R1 num
];

dishParameters = //dishParameter[keyID][ParameterID]
[ 
//FFwd1 FFwd2 FPit1 FPit2  DhDIn DhDFnF DhDFnB DhDif ArcIn FArcFn FArcEx  BFwd1 BFwd2 BPit1 BPit2 BArcFn BArcEx 
  //[ 4.8,  4  ,   18,  -79,     4,    2.3,   8.5,    15,     2,  4.8,  4  ,   18,  -71,   8.5,    15,     2,     2], //R3DD 
    [ 5.0,  3.5,   25,  -50,   5.0,      1,     1,   3.0,     9,  3.5,    2,  5.0,  3.5,    25,   -50,   4.5,     2]  //R1 deep
];

secondaryDishParam = 
[  
 //right TanIn FTanf BTanf  Fex Bex PhiInit FPhiFin BPhiFin Fkhifin Bkhifin //left   
 // [   1,    9,    9,    7, 2,   225,    205,    200,     7/(8),  7/8,  4.05,   3,    8,     2,   213,    195,   191,   80, 90], //R3DD 
  [   1,    9,    9,    7, 2,   225,    205,    200,     7/(8),  7/8,  4.05,   3,    8,     2,   213,    195,   191,   80, 90] //R1 deep
];
function BottomWidth(keyID)  = keyParameters[keyID][0];  //
function BottomLength(keyID) = keyParameters[keyID][1];  // 
function TopWidthDiff(keyID) = keyParameters[keyID][2];  //
function TopLenDiff(keyID)   = keyParameters[keyID][3];  //
function KeyHeight(keyID)    = keyParameters[keyID][4];  //
function TopWidShift(keyID)  = keyParameters[keyID][5];
function TopLenShift(keyID)  = keyParameters[keyID][6];
function XAngleSkew(keyID)   = keyParameters[keyID][7];
function YAngleSkew(keyID)   = keyParameters[keyID][8];
function ZAngleSkew(keyID)   = keyParameters[keyID][9];
function WidExponent(keyID)  = keyParameters[keyID][10];
function LenExponent(keyID)  = keyParameters[keyID][11];
function CapRound0i(keyID)   = keyParameters[keyID][12];
function CapRound0f(keyID)   = keyParameters[keyID][13];
function CapRound1i(keyID)   = keyParameters[keyID][14];
function CapRound1f(keyID)   = keyParameters[keyID][15];
function ChamExponent(keyID) = keyParameters[keyID][16];
function StemExponent(keyID) = keyParameters[keyID][17];

function FrontForward1(keyID) = dishParameters[keyID][0];  //
function FrontForward2(keyID) = dishParameters[keyID][1];  // 
function FrontPitch1(keyID)   = dishParameters[keyID][2];  //
function FrontPitch2(keyID)   = dishParameters[keyID][3];  //
function DishDepthInit(keyID) = dishParameters[keyID][4];  //
function DishDepthFinF(keyID) = dishParameters[keyID][5];  //
function DishDepthFinB(keyID) = dishParameters[keyID][6];  //
function DishHeightDif(keyID) = dishParameters[keyID][7];  //
function InitArc(keyID)       = dishParameters[keyID][8];
function FrontFinArc(keyID)   = dishParameters[keyID][9];
function FrontArcExpo(keyID)  = dishParameters[keyID][10];
function BackForward1(keyID)  = dishParameters[keyID][11];  //
function BackForward2(keyID)  = dishParameters[keyID][12];  // 
function BackPitch1(keyID)    = dishParameters[keyID][13];  //
function BackPitch2(keyID)    = dishParameters[keyID][14];  //
function BackFinArc(keyID)    = dishParameters[keyID][15];
function BackArcExpo(keyID)   = dishParameters[keyID][16];

function TanInit(keyID)                   = secondaryDishParam[keyID][0];
function ForwardTanFin(keyID)             = secondaryDishParam[keyID][1];
function BackTanFin(keyID)                = secondaryDishParam[keyID][2];
function ForwardTanArcExpo(keyID)         = secondaryDishParam[keyID][3];
function BackTanArcExpo(keyID)            = secondaryDishParam[keyID][4];
function TransitionAngleInit(keyID)       = secondaryDishParam[keyID][5];
function ForwardTransitionAngleFin(keyID) = secondaryDishParam[keyID][6];
function BackTransitionAngleFin(keyID)    = secondaryDishParam[keyID][7];
function ForwardFilRatio(keyID)           = secondaryDishParam[keyID][8];
function BackFilRatio(keyID)              = secondaryDishParam[keyID][9];

function TanInit2(keyID)                   = secondaryDishParam[keyID][9];
function ForwardTanFin2(keyID)             = secondaryDishParam[keyID][10];
function BackTanFin2(keyID)                = secondaryDishParam[keyID][11];
function TanArcExpo2(keyID)                = secondaryDishParam[keyID][12];
function TransitionAngleInit2(keyID)       = secondaryDishParam[keyID][13];
function ForwardTransitionAngleFin2(keyID) = secondaryDishParam[keyID][14];
function BackTransitionAngleFin2(keyID)    = secondaryDishParam[keyID][15];
function ForwardFilAngle2(keyID)           = secondaryDishParam[keyID][16];
function BackFilAngle2(keyID)              = secondaryDishParam[keyID][17];

function FrontTrajectory(keyID) = 
  [
    trajectory(forward = FrontForward1(keyID), pitch =  FrontPitch1(keyID)), //more param available: yaw, roll, scale
    trajectory(forward = FrontForward2(keyID), pitch =  FrontPitch2(keyID))  //You can add more traj if you wish 
  ];

function BackTrajectory (keyID) = 
  [
    trajectory(backward = BackForward1(keyID), pitch =  -BackPitch1(keyID)),
    trajectory(backward = BackForward2(keyID), pitch =  -BackPitch2(keyID)),
  ];

function SFrontTrajectory(keyID) = 
  [
    trajectory(forward = SFrontForward1(keyID), pitch =  SFrontPitch1(keyID)), //more param available: yaw, roll, scale
    trajectory(forward = SFrontForward2(keyID), pitch =  SFrontPitch2(keyID)),  //You can add more traj if you wish 
  ];

function SBackTrajectory (keyID) = 
  [
    trajectory(forward = SBackForward1(keyID), pitch =  SBackPitch1(keyID)),
    trajectory(forward = SBackForward2(keyID), pitch =  SBackPitch2(keyID)),
    trajectory(forward = 4, pitch =  -15),
    trajectory(forward = 6, pitch =  -5),
  ];
//------- function defining Dish Shapes
//helper function
function flip (singArry) = [for(i = [len(singArry)-1:-1:0]) singArry[i]];   
function mirrorX (singArry) = [for(i = [len(singArry)-1:-1:0]) [-singArry[i][0], singArry[i][1]]];   
function mirrorY (singArry) = [for(i = [len(singArry)-1:-1:0]) [singArry[i][0], -singArry[i][1]]];  
  
//function ()

function Fade (Arry1, Arry2, t, steps, pows) =len(Arry1)==len(Arry2) ? [for(i = [0:len(Arry1)-1]) (1-pow(t/steps, pows))*Arry1[i]+pow(t/steps, pows)*Arry2[i]]: [[0,0]];
  
function Mix (a, b, t, steps, pows)= (1-pow(t/steps, pows))*a+pow(t/steps, pows)*b;
function smoothStart (init, fin, t, steps, power) = 
  (1-pow(t/steps,power))*init + pow(t/steps,power)*fin ; 

function smoothStop (init, fin, t, steps, power) = 
  (fin-init)*(1-pow(1-t/steps,power))+init; 

function smoothStep (init, fin, t, steps) = 
  (fin - init)*(pow(t/steps,2)*3 - pow(t/steps,3)*2) + init; 

function smootherStep (init, fin, t, steps) = 
  (fin - init)*(6*pow(t/steps,5) - 15*pow(t/steps,4) +10* pow(t/steps,3)) + init; 

function smoothestStep (init, fin, t, steps) = 
  (fin - init)*(-20*pow(t/steps,7) + 70*pow(t/steps,6) - 84*pow(t/steps,5) +35*pow(t/steps,4)) + init; 
function ellipse(a, b, d = 0, rot1 = 0, rot2 = 360) = [for (n = [0:step])let (t = rot1 + n*(rot2-rot1)/step) [a*cos(t)+a, b*sin(t)*(1+d*cos(t))]]; //Centered at a apex to avoid inverted face

function DishShape (a,b, phi = 200, theta, r) = 
  concat(
//   [[c+a,b]],
    ellipse(a, b, d = 0, rot1 = 90, rot2 = phi),

    [for (n = [1:step/2])let(sig = atan(a*cos(phi)/-b*sin(phi)), t = theta*n/step*2)
     [ r*cos(-atan(-a*cos(phi)/b*sin(phi))-t)
      +a*cos(phi)
      -r*cos(sig)
      +a, 
    
       r*sin(-atan(-a*cos(phi)/b*sin(phi))-t)
      +b*sin(phi)
      +r*sin(sig)]
    ],


    [[a,b*sin(phi)-r*sin(theta)*2]] //bounday vertex to clear ends 
  );


function DishShape2 (a,b, phi = 200, theta, r, filRatio=1) = 
  concat(
//   [[c+a,b]],
    [[a,-(b*sin(phi)-r*sin(theta)*2)]], //bounday vertex to clear ends 

    mirrorY(
      [for (n = [1:step/2])let(sig = atan(a*cos(phi)/-b*sin(phi)), t = theta*n/step*2*filRatio)
        [ r*cos(-atan(-a*cos(phi)/b*sin(phi))-t) + a*cos(phi)
          -r*cos(sig) +a, 
      
          r*sin(-atan(-a*cos(phi)/b*sin(phi))-t) + b*sin(phi)
          +r*sin(sig)]
      ]),
    mirrorY(ellipse(a, b, d = 0,rot1 = 180, rot2 = phi)),
    ellipse(a, b, d = 0,rot1 = 180, rot2 = phi),

      [for (n = [1:step/2])let(sig = atan(a*cos(phi)/-b*sin(phi)), t = theta*n/step*2*filRatio)
        [r*cos(-atan(-a*cos(phi)/b*sin(phi))-t)
          +a*cos(phi)
          -r*cos(sig)
          +a, 
    
        r*sin(-atan(-a*cos(phi)/b*sin(phi))-t)
          +b*sin(phi)
        +r*sin(sig)]
      ],

    [[a,b*sin(phi)-r*sin(theta)*2]] //bounday vertex to clear ends 
  );


function oval_path(theta, phi, a, b, c, deform = 0) = [
 a*cos(theta)*cos(phi), //x
 c*sin(theta)*(1+deform*cos(theta)) , // 
 b*sin(phi),
]; 
  
path_trans2 = [for (t=[0:step:180])   translation(oval_path(t,0,10,15,2,0))*rotation([0,90,0])];


//--------------Function definng Cap 
function CapTranslation(t, keyID) = 
  [
    ((-t)/layers*TopWidShift(keyID)),   //X shift
    ((-t)/layers*TopLenShift(keyID)),   //Y shift
    (t/layers*KeyHeight(keyID))    //Z shift
  ];

function InnerTranslation(t, keyID) =
  [
    ((t)/layers*TopWidShift(keyID)),   //X shift
    ((t)/layers*TopLenShift(keyID)),   //Y shift
    (t/layers*(KeyHeight(keyID)-topthickness))    //Z shift
  ];

function CapRotation(t, keyID) =
  [
    ((-t)/layers*XAngleSkew(keyID)),   //X shift
    ((-t)/layers*YAngleSkew(keyID)),   //Y shift
    ((-t)/layers*ZAngleSkew(keyID))    //Z shift
  ];

function CapTransform(t, keyID) = 
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopWidthDiff(keyID)) + (1-pow(t/layers, WidExponent(keyID)))*BottomWidth(keyID) ,
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)) + (1-pow(t/layers, LenExponent(keyID)))*BottomLength(keyID)
  ];
function CapRoundness(t, keyID) = 
  [
    pow(t/layers, ChamExponent(keyID))*(CapRound0f(keyID)) + (1-pow(t/layers, ChamExponent(keyID)))*CapRound0i(keyID),
    pow(t/layers, ChamExponent(keyID))*(CapRound1f(keyID)) + (1-pow(t/layers, ChamExponent(keyID)))*CapRound1i(keyID)
  ];
  
function CapRadius(t, keyID) = pow(t/layers, ChamExponent(keyID))*ChamfFinRad(keyID) + (1-pow(t/layers, ChamExponent(keyID)))*ChamfInitRad(keyID);

function InnerTransform(t, keyID) = 
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, WidExponent(keyID)))*(BottomWidth(keyID) -wallthickness*2),
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, LenExponent(keyID)))*(BottomLength(keyID)-wallthickness*2)
  ];
  
function StemTranslation(t, keyID) =
  [
    ((t)/stemLayers*TopWidShift(keyID)),   //X shift
    ((t)/stemLayers*TopLenShift(keyID)),   //Y shift
    stemCrossHeight+.5+StemBrimDep + (t/stemLayers*(KeyHeight(keyID)- topthickness - stemCrossHeight-.1 -StemBrimDep))    //Z shift
  ];

function StemRotation(t, keyID) =
  [
    ((t)/stemLayers*XAngleSkew(keyID)),   //X shift
    ((t)/stemLayers*YAngleSkew(keyID)),   //Y shift
    ((t)/stemLayers*ZAngleSkew(keyID))    //Z shift
  ];

function StemTransform(t, keyID) =
  [
    pow(t/stemLayers, StemExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemWid - 2*slop),
    pow(t/stemLayers, StemExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)) + (1-pow(t/stemLayers, StemExponent(keyID)))*(stemLen - 2*slop)
  ];
  
function StemRadius(t, keyID) = pow(t/stemLayers,3)*3 + (1-pow(t/stemLayers, 3))*1;
  //Stem Exponent 
  
//

function FTanRadius(t, keyID) = pow(t/stepsize,ForwardTanArcExpo(keyID) )*ForwardTanFin(keyID) + (1-pow(t/stepsize, ForwardTanArcExpo(keyID) ))*TanInit(keyID);

function BTanRadius(t, keyID) = pow(t/stepsize,BackTanArcExpo(keyID) )*BackTanFin(keyID)  + (1-pow(t/stepsize, BackTanArcExpo(keyID) ))*TanInit(keyID);

function ForwardTanTransition(t, keyID) =(1-pow(t/stepsize, ForwardTanArcExpo(keyID)))*TransitionAngleInit(keyID) +  pow(t/stepsize,ForwardTanArcExpo(keyID))*ForwardTransitionAngleFin(keyID);

function BackTanTransition(t, keyID) = (1-pow(t/stepsize, BackTanArcExpo(keyID) ))*TransitionAngleInit(keyID)  +  pow(t/stepsize,BackTanArcExpo(keyID))*BackTransitionAngleFin(keyID);

///----- KEY Builder Module
module keycap(keyID = 0, cutLen = 0, visualizeDish = false, crossSection = CheckCross, Dish = true, SecondaryDish = false, Stem = false, StemRot = 0, homeDot = false, Stab = 0, Legends = false, Sym = false) {
  
  //Set Parameters for dish shape
  FrontPath = quantize_trajectories(FrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
  BackPath  = quantize_trajectories(BackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);
  
  //Scaling initial and final dim tranformation by exponents
  function FrontDishArc(t) =  pow((t)/(len(FrontPath)),FrontArcExpo(keyID))*FrontFinArc(keyID) + (1-pow(t/(len(FrontPath)),FrontArcExpo(keyID)))*InitArc(keyID); 
  function BackDishArc(t)  =  pow((t)/(len(FrontPath)),BackArcExpo(keyID))*BackFinArc(keyID) + (1-pow(t/(len(FrontPath)),BackArcExpo(keyID)))*InitArc(keyID);

  function DishDepthF(t, keyID, p) = pow((t)/(len(FrontPath)),p)*DishDepthFinF(keyID) + (1-pow(t/(len(FrontPath)),p))*DishDepthInit(keyID); 
  function DishDepthB(t, keyID, p) = pow((t)/(len(FrontPath)),p)*DishDepthFinB(keyID) + (1-pow(t/(len(FrontPath)),p))*DishDepthInit(keyID); 

  
  FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], 
    Sym ? DishShape2( a= DishDepthF(i, keyID, dishpow), b= FrontDishArc(i), phi = ForwardTanTransition(i, keyID) , theta= 60, r = FTanRadius(i, keyID), filRatio = ForwardFilRatio(keyID)) : DishShape( a= DishDepthF(i, keyID,dishpow), b= FrontDishArc(i), phi = ForwardTanTransition(i, keyID)  , theta= 60, r = FTanRadius(i, keyID), filRatio = ForwardFilRatio(keyID))
  ) ];  
  BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],
    Sym ? DishShape2(DishDepthB(i, keyID, dishpow), BackDishArc(i), phi = BackTanTransition(i, keyID), theta= 60, r = BTanRadius(i, keyID), filRatio = BackFilRatio(keyID)) : DishShape(DishDepthB(i, keyID, dishpow), BackDishArc(i), phi = BackTanTransition(i, keyID), theta= 60, r = BTanRadius(i, keyID), filRatio = BackFilRatio(keyID))
  ) ];  

  //builds
  difference(){
    union(){
      difference(){
        skin([for (i=[0:layers-1]) transform(translation(CapTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle_sym(CapTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]); //outer shell
        //Cut inner shell
        if(Stem == true){ 
          translate([0,0,-.001])skin([for (i=[0:layers-1]) transform(translation(InnerTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle_stem(InnerTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]);
        }
      }
      if(Stem == true){
        translate([0,0,StemBrimDep])rotate(stemRot)difference(){   
          //cylinderical Stem body 
          cylinder(d =5.5,KeyHeight(keyID)-StemBrimDep, $fn= 32);
          skin(StemCurve);
          skin(StemCurve2);
        }
        translate([0,0,-.001])skin([for (i=[0:stemLayers-1]) transform(translation(StemTranslation(i,keyID))*rotation(StemRotation(i, keyID)), elliptical_rectangle_stem(StemTransform(i, keyID),b=[5.5,5.5], fn=8))]); //Transition Support for taller profilea
     }
    //cut for fonts and extra pattern for light?
     if(visualizeDish == true && Dish == true){
      #translate([-TopWidShift(keyID),.0001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])
       rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      #translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])
       rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(BackCurve);
     }
    }
    
    //Cuts
    
    //Fonts
    if(cutLen != 0){
      translate([sign(cutLen)*(BottomLength(keyID)+CapRound0i(keyID)+abs(cutLen))/2,0,0])
        cube([BottomWidth(keyID)+CapRound1i(keyID)+1,BottomLength(keyID)+CapRound0i(keyID),50], center = true);
    }
    if(Legends ==  true){
      #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([-1,-5,KeyHeight(keyID)-2.5])
        linear_extrude(height = 1)text( text = "ver2", font = "Constantia:style=Bold", size = 3, valign = "center", halign = "center" );
      }
      
   //Dish Shape 
    if(Dish == true){
      translate([-TopWidShift(keyID),.0001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(BackCurve);

     if(SecondaryDish == true){
       #translate([BottomWidth(keyID)/2,-BottomLength(keyID)/2,KeyHeight(keyID)-SDishHeightDif(keyID)])
        rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(SBackCurve);
       mirror([1,0,0])translate([BottomWidth(keyID)/2,-BottomLength(keyID)/2,KeyHeight(keyID)-SDishHeightDif(keyID)])
        rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(SBackCurve);
     }
   }
     if(crossSection == true) {
       translate([0,-25,-.1])cube([15,50,15]); 
     }
  }
  //Homing dot
  if(homeDot == true)translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-.25])sphere(d = 1);
}

//------------------stems 

MXWid = 4.05/2+Tol; //horizontal length
MXLen = 4.05/2+Tol; //vertical length

MXWidT = 1.15/2+Tol; //horizontal thickness
MXLenT = 1.17/2+Tol; //vertical thickness

function stem_internal(sc=1) = sc*[
[MXLenT, MXLen],[MXLenT, MXWidT],[MXWid, MXWidT],
[MXWid, -MXWidT],[MXLenT, -MXWidT],[MXLenT, -MXLen],
[-MXLenT, -MXLen],[-MXLenT, -MXWidT],[-MXWid, -MXWidT],
[-MXWid,MXWidT],[-MXLenT, MXWidT],[-MXLenT, MXLen]
];  //2D stem cross with tolance offset and additonal transformation via jog 
//trajectory();
function StemTrajectory() = 
  [
    trajectory(forward = 5.25)  //You can add more traj if you wish 
  ];
  
  StemPath  = quantize_trajectories(StemTrajectory(),  steps = 1 , loop=false, start_position= $t*4);
  StemCurve  = [ for(i=[0:len(StemPath)-1])  transform(StemPath[i],  stem_internal()) ];

function StemTrajectory2() = 
  [
    trajectory(forward = .5)  //You can add more traj if you wish 
  ];
  
  StemPath2  = quantize_trajectories(StemTrajectory2(),  steps = 10, loop=false, start_position= $t*4);
  StemCurve2  = [ for(i=[0:len(StemPath2)-1])  transform(StemPath2[i]*scaling([(1.1-.1*i/(len(StemPath2)-1)),(1.1-.1*i/(len(StemPath2)-1)),1]),  stem_internal()) ]; 

module choc_stem(draftAng = 5) {
  stemHeight = 3.1;
  dia = .15;
  wids = 1.2/2;
  lens = 2.9/2; 
  module Stem() {
    difference(){
      translate([0,0,-stemHeight/2])linear_extrude(height = stemHeight)hull(){
        translate([wids-dia,-3/2])circle(d=dia);
        translate([-wids+dia,-3/2])circle(d=dia);
        translate([wids-dia, 3/2])circle(d=dia);
        translate([-wids+dia, 3/2])circle(d=dia);
      }
    //cuts
      translate([3.9,0])cylinder(d1=7+sin(draftAng)*stemHeight, d2=7,3.5, center = true, $fn = 64);
      translate([-3.9,0])cylinder(d1=7+sin(draftAng)*stemHeight,d2=7,3.5, center = true, $fn = 64);
    }
  }

  translate([5.7/2,0,-stemHeight/2+2])Stem();
  translate([-5.7/2,0,-stemHeight/2+2])Stem();
}

/// ----- helper functions 
function rotation2d(v=[0,0], rot=0) = [v[0]*cos(rot)-v[1]*sin(rot), v[0]*sin(rot)+v[1]*cos(rot)];
  
function rounded_rectangle_profile(size=[1,1],r=1,fn=32) = [
	for (index = [0:fn-1])
		let(a = index/fn*360) 
			r * [cos(a), sin(a)] 
			+ sign_x(index, fn) * [size[0]/2-r,0]
			+ sign_y(index, fn) * [0,size[1]/2-r]
];
//Mix (a, b, t, steps, pows)
  
function elliptical_rectangle_sym(a = [1,1], b =[1,1], fn=32) = [
    for (index = [0:fn-1]) // section right
     let(theta1 = -atan(a[1]/b[1])+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta1), a[1]*sin(theta1)]
    + [a[0]*cos(atan(b[0]/a[0])) , 0]
    - [b[1]*cos(atan(a[1]/b[1])) , 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    - [0, b[0]*sin(atan(b[0]/a[0]))]
    + [0, a[1]*sin(atan(a[1]/b[1]))],

    for(index = [0:fn-1]) // section left
     let(theta2 = -atan(a[1]/b[1])+180+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta2), a[1]*sin(theta2)]
    - [a[0]*cos(atan(b[0]/a[0])) , 0]
    + [b[1]*cos(atan(a[1]/b[1])) , 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + 180 + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    + [0, b[0]*sin(atan(b[0]/a[0]))]
    - [0, a[1]*sin(atan(a[1]/b[1]))]
]/2;

function elliptical_rectangle_stem(a = [1,1], b =[1,1], fn=32) = [
    for (index = [0:fn-1]) // section right
     let(theta1 = -atan(a[1]/b[1])+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta1), a[1]*sin(theta1)]
    + [a[0]*cos(atan(b[0]/a[0])) , 0]
    - [b[1]*cos(atan(a[1]/b[1])) , 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    - [0, b[0]*sin(atan(b[0]/a[0]))]
    + [0, a[1]*sin(atan(a[1]/b[1]))],

    for(index = [0:fn-1]) // section left
     let(theta2 = -atan(a[1]/b[1])+180+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta2), a[1]*sin(theta2)]
    - [a[0]*cos(atan(b[0]/a[0])) , 0]
    + [b[1]*cos(atan(a[1]/b[1])) , 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + 180 + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    + [0, b[0]*sin(atan(b[0]/a[0]))]
    - [0, a[1]*sin(atan(a[1]/b[1]))]
]/2;
function sign_x(i,n) = 
	i < n/4 || i > n-n/4  ?  1 :
	i > n/4 && i < n-n/4  ? -1 :
	0;

function sign_y(i,n) = 
	i > 0 && i < n/2  ?  1 :
	i > n/2 ? -1 :
	0;
lp_key = [
//     "base_sx", 18.5,
//     "base_sy", 18.5,
     "base_sx", 17.65,
     "base_sy", 16.5,
     "cavity_sx", 16.1,
     "cavity_sy", 14.9,
     "cavity_sz", 1.6,
     "cavity_ch_xy", 1.6,
     "indent_inset", 1.5
     ];
     
/*Tester */