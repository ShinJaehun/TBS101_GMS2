// argument0 - node id to color
// argument1 - selectedActor's move
// argument2 - selectedActor's actions

var node, move, actions;

node = argument0;
move = argument1;
actions = argument2;

if (actions > 1) {
    if (node.G > move) {
        node.color = c_yellow;    
    } else {
        node.color = c_aqua;
    }
} else {
    node.color = c_yellow;
}
