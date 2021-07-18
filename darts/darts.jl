
# Euclidean distance between two points of the plane with Cartesian coordinates:
#  d = sqrt( (x2-x1)² + (y2-y1)² )
# Since (x1, y1) is the origin (0, 0), we got:
#  d = sqrt( x² + y² = r² ) with r corresponding to the radius of the circle
#  drawn by every points landing on the plane at that distance to the origin.

using Match
function score(x, y)
    r² = x^2 + y^2
    @match r² begin
        r², if      r² >  100 end => 0
        r², if 25 < r² <= 100 end => 1
        r², if  1 < r² <= 25  end => 5
        r², if      r² <= 1   end => 10
    end
end
