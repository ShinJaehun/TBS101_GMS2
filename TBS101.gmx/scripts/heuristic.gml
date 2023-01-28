// finds manhattan distance between two points
// argument0 - goal node
// argument1 - current node

goal = argument0;
node = argument1;

temp = abs(goal.gridX - node.gridX) + abs(goal.gridY - node.gridY);

return(temp);

