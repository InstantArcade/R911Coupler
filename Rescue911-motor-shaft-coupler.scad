// Splined motor coupler for 
// helicopter toy on Rescue 911 Pinball
// by Instant Arcade - August 2023
//
// Note: Print on an SLA printer
// Printing with supports at an angle will help removal of part

outer_diameter_mm = 18;         // Some padding - incread this if you want a stronger part
inner_spline_length_mm = 15;    // Distance measured between ends of opposing splines
spline_pocket = 11;             // Diameter between opposing pockets between the splines
spline_width_mm = 2.1;          // Width of one spline

coupler_length = 14;            // As measured - can increase if you have a larger gap, or reduce if you want a looser fit

num_splines = 8;                // R911 parts have 8 splines


// splined center - This is a model of the splined connectors on each side of the mechanism
// We will use this as a boolean cutout of the coupler
module splined_center(sl,sp,sw,cl)
{
    cylinder( r = (sp)/2, center = true, h = cl, $fn=200 );
    
    angle = 360/num_splines;
    for( i = [0 : num_splines] )
    {
        rotate( angle*i, [0,0, 1] )
        {
            cube( [sl, sw, cl], center = true );
        }        
    }    
}


// coupler part - Tolerance is to provide a slightly looser fit and you may need to tweak this a bit more depending on your printer accuracy and/or resin properties
module coupler(tolerance) // 1.1 gave me a snug fit
{
    difference()
    {
        cylinder( r = (outer_diameter_mm*tolerance)/2, center = true, h = coupler_length*0.99, $fn=200 );
        splined_center(inner_spline_length_mm*tolerance, spline_pocket*tolerance, spline_width_mm*tolerance, coupler_length);
    }
}

// create the coupler
coupler(1.1);

// For testing, you can create/render the center part separately - but move it to the side first
/*
translate([outer_diameter_mm*1.1,0,0])
{
    splined_center(inner_spline_length_mm, spline_pocket, spline_width_mm, coupler_length);
}
*/


