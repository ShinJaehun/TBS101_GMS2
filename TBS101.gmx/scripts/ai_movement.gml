// argument0 - start node
// argument1 - goal node

with(oNode){
    parent = noone;
    G = 0;
}

start = argument0;
goal = argument1;

open = ds_priority_create();
closed = ds_list_create();

ds_priority_add(open, start, 0);
ds_list_add(closed, start);

while(ds_priority_size(open) > 0){
    current = ds_priority_delete_min(open);
    
    if(current = goal){
        break;
    }
    
    for(ii = 0; ii < ds_list_size(current.neighbors); ii += 1){
        neighbor = ds_list_find_value(current.neighbors, ii);
        
        if(neighbor.occupant == noone && neighbor.passable){
            costMod = 1;
            
            if(neighbor.x != current.x && neighbor.y != current.y){
                costMod = 1.5;
            }
            
            tempCost = neighbor.cost * costMod;
            tempCost += current.G;
            
            if(ds_list_find_index(closed, neighbor) < 0 || tempCost < neighbor.G){
                neighbor.G = tempCost;
                priority = tempCost + heuristic(goal, neighbor);
                ds_priority_add(open, neighbor, priority);
                neighbor.parent = current;
                ds_list_add(closed, neighbor);
            }
        }
    }
}

while(ds_priority_size(open) > 0){
    current = ds_priority_delete_min(open);
    
    for(ii = 0; ii < ds_list_size(current.neighbors); ii += 1){
        neighbor = ds_list_find_value(current.neighbors, ii);
        
        if(neighbor.occupant == noone && neighbor.passable){
            costMod = 1.5;
        }
        
        tempCost = neighbor.cost * costMod;
        tempCost += current.G;
        
        if(ds_list_find_index(closed, neighbor) < 0 || tempCost < neighbor.G){
            neighbor.G = tempCost;
            neighbor.parent = current;
            ds_list_add(closed, neighbor);
        }
    }
}
