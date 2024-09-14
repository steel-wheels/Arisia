// AMAZING
//
// Converted from BASIC to Javascript by Oscar Toledo G. (nanochess)
// Converted from JavaScript to TypeScript by Steel Wheels Project
// Reference: https://github.com/coding-horror/basic-computer-games
//            02_Amazing
//

/// <reference path="types/ArisiaPlatform.d.ts"/>

function tab(space: number)
{
    var str = "";
    while (space-- > 0)
        str += " ";
    return str;
}


// Main program
function main(argv: string[])
{

	console.print(tab(28) + "AMAZING PROGRAM\n");
	console.print(tab(15) + "CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY\n");
	console.print("\n");
	console.print("\n");
	console.print("\n");
	console.print("FOR EXAMPLE TYPE 10,10 AND PRESS ENTER\n");
	console.print("\n");

	let h  = 0 ;
	let v2 = 0 ;
	while (true) {
		console.print("WHAT ARE YOUR WIDTH AND LENGTH: ");
        	let a  = readline();
        	h  = parseInt(a);
        	v2 = parseInt(a.substr(a.indexOf(",") + 1));
		if (h > 1 && v2 > 1)
			break;
		console.print("MEANINGLESS DIMENSIONS.  TRY AGAIN.\n");
	}
    	let w: number[][] = new Array(h+1) ;
	let v: number[][] = new Array(h+1) ;
	for (let i = 1; i <= h; i++) {
		w[i] = new Array(v2+1) ;
		v[i] = new Array(v2+1) ;
		for (let j = 1; j <= v2; j++) {
		    w[i][j] = 0;
		    v[i][j] = 0;
		}
	}

	console.print("\n");
	console.print("\n");
	console.print("\n");
	console.print("\n");
	let q = 0;
	let z = 0;
	let x = Math.floor(Math.random() * h + 1);
	for (let i = 1; i <= h; i++) {
        	if (i == x)
			console.print(".  ");
        	else
            		console.print(".--");
	}
	console.print(".\n");
	let c = 1;
	w[x][1] = c;
	c++;
	let r     = x;
	let s     = 1;
	let entry = 0;
	while (true) {
		if (entry == 2) {	// Search for a non-explored cell
		    do {
			if (r < h) {
			    r++;
			} else if (s < v2) {
			    r = 1;
			    s++;
			} else {
			    r = 1;
			    s = 1;
			}
		    } while (w[r][s] == 0) ;
		}
		if (entry == 0 && r - 1 > 0 && w[r - 1][s] == 0) {	// Can go left?
		    if (s - 1 > 0 && w[r][s - 1] == 0) {	// Can go up?
			if (r < h && w[r + 1][s] == 0) {	// Can go right?
			    // Choose left/up/right
			    x = Math.floor(Math.random() * 3 + 1);
			} else if (s < v2) {
			    if (w[r][s + 1] == 0) {	// Can go down?
				// Choose left/up/down
				x = Math.floor(Math.random() * 3 + 1);
				if (x == 3)
				    x = 4;
			    } else {
				x = Math.floor(Math.random() * 2 + 1);
			    }
			} else if (z == 1) {
			    x = Math.floor(Math.random() * 2 + 1);
			} else {
			    q = 1;
			    x = Math.floor(Math.random() * 3 + 1);
			    if (x == 3)
				x = 4;
			}
		    } else if (r < h && w[r + 1][s] == 0) {	// Can go right?
			if (s < v2) {
			    if (w[r][s + 1] == 0) {	// Can go down?
				// Choose left/right/down
				x = Math.floor(Math.random() * 3 + 1);
			    } else {
				x = Math.floor(Math.random() * 2 + 1);
			    }
			    if (x >= 2)
				x++;
			} else if (z == 1) {
			    x = Math.floor(Math.random() * 2 + 1);
			    if (x >= 2)
				x++;
			} else {
			    q = 1;
			    x = Math.floor(Math.random() * 3 + 1);
			    if (x >= 2)
				x++;
			}
		    } else if (s < v2) {
			if (w[r][s + 1] == 0) {	// Can go down?
			    // Choose left/down
			    x = Math.floor(Math.random() * 2 + 1);
			    if (x == 2)
				x = 4;
			} else {
			    x = 1;
			}
		    } else if (z == 1) {
			x = 1;
		    } else {
			q = 1;
			x = Math.floor(Math.random() * 2 + 1);
			if (x == 2)
			    x = 4;
		    }
		} else if (s - 1 > 0 && w[r][s - 1] == 0) {	// Can go up?
		    if (r < h && w[r + 1][s] == 0) {
			if (s < v2) {
			    if (w[r][s + 1] == 0)
				x = Math.floor(Math.random() * 3 + 2);
			    else
				x = Math.floor(Math.random() * 2 + 2);
			} else if (z == 1) {
			    x = Math.floor(Math.random() * 2 + 2);
			} else {
			    q = 1;
			    x = Math.floor(Math.random() * 3 + 2);
			}
		    } else if (s < v2) {
			if (w[r][s + 1] == 0) {
			    x = Math.floor(Math.random() * 2 + 2);
			    if (x == 3)
				x = 4;
			} else {
			    x = 2;
			}
		    } else if (z == 1) {
			x = 2;
		    } else {
			q = 1;
			x = Math.floor(Math.random() * 2 + 2);
			if (x == 3)
			    x = 4;
		    }
		} else if (r < h && w[r + 1][s] == 0) {	// Can go right?
		    if (s < v2) {
			if (w[r][s + 1] == 0)
			    x = Math.floor(Math.random() * 2 + 3);
			else
			    x = 3;
		    } else if (z == 1) {
			x = 3;
		    } else {
			q = 1;
			x = Math.floor(Math.random() * 2 + 3);
		    }
		} else if (s < v2) {
		    if (w[r][s + 1] == 0) 	// Can go down?
			x = 4;
		    else {
			entry = 2;	// Blocked!
			continue;
		    }
		} else if (z == 1) {
		    entry = 2;	// Blocked!
		    continue;
		} else {
		    q = 1;
		    x = 4;
		}
		if (x == 1) {	// Left
		    w[r - 1][s] = c;
		    c++;
		    v[r - 1][s] = 2;
		    r--;
		    if (c == h * v2 + 1)
			break;
		    q = 0;
		    entry = 0;
		} else if (x == 2) {	// Up
		    w[r][s - 1] = c;
		    c++;
		    v[r][s - 1] = 1;
		    s--;
		    if (c == h * v2 + 1)
			break;
		    q = 0;
		    entry = 0;
		} else if (x == 3) {	// Right
		    w[r + 1][s] = c;
		    c++;
		    if (v[r][s] == 0)
			v[r][s] = 2;
		    else
			v[r][s] = 3;
		    r++;
		    if (c == h * v2 + 1)
			break;
		    entry = 1;
		} else if (x == 4) {	// Down
		    if (q != 1) {	// Only if not blocked
			w[r][s + 1] = c;
			c++;
			if (v[r][s] == 0)
			    v[r][s] = 1;
			else
			    v[r][s] = 3;
			s++;
			if (c == h * v2 + 1)
			    break;
			entry = 0;
		    } else {
			z = 1;
			if (v[r][s] == 0) {
			    v[r][s] = 1;
			    q = 0;
			    r = 1;
			    s = 1;
			    while (w[r][s] == 0) {
				if (r < h) {
				    r++;
				} else if (s < v2) {
				    r = 1;
				    s++;
				} else {
				    r = 1;
				    s = 1;
				}
			    }
			    entry = 0;
			} else {
			    v[r][s] = 3;
			    q = 0;
			    entry = 2;
			}
		    }
		}
	}

    for (let j = 1; j <= v2; j++) {
        let str = "I";
        for (let i = 1; i <= h; i++) {
            if (v[i][j] < 2)
                str += "  I";
            else
                str += "   ";
        }
        console.print(str + "\n");
        str = "";
        for (let i = 1; i <= h; i++) {
            if (v[i][j] == 0 || v[i][j] == 2)
                str += ":--";
            else
                str += ":  ";
        }
        console.print(str + ".\n");
    }
// If you want to see the order of visited cells
//    for (j = 1; j <= v2; j++) {
//        str = "I";
//        for (i = 1; i <= h; i++) {
//            str += w[i][j] + " ";
//        }
//        print(str + "\n");
//    }
}

