// argument0 = actor whose buttons to creator

actor = argument0;
buttonList = ds_list_create();

if(actor.canAct){
    if(actor.firstLevelSlot > 0){
        for(ii = 0; ii < ds_list_size(actor.firstLevelSpellList); ii += 1){
            ds_list_add(buttonList, ds_list_find_value(actor.firstLevelSpellList, ii));
        }
    }
}

for (ii = 0; ii < ds_list_size(actor.defaultActions); ii += 1){
    ds_list_add(buttonList, ds_list_find_value(actor.defaultActions, ii));
}

buttonY = room_height - 48;
buttonX = room_width / 2  - ((ds_list_size(buttonList) - 1) * 48);

for (ii = 0; ii < ds_list_size(buttonList); ii += 1){
    button = ds_list_find_value(buttonList, ii);
    switch(button){
        // default actions
        case "end turn":
            with(instance_create(buttonX + (ii * 96), buttonY, oButton)){
                sprite_index = sButtonEndTurn;
                title = "END TURN";
                text = "Finish turn of current character";
                hotKey = "X";
            }
            break;

        // Cleric spells
        case "Bless":
            with(instance_create(buttonX + (ii * 96), buttonY, oButton)){
                title = "BLESS";
                text = "Give all party members a small bonus to attack and save rolls#1d4 bonus (5 rounds)";
                hotKey = string(other.ii + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }    
            break;

        case "Guiding Bolt":
            with(instance_create(buttonX + (ii * 96), buttonY, oButton)){
                title = "GUIDING BOLT";
                text = "right click an enemy to fire an illuminating bolt!#4d6 RADIANT damage#bonus on next attack against target!";
                hotKey = string(other.ii + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }    
            break;
                    
        case "Healing Word":
            with(instance_create(buttonX + (ii * 96), buttonY, oButton)){
                title = "HEALING WORD";
                text = "right click an ally in range to heal them#1d8" + string(other.actor.wisMod) + " HEALING";
                hotKey = string(other.ii + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }    
            break;
        
            
        // Wizard spells
        case "Acid Orb":
            with(instance_create(buttonX + (ii * 96), buttonY, oButton)){
                title = "ACID ORB";
                text = "right click and enemy to fire an orb of deadly acid!#3d10 ACID damage#ongoing burn";
                hotKey = string(other.ii + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }    
            break;

        
        case "Burning Hands":
            with(instance_create(buttonX + (ii * 96), buttonY, oButton)){
                title = "BURNING HANDS";
                text = "right click a square in range to emit a cone of flames!#3d6 FIRE damage (AOE)";
                hotKey = string(other.ii + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }    
            break;

        case "Magic Missiles":
            with(instance_create(buttonX + (ii * 96), buttonY, oButton)){
                title = "MAGIC MISSILES";
                text = "fire a magic missile at each visible enemy#1d4+1 FORCE damage#cannot miss!";
                hotKey = string(other.ii + 1);
                spell = true;
                spellSlot = string(other.actor.firstLevelSlot);
            }    
            break;       
    }
}

ds_list_destroy(buttonList);
