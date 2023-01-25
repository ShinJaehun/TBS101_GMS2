//argument0 - id of actor making the atack
//argument1 - id of the target

actor = argument0;
target = argument1;
roll = actor.attackRoll;
status = "miss";

if(target.guidingBolt){
    roll = max(roll, irandom_range(1, 20));
    target.guidingBolt = false;
}

if(actor.attackRoll == 20) {
    status = "crit";
} else {
    if(actor.blessed > 0){
        roll += irandom_range(1, 4);
    }

    if(roll + actor.hitBonus >= target.armorClass){
        status = "hit";
    } else {
        status = "miss";
    }
}

return status;
