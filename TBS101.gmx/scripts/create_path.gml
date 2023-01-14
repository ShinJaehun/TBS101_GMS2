// argument0 = the actor we're creating the path for
// argument1 = the destination node we want to end up at

current = argument1;
selectedActor = argument0;

// create priority queue
path = ds_priority_create();

// add current node to queue
ds_priority_add(path, current, current.G);

// step through each node, parent to parent, until done
while(current.parent != noone){
    //add parent node to queue, priority equal to parent's G score
    ds_priority_add(path, current.parent, current.parent.G);
    
    //set current equal to current's parent, ready to go again!
    current = current.parent;
}

do{
    // delete lowest priority node (closest to actor's) store id in current
    current = ds_priority_delete_min(path);
    
    // add current node's sprite coordinates to selectedActor's path
    path_add_point(selectedActor.movementPath, current.x, current.y, 100);    

}until(ds_priority_empty(path));

//clean up queue
ds_priority_destroy(path);


