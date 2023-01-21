// argument0 - actor performing the action
// argument1 - action to be performed

actor = argument0;
action = argument1;

switch(action){
    // default actions
    case "END TURN":
        actor.state = "end turn";
        actor.actionTimer = 20;
        break;
    // Cleric spells
    case "Healing Word":
        target = oCursor.hoverNode.occupant;
        heal = irandom_range(1, 8) + actor.wisMod;
        heal = min(heal, target.maxHitPoints - target.hitPoints); // 여기에 heal을 두번 쓰는데....
        
        target.hitPoints += heal;
        
        with(instance_create(target.x + 20, target.y + 4, oDamageText)){
            ground = y;
            text = "+" + string(other.heal);
            color = c_lime;
        }
        actor.firstLevelSlot -= 1;
        actor.canAct = false;
        actor.actions -= 1;
        actor.state = "end turn";
        actor.actionTimer = 15;
        
        break;
    
    // Wizard spells
    case "Burning Hands":
        targets = ds_list_create();
        damage = 0;
        
        for(ii = 0; ii < 3; ii += 1){
            damage += irandom_range(1, 6);
        }
        
        with(oNode){
            if(actionNode){
                ds_list_add(other.targets, id);
            }
        }
        
        for(ii = 0; ii < ds_list_size(targets); ii += 1){
            node = ds_list_find_value(targets, ii);
            
            with(instance_create(node.x + 16, node.y + 16, oFlameEmitter)){
                target = other.node.occupant;
                saveDC = other.actor.spellSaveDC;
                damage = other.damage;
            }
        }
        
        ds_list_destroy(targets);
        
        actor.firstLevelSlot -= 1;
        actor.canAct = false;
        actor.actions -= 1;
        actor.state = "end actions";
        actor.actionTimer = 30;
               
        break;

    case "Magic Missiles":
        targets = ds_list_create();
        
        with(oNode){
            if(actionNode){
                ds_list_add(other.targets, id);
            }
        }
        
        for(ii = 0; ii < ds_list_size(targets); ii += 1){
            target = ds_list_find_value(targets, ii).occupant;
            with(instance_create(actor.x + 16, actor.y + 16, oArrow)){
                target = other.target;
                status = "hit";
                damage = irandom_range(1, 4) + 1;
                damageType = "force";
                path_add_point(movementPath, other.actor.x + 16, other.actor.y + 16, 100);
                path_add_point(movementPath, other.target.x + 16, other.target.y + 16, 100);
                path_start(movementPath, speed, true, true);
            }
        }

        ds_list_destroy(targets);
        
        actor.firstLevelSlot -= 1;
        actor.canAct = false;
        actor.actions -= 1;
        actor.state = "end actions";
        actor.actionTimer = 30;
                
        break;

}














