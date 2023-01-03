// argument0 - origin node, the node to pathfind from
// argument1 - unit's movement range
// argument2 = unit's remaining actions

// reset all node data
wipe_nodes();

var open, closed; // DS
var start, current, neighbor; // instance ID
var tempG, range, costMod;

// declare relevant variables from arguments
start = argument0;
range = argument1 * argument2;

// create data structures
open = ds_priority_create(); // list인데 number가 붙음
closed = ds_list_create();

// add starting node to the open list
ds_priority_add(open, start, start.G) // g가 priority

// while open queue is not empty... repeat the following until all nodes have been looked at
while(ds_priority_size(open) > 0) {
    // remove node with lowest G score from open
    current = ds_priority_delete_min(open);
    
    // add that node to the closed list
    ds_list_add(closed, current);
    
    // step through all of current's neighbors : 여기서 정확히 neighbnr가 어디까지를 의미하는건가?
    for(ii = 0; ii < ds_list_size(current.neighbors); ii += 1) {
        // store current neighbor in neighbor variables
        neighbor = ds_list_find_value(current.neighbors, ii);
        
        // add neighbor to open list if it qualifies : 
        // neighbor is passable,
        // neibhbor has not occupant,
        // neighbor's projected G score is less than movement range
        // neighbor isn't already on the closed list
        if(ds_list_find_index(closed, neighbor) < 0 && neighbor.passable && neighbor.occupant == noone && neighbor.cost + current.G <= range){
            // only calculate a new G score for neighbor
            // if it hasn't already been calculated
            if (neighbor.G == 0) {
            //if (ds_priority_find_priority(open, neighbor) == 0 | ds_priority_find_priority(open, neighbor) == undefined) {
                costMod = 1;
                
                //give neighbor the appopriate parent
                neighbor.parent = current;
                
                // if node is diagnal, create appropriate costMod
                if(neighbor.gridX != current.gridX && neighbor.gridY != current.gridY) {
                    costMod = 1.5;
                }
                
                //calcuaate G score of neighbor, with costMod in place
                neighbor.G = current.G + (neighbor.cost * costMod);
                
                // add neighbor to the open list so it can be checked out too!
                ds_priority_add(open, neighbor, neighbor.G);
            } else { // else if neighbor's score has already been calculated for the open list
                // figure out if the neighbor's score would be Lower if found from the current node!
                costMod = 1;
                
                // if node is diagnal, create appropriate costMod
                if(neighbor.gridX != current.gridX && neighbor.gridY != current.gridY) {
                    costMod = 1.5;
                }
                
                tempG = current.G + (neighbor.cost * costMod);
                
                // check if G score would be lower
                if (tempG < neighbor.G) {
                    neighbor.parent = current;
                    neighbor.G = tempG;
                    ds_priority_change_priority(open, neighbor, neighbor.G);
                }
            }
        }        
    }
}

// round down all G scores for movement calculations!
with(oNode) {
    G = floor(G);
}

// super important
ds_priority_destroy(open);

// color all those move nodes then destroy the closed list as well
for(ii = 0; ii < ds_list_size(closed); ii += 1) {
    current = ds_list_find_value(closed, ii);
    current.moveNode = true;
    
    color_move_node(current, argument1, argument2);

}

// destory 
ds_list_destroy(closed);



