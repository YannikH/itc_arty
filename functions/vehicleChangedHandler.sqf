params ["_player", "_newVehicle"];

if (isNull _newVehicle) exitWith {};
_capable = (configFile >> "CfgVehicles" >> (typeOf _newVehicle) >> "itc_arty" >> "type")  call BIS_fnc_getCfgData;
if(isNil {_capable}) exitWith {};

[{
    _vehicle = vehicle player;

    //check if the player is in a compatible vehicle and is the gunner
    _capable = (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "itc_arty" >> "type")  call BIS_fnc_getCfgData;
    if(isNil {_capable}) exitWith {
        [_this select 1] call CBA_fnc_removePerFrameHandler;
        //instantly undraw the text instead of letting it fade
        ["",-0.15,0.88,1,0,0, 793] spawn BIS_fnc_dynamicText;
        ["",-0.15,0.88,1,0,0, 794] spawn BIS_fnc_dynamicText;
        ["",-0.15,0.88,1,0,0, 795] spawn BIS_fnc_dynamicText;
        ["",-0.15,0.88,1,0,0, 796] spawn BIS_fnc_dynamicText;
    };

    _inSight = (cameraView == "GUNNER");
    if(_inSight && player == gunner _vehicle) then {
        //display the current charge
        weaponState [_vehicle, [0]] params ["_weapon", "_muzzle", "_firemode", "_magazine", "_ammoCount"];
        [format ["<t color='#ffffff' size = '1'>%1</t>",_firemode],0.15,0.757,1,0,0, 793] spawn BIS_fnc_dynamicText;

        //display the current vehicle direction
        _vehicleDirMils = (getDir _vehicle) / 360 * 6400;
        [format ["<t color='#ffffff' size = '1'>%1</t>",format["Dir %1",round _vehicleDirMils]],-0.15,0.88,1,0,0, 794] spawn BIS_fnc_dynamicText;

        //display the current gun deflection
        _turretDir = ((vehicle player) animationPhase "mainturret" )* 180 / pi;
        _turretDirMils = _turretDir / 360 * 6400;
        [format ["<t color='#ffffff' size = '1'>%1</t>",format["DF %1",round (_turretDirMils + 3200)]],0.15,0.82,1,0,0, 795] spawn BIS_fnc_dynamicText;

        //display the current gun elevation
        private _lookVector = ((positionCameraToWorld [0,0,0]) call ace_common_fnc_positionToASL) vectorFromTo ((positionCameraToWorld [0,0,10]) call ace_common_fnc_positionToASL);
        _realAzimuth = ((_lookVector select 0) atan2 (_lookVector select 1));
        private _upVectorDir = (((vectorUp _vehicle) select 0) atan2 ((vectorUp _vehicle) select 1));
        private _elevationDiff = (cos (_realAzimuth - _upVectorDir)) * acos ((vectorUp _vehicle) select 2);
        _realElevation = ((180 / PI) * (_vehicle animationPhase "mainGun")) + 0 - _elevationDiff;
        [format ["<t color='#ffffff' size = '1'>%1</t>",format["QD %1",round (_realElevation / 360 * 6400)]],0.15,0.88,1,0,0, 796] spawn BIS_fnc_dynamicText;
    }
}, 0, [_newVehicle]] call CBA_fnc_addPerFrameHandler;