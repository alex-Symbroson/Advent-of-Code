
// https://dirask.com/posts/JavaScript-calculate-intersection-point-of-two-lines-for-given-4-points-VjvnAj
func intersectLines(_ p1:Point, _ p2:Point, _ p3:Point, _ p4:Point) -> Point?
{
    let c2x = p3.x - p4.x;
  	let c3x = p1.x - p2.x;
  	let c2y = p3.y - p4.y;
  	let c3y = p1.y - p2.y;
    
  	// down part of intersection point formula
  	let d  = c3x * c2y - c3y * c2x;
    
  	if (d == 0) { return nil }
    
  	// upper part of intersection point formula
  	let u1 = p1.x * p2.y - p1.y * p2.x; // (x1 * y2 - y1 * x2)
  	let u4 = p3.x * p4.y - p3.y * p4.x; // (x3 * y4 - y3 * x4)
    
    // intersection point formula
    let px = (u1 &* c2x - c3x &* u4) / d;
    let py = (u1 &* c2y - c3y &* u4) / d;

    return Point(x:px, y:py)
}

