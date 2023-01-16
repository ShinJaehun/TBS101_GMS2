// argument0 = the actor performing the action
// argument1 = the button to be performed

actor = argument0;
button = argument1;

switch(button.title){
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
}
