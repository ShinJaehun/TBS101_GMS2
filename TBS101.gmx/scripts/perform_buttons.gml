// argument0 = the actor performing the action
// argument1 = the button to be performed

actor = argument0;
button = argument1;

switch(button.title){
    // default actions
    case "END TURN":
        actor.state = "begin action";
        actor.readiedAction = "END TURN";
        actor.targetingType = "none";
        
        with(instance_create(room_width / 2, room_height, oConfirmButton)){
            title = other.button.title;
            text = other.button.text;
            hotKey = other.button.hotKey;
        }
        wipe_nodes();
        wipe_buttons();
        break;
        
    // Cleric spells
    case "HEALING WORD":
        actor.state = "begin action";
        actor.readiedAction = "Healing Word";
        actor.targetingType = "visible allies";
        actor.actionRange = 640;
        with(instance_create(room_width / 2, room_height, oConfirmBox)){
            title = other.button.title;
            text = other.button.text;
        }
        wipe_nodes();
        wipe_buttons();
        break;
            
    // Wizard spells
    case "BURNING HANDS":
        actor.state = "begin action";
        actor.readiedAction = "Burning Hands";
        actor.targetingType = "cone";
        actor.actionRange = 96;
        
        with(instance_create(room_width / 2, room_height, oConfirmBox)){
            title = other.button.title;
            text = other.button.text;

        }
        
        wipe_nodes();
        wipe_buttons();
        break;

    case "MAGIC MISSILES":
        actor.state = "begin action";
        actor.readiedAction = "Magic Missiles";
        actor.targetingType = "visible enemies";
        actor.actionRange = 640;
        
        with(instance_create(room_width / 2, room_height, oConfirmButton)){
            title = other.button.title;
            text = other.button.text;
            hotKey = other.button.hotKey;
        }
        
        wipe_nodes();
        wipe_buttons();
        break;
         
            
}
